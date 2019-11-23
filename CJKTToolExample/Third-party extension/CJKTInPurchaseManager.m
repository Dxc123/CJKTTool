//
//  CJKTInPurchaseManager.m
//  橙子数学
//
//  Created by MacBook on 2018/2/5.
//  Copyright © 2018年 杭州秀铂科技网络有限公司. All rights reserved.
//

#import "CJKTInPurchaseManager.h"
#import "CJKTTool.h"
@interface CJKTInPurchaseManager() {
    
    NSString *_productStr;
    NSString *_transID;
    NSString *_receiptString;
    SKPaymentTransaction *_transPay;
    NSString *_orderId;
    NSString *_fee;
    
}



@end

@implementation CJKTInPurchaseManager

+ (instancetype)sharePayManager {
    
    static CJKTInPurchaseManager *payManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        payManager = [[super allocWithZone:NULL] init];

        
    });
    
    return payManager;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [CJKTInPurchaseManager sharePayManager];
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return [CJKTInPurchaseManager sharePayManager];
    
}
#pragma mark -- 内购初始化方法

- (void)buy:(NSInteger)type orderId:(NSString *)orderid fee:(NSString *)fee
{
    
    _orderId = orderid;
    _fee = fee;
    
    //判断是否支持IAP支付
    if (![SKPaymentQueue canMakePayments]) {
        
        if(self.UnpermissionBlock) {
            
            self.UnpermissionBlock();
            
        }
        
    } else {
#if DEBUG
        NSLog(@"允许程序内付费购买");
#endif
       
        [self requestProductDataWith:type];
    }
}



#pragma mark -- 判断内购产品类型并发起购买
- (void)requestProductDataWith:(NSInteger)type
{

    if (type == IAP0p100) {
       
        _productStr = ProduceID_IAP0p100;
        
    } else if (type == IAP1p300) {
        
        _productStr = ProduceID_IAP1p300;
        
    } else if (type == IAP2p500) {
        
        _productStr = ProduceID_IAP2p500;
        
    } else if (type == IAP3p1000) {
        
        _productStr = ProduceID_IAP3p1000;
        
    } else if (type == IAP4p2000) {
        
        _productStr = ProduceID_IAP4p2000;
        
    } else if (type == IAP5p3000){
        
        _productStr = ProduceID_IAP5p3000;
        
    } else if (type == IAP5p3998) {
        
        _productStr = ProduceID_IAP5p3998;
        
    } else if(type == IAP5p4998) {
        
        _productStr = ProduceID_IAP5p4998;
        
    } else if(type == IAP5p5898) {
        
        _productStr =ProduceID_IAP5p5898;
        
    }
    
    if(![IAPShare sharedHelper].iap) {
        
        NSSet *set = [[NSSet alloc] initWithObjects:ProduceID_IAP0p100,ProduceID_IAP1p300,ProduceID_IAP2p500,ProduceID_IAP3p1000,ProduceID_IAP4p2000,ProduceID_IAP5p3000,ProduceID_IAP5p3998,ProduceID_IAP5p4998,ProduceID_IAP5p5898, nil];
        //   IAPHelperinit 初始化 Product Identifiers
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:set];;
    }
   [IAPShare sharedHelper].iap.production = NO;
    
    // 向苹果服务器发送请求 ，请求所有可买的商品
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest *request, SKProductsResponse *response) {
       
        if (response.products.count > 0) {

            for (SKProduct *product in response.products) {

                if([product.productIdentifier isEqualToString:self->_productStr]) {//判断产品ID一致时发起购买
                    
                    //发起购买
                    [[IAPShare sharedHelper].iap buyProduct:product onCompletion:^(SKPaymentTransaction *transcation) {

                        self->_transPay = transcation;
                        
                        if(!transcation.error) {
 
                            //从沙盒中获取交易凭证并且拼接成请求体数据
                            NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
//                            NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
                            //先向苹果服务器验证
                            [[IAPShare sharedHelper].iap checkReceipt:[NSData dataWithContentsOfURL:receiptUrl] onCompletion:^(NSString *response, NSError *error) {
#if DEBUG
                                NSLog(@"苹果服务器返回验证结果 %@",response);
#endif
                            }];
                            
                            
                           
//                         _receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                    //系统IOS7.0以上获取支付验证凭证的方式应该改变，切验证返回的数据结构也不一样了。
                           //获取receipt_data
                            NSString *version = [UIDevice currentDevice].systemVersion;
                            if([version intValue] >= 7.0){
                                // 验证凭据，获取到苹果返回的交易凭据
                                // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
                                NSURLRequest * appstoreRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle]appStoreReceiptURL]];
                                NSError *error = nil;
                                NSData * receiptData = [NSURLConnection sendSynchronousRequest:appstoreRequest returningResponse:nil error:&error];
                                self->_receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                                
                            }else{
                                
                                NSData * receiptData = transcation.transactionReceipt;
                                //  transactionReceiptString = [receiptData base64EncodedString];
                                self->_receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                            }
                            
                            //获取transaction_id
                            self->_transID  = transcation.transactionIdentifier;
                            
                            
                            // 在向自己的服务器验证
                            [self VerifyWithOurServer];
                            
                        }else {
#if DEBUG
                           NSLog(@"Fail %@",[transcation.error localizedDescription]);
#endif
                             [CJKTTool showAlertViewWithMessage:transcation.error.localizedDescription presentViewController:nil];
                            
                        }
                        
                        if(self.payCompelete) {
                            self.payCompelete(transcation.error);
                        }
                        
                    }];
                    
                    break;
                    
                }

            }
            
            
        }else {
            
            if(self.payCompelete) {
                
                self.payCompelete(nil);
                
            }
            
        }
        
    }];
}

#pragma mark -- 向自己的服务器验证

- (void)VerifyWithOurServer{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:7];
    
    [dic setObject:_orderId forKey:@"orderid"];
    [dic setObject:_fee forKey:@"fee"];
    [dic setObject:_transID forKey:@"trade_no"];
    [dic setObject:_receiptString forKey:@"receipt_data"];
    [dic setObject:_productStr forKey:@"product_id"];//新增的验证字段
    

    NSString *version = [self getBundleInfoAndAPPStoreInfo];
    [dic setObject:version forKey:@"v"];
#if DEBUG
   NSLog(@"验证的数据字典 = \n%@",dic);
#endif
    
//
//    [CJKTNetworkManager requestWithType:HttpRequestTypePost withUrlString: [NSString url:@"/pay/iap_verify"] withParaments:dic withSuccessBlock:^(NSDictionary *responseObject) {
//#if DEBUG
//        NSLog(@"返回验证结果 = \n%@",responseObject);
//#endif
//
//
//         [[SKPaymentQueue defaultQueue] finishTransaction:_transPay];//完成交易
//        if([responseObject[@"code"] integerValue] == CodeStateSucessful) {
//
//            [CJKTTool showAlertViewWithMessage:@"购买成功" presentViewController:nil];
//            //购买成功发送通知，刷新数据
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"CJBRefresh" object:nil];
//
//        }else{
//             [CJKTTool showAlertViewWithMessage:@"购买失败" presentViewController:nil];
//
//        }
    
//        
//    } withFailureBlock:^(NSError *error) {
//#if DEBUG
//       NSLog(@"返回error结果 = \n%@",error.localizedDescription);
//#endif
//        
//        
//    } progress:nil needPushToLogin:YES loginType:tokenLogin];
//    
    
}


#pragma mark -- 获取本地版本号

- (NSString *)getBundleInfoAndAPPStoreInfo
{
   
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}



@end
