//
//  UITextView+CJKTInputLimit.m
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/30.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "UITextView+CJKTInputLimit.h"
#import <objc/runtime.h>

static const void *CJKTTextViewInputLimitMaxLength = &CJKTTextViewInputLimitMaxLength;

@implementation UITextView (CJKTInputLimit)
- (NSInteger)cjkt_maxLength {
    return [objc_getAssociatedObject(self, CJKTTextViewInputLimitMaxLength) integerValue];
}
- (void)setCjkt_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, CJKTTextViewInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(qy_textViewTextDidChange:)
                                                name:@"UITextViewTextDidChangeNotification" object:self];
    
}
- (void)qy_textViewTextDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.cjkt_maxLength > 0 && toBeString.length > self.cjkt_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.cjkt_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.cjkt_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.cjkt_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.cjkt_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
+ (void)load {
    [super load];
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(qy_textView_limit_swizzledDealloc));
    method_exchangeImplementations(origMethod, newMethod);
}
- (void)qy_textView_limit_swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self qy_textView_limit_swizzledDealloc];
}
@end
