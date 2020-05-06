//
//  UITextField+CJKTInputLimit.m
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2018/11/16.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "UITextField+CJKTInputLimit.h"
#import <objc/runtime.h>
static const void *CJKTTextFieldInputLimitMaxLength = &CJKTTextFieldInputLimitMaxLength;
@implementation UITextField (CJKTInputLimit)
- (NSInteger)cjkt_maxLength {
    return [objc_getAssociatedObject(self, CJKTTextFieldInputLimitMaxLength) integerValue];
}
- (void)setCjkt_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, CJKTTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(cjkt_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)cjkt_textFieldTextDidChange {
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

////////////////////////////


- (BOOL)cjkt_isEmpty

{
    
    return self.text.length == 0;
    
}

- (BOOL)cjkt_validateEmail

{
    
    return [self cjkt_validateWithRegExp: @"^[a-zA-Z0-9]{4,}@[a-z0-9A-Z]{2,}\\.[a-zA-Z]{2,}$"];
    
}

- (BOOL)cjkt_validateAuthen

{
    
    return [self cjkt_validateWithRegExp: @"^\\d{4,6}$"];
    
}

- (BOOL)cjkt_validatePassword

{
    
    NSString * length = @"^.{5,10}$";        //长度
    
    //    NSString * number = @"^\\w*\\d+\\w*$";      //数字
    //
    //    NSString * lower = @"^\\w*[a-z]+\\w*$";      //小写字母
    //
    //    NSString * upper = @"^\\w*[A-Z]+\\w*$";    //大写字母
    
    
    //    return [self validateWithRegExp: length] && [self validateWithRegExp: number] && [self validateWithRegExp: lower] && [self validateWithRegExp: upper];
    return [self cjkt_validateWithRegExp: length];
}

- (BOOL)cjkt_varildSpecial

{
    NSString *special = @"^\\W";
    
    return [self cjkt_validateWithRegExp:special];
}

- (BOOL)cjkt_validatePhoneNumber

{
    
    NSString * reg = @"^1\\d{10}$";
    
    return [self cjkt_validateWithRegExp: reg];
    
}
- (BOOL)cjkt_isPassword:(NSString *)Password
{
    NSString *      regex = @"(^[A-Za-z0-9]{6,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:Password];
}
- (BOOL)cjkt_validateWithRegExp: (NSString *)regExp

{
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", regExp];
    
    return [predicate evaluateWithObject: self.text];
    
}





@end
