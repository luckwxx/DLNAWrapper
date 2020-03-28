//
//  DLNADevice.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLNAMediaControlService;
@class DLNARenderingControlService;

@interface DLNADevice : NSObject

@property (nonatomic, strong) NSString                *uuid;
@property (nonatomic, strong) NSString                *name;
@property (nonatomic, strong) NSString                *location;
@property (nonatomic, strong) DLNAMediaControlService     *mediaControlService;
@property (nonatomic, strong) DLNARenderingControlService *renderingControlService;

 // 流程: 停止 -> 设置uri -> 获取进度和音量 -> 播放 -> 更新进度
- (void)setUriWithURI:(NSString *)uri
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock;

- (void)setUriWithURI:(NSString *)uri
  useDefaultAudioMeta:(BOOL)flag
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock;

- (void)setUriWithURI:(NSString *)uri
  useDefaultVideoMeta:(BOOL)flag
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock;

- (void)setUriWithURI:(NSString *)uri
             metaData:(NSString *)metaData
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock;

- (void)stopWithSuccess:(void(^)(void))successBlock
                failure:(void(^)(NSError *error))failureBlock;

- (void)playWithSuccess:(void(^)(void))successBlock
                failure:(void(^)(NSError *error))failureBlock;

- (void)pauseWithSuccess:(void(^)(void))successBlock
                 failure:(void(^)(NSError *error))failureBlock;

- (void)seekWithCurPosition:(NSInteger)curPosition
                    success:(void(^)(void))successBlock
                    failure:(void(^)(NSError *error))failureBlock;

- (void)setVolumeWithVolume:(NSInteger)volume
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock;

- (void)getVolumeWithSuccess:(void(^)(NSInteger volume))successBlock
                     failure:(void(^)(NSError *error))failureBlock;

- (void)positionInfoWithSuccess:(void(^)(NSString *currentDuration, NSString *totalDuration))successBlock
                        failure:(void(^)(NSError *error))failureBlock;
@end
