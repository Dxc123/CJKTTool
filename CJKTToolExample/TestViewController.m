//
//  TestViewController.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/12/27.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *webView;//网页

@property (nonatomic, strong) UILabel *markLabel;//标记

@property (nonatomic, strong) NSString *urlString;//首次加载的链接地址



@end

@implementation TestViewController
-(void)viewDidLoad{
     [self.view addSubview:self.markLabel];
     [self.view addSubview:self.webView];
}
//创建添加webView:

- (UIWebView *)webView{
    
    
    
    if (!_webView) {
        
        
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        
        webView.backgroundColor = [UIColor whiteColor];
        
        webView.delegate = self;
        
        webView.scrollView.delegate = self;
        
       
        
        self.webView = webView;
        
        
        
        
        
    }
    
    return _webView;
    
}



//创建添加现实标记的markLabel:

- (UILabel *)markLabel{
    
    
    
    if (!_markLabel) {
        
        
        
        UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
        
        markLabel.backgroundColor = [UIColor whiteColor];
        
        markLabel.text = @"您上次浏览到此处,请继续阅读！";
        
        markLabel.textAlignment = NSTextAlignmentCenter;
        
        markLabel.textColor = [UIColor redColor];
        
        markLabel.font = [UIFont systemFontOfSize:15.0f];
        
        markLabel.hidden = YES;
        
       
        
        self.markLabel = markLabel;
        
    }
    
    
    
    return _markLabel;
    
}





#pragma mark - 隐藏markLabel

- (void)markLabelHidde{
    
    
    
    self.markLabel.hidden = YES;
    
}





#pragma mark - 加载网页

- (void)loadData{
    
    
    
    self.urlString = @"http://blog.csdn.net/wwc455634698/article/details";
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}





#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp{
    
    
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    
    if ([self.urlString isEqualToString:webView.request.URL.absoluteString]) {
        
        CGFloat offsetY = 0;
        
        offsetY = [[NSUserDefaults standardUserDefaults] floatForKey:@"jingjinzhuimengren"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        if (offsetY) {
            
            
            
            self.markLabel.hidden = NO;
            
            [webView.scrollView setContentOffset:CGPointMake(0, offsetY) animated:NO];
            
            [self performSelector:@selector(markLabelHidde) withObject:self afterDelay:1.0f];
            
        }
        
    }
    
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}





#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    
    CGFloat offsetY =  self.webView.scrollView.contentOffset.y;
    
    [[NSUserDefaults standardUserDefaults] setFloat:offsetY forKey:@"jingjinzhuimengren"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
