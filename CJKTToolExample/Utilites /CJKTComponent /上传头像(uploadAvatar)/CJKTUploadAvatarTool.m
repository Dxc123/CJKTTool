//
//  CJKTUploadAvatarTool.m
//  QYSearchProject
//
//  Created by Dxc_iOS on 2018/12/4.
//  Copyright © 2018 cjkt. All rights reserved.
//

#import "CJKTUploadAvatarTool.h"
@class CJKTUploadAvatarTool;
@interface CJKTUploadAvatarTool ()
<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)UIViewController *viewController;
@property (nonatomic, copy) void(^FinishBlcok)(UIImage *image);

@end
@implementation CJKTUploadAvatarTool

+ (CJKTUploadAvatarTool *)shareManager
{
    static CJKTUploadAvatarTool *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)cjkt_selectAvatarWithViewController:(UIViewController *)viewController WithFinishBlcok:(void(^)(UIImage *image))finishBlock{
    if (viewController) {
        self.viewController = viewController;
    }
    if (finishBlock) {
        self.FinishBlcok =  finishBlock ;
    }
        UIAlertController *alertCol = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])///<检测该设备是否支持拍摄
            {
                //                    [Tools showAlertView:@"sorry, 该设备不支持拍摄"];///<显示提示不支持
                NSLog(@"该设备不支持拍摄");
                return;
            }
            UIImagePickerController* picker = [[UIImagePickerController alloc]init];///<图片选择控制器创建
    
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;///<设置数据来源为拍照
            picker.allowsEditing = YES;
            picker.delegate = self;///<代理设置
    
            [self.viewController presentViewController:picker animated:YES completion:nil];///<推出视图控制器
    
    
        }];
         [alertCol addAction:action];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController* picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = self;
            [viewController presentViewController:picker animated:YES completion:nil];
    
        }];
        [alertCol addAction:action2];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertCol addAction:cancelAction];
        [viewController presentViewController:alertCol animated:YES completion:nil];
    
    

    
}

#pragma mark - 相册/相机回调  显示所有的照片，或者拍照选取的照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = nil;
//    获取编辑之后的图片
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (self.FinishBlcok) {
   NSLog(@"选择照片");
        self.FinishBlcok(image);
    }
    

    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
}


//  取消选择 返回当前试图
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
