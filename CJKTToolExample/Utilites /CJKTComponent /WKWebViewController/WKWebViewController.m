//
//  WKWebViewController.m
//  MomentKit
//
//  Created by LEA on 2019/2/2.
//  Copyright © 2019 LEA. All rights reserved.
//

#import "WKWebViewController.h"
#import <MMWebView.h>

@interface WKWebViewController ()<MMWebViewDelegate>

@end

@implementation WKWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MMWebView * webView = [[MMWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - CF_NavHeight)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.opaque = NO;
    webView.delegate = self;
    webView.displayProgressBar = YES;// 显示进度条
    webView.allowsBackForwardNavigationGestures = YES;// 允许侧滑返回
    webView.progressTintColor = [UIColor colorWithRed:(30.f)/255.0 green:(191.f)/255.0 blue:(97.f)/255.0 alpha:1.0];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
}

#pragma mark - MMWebViewDelegate

// 网页加载进度
- (void)webView:(MMWebView *)webView estimatedProgress:(CGFloat)progress{
    NSLog(@"progress = %f",progress);
}
// 网页标题更新
- (void)webView:(MMWebView *)webView didUpdateTitle:(NSString *)title{
     NSLog(@"网页标题更新");
    self.title = title;
}
// 网页开始加载
- (BOOL)webView:(MMWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType{
    
    return YES;
}
// 网页开始加载
- (void)webViewDidStartLoad:(MMWebView *)webView{
     NSLog(@"网页开始加载");
}
// 网页完成加载
- (void)webViewDidFinishLoad:(MMWebView *)webView{
     NSLog(@"网页完成加载");
}
// 网页加载出错
- (void)webView:(MMWebView *)webView didFailLoadWithError:(NSError *)error{
     NSLog(@"网页加载出错error = %@",error);
}

@end
