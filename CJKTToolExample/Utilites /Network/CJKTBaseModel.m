//
//  CJKTBaseModel.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTBaseModel.h"
#import "objc/runtime.h"
@interface CJKTBaseModel ()
<NSSecureCoding>
@end
@implementation CJKTBaseModel



// NSKeyedArchiver（归档）存储模型数据
//编码 （NSUserDefaults plist文件存储）
- (void)archivedDataWithKey:(NSString *)key {
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
     [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

//解码
+ (instancetype)unArchivedObjectWithKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (data == nil) {
        return nil;
    }
    if (@available(iOS 11.0, *)) {
        return [NSKeyedUnarchiver unarchivedObjectOfClass:self fromData:data error:nil];
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}





#pragma mark -- NScoding 协议 (重写两个协议方法)

//每次归档对象时,调用
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    // 读取实例变量，并把这些数据写到coder中去。序列化数据
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = list[i];
        NSString *varName = [NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:varName];
        [aCoder encodeObject:value  forKey:varName];
        
    }
    free(list);
}

//每次从文件中恢复(解码)对象时调用
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
   //从coder中读取数据，保存到相应的变量中，即反序列化数据
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = list[i];
        NSString *varName = [NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding];
        [self setValue:[aDecoder decodeObjectForKey:varName] forKey:varName];
    }
    free(list);
    return self;
}





#pragma mark -- NSSecureCoding协议
+ (BOOL)supportsSecureCoding {
    return YES;
}
@end
