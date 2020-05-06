//
//  UITextView+CJKTExtention.m
//  橙子数学
//
//  Created by MacBook on 2017/11/23.
//  Copyright © 2017年 杭州秀铂科技网络有限公司. All rights reserved.
//

#import "UITextView+CJKTExtention.h"
#import <objc/runtime.h>

static const char *qy_placeHolderTextView = "qy_placeHolderTextView";
static const void *QYTextViewInputLimitMaxLength = &QYTextViewInputLimitMaxLength;
@implementation UITextView (CJKTExtention)

#pragma mark -- 添加UITextView占位字符

- (UITextView *)qy_placeHolderTextView {
    return objc_getAssociatedObject(self, qy_placeHolderTextView);
}
- (void)setQy_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, qy_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)cjkt_addPlaceHolder:(NSString *)placeHolder {
    if (![self qy_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setQy_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    self.qy_placeHolderTextView.text = placeHolder;
}

# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.qy_placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.qy_placeHolderTextView.hidden = NO;
    }
}
+ (void)load {
    [super load];
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(qy_textView_placeholder_swizzledDealloc));
    method_exchangeImplementations(origMethod, newMethod);
}
- (void)qy_textView_placeholder_swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self qy_textView_placeholder_swizzledDealloc];
}



#pragma mark -- UITextView设置富文本某段文字的颜色
- (NSMutableAttributedString *)cjkt_setTextWithLinkAttribute:(NSString *)text withtextColor:(UIColor *)textcolor {
    
    return [self subStr:text withtextColor:textcolor];
    
}

- (NSMutableAttributedString *)subStr:(NSString *)string withtextColor:(UIColor *)textcolor{
    
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSMutableArray *rangeArr=[[NSMutableArray alloc]init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
        
    }
    
    NSString *subStr=string;
    for (NSString *str in arr) {
        [rangeArr addObject:[self rangesOfString:str inString:subStr]];
    }
    
    UIFont *font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *attributedText;
    attributedText=[[NSMutableAttributedString alloc]initWithString:subStr attributes:@{NSFontAttributeName :font}];
    
    for(NSValue *value in rangeArr)
    {
        NSInteger index=[rangeArr indexOfObject:value];
        NSRange range=[value rangeValue];
        [attributedText addAttribute:NSLinkAttributeName value:[NSURL URLWithString:[arr objectAtIndex:index]] range:range];
        [attributedText addAttribute:NSForegroundColorAttributeName value:textcolor range:range];
        
    }
    
    return attributedText;
    
}

//获取查找字符串在母串中的NSRange
- (NSValue *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    if ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {

    }
    return [NSValue valueWithRange:range];
}

@end
