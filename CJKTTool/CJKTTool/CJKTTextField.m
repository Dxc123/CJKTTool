//
//  CJKTTextField.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2019/11/22.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import "CJKTTextField.h"

@implementation CJKTTextField

//由于直接使用 leftView 属性,leftView会紧紧贴在输入框的边缘，所以需要写一个继承 TextField的，重写有关的TextField方法 ，来改变那个边距设置的


//修改leftView与输入框的距离
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    leftRect.origin.x += 10; //向右边偏10
    return leftRect;
}
//修改rightView与输入框的距离
- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rightRect = [super rightViewRectForBounds:bounds];
    rightRect.origin.x -= 10; //向左边偏10
    return rightRect;
}

//修改placeholder与输入框的内边距
//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    return CGRectInset(bounds, 10, 0);
//}

//UITextField输入文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    if (self.leftView) {
        return CGRectInset(bounds, 40, 0);
    }
    return CGRectInset(bounds, 10, 0);
    
}
//控制编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    if (self.leftView) {
        return CGRectInset(bounds, 40, 0);
    }
    return CGRectInset(bounds, 10, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
