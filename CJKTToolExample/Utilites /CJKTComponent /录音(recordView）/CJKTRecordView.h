//
//  CJKTRecordView.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/29.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,CJKTRecordState) {
    CJKTRecordStateNone,///录音正常状态
    CJKTRecordStateRecording,///开始录音
    CJKTRecordStateFinishRecord,///结束录音
    CJKTRecordStatePlaying///开始播放录音
};
@interface CJKTRecordView : UIView
@property (nonatomic,assign) CJKTRecordState state;
@property (nonatomic,copy) void(^startRecordBlock)(void);
@property (nonatomic,copy) void(^stopRecordBlock)(void);
@property (nonatomic,copy) void(^startPlayBlock)(void);
@property (nonatomic,copy) void(^stopPlayBlock)(void);
@property (nonatomic,copy) void(^cancelRecordBlock)(void);

@property (nonatomic,copy) void(^confirmRecordBlock)(void);
@property (nonatomic,copy) void(^closeBlock)(void);
@property (nonatomic,assign) float volume;
@property (nonatomic,assign) NSUInteger time;


@end

NS_ASSUME_NONNULL_END
