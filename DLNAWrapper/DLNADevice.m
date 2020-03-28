//
//  DLNADevice.m
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "DLNADevice.h"
#import "DLNAMediaControlService.h"
#import "DLNARenderingControlService.h"
#import "DLNAControlPoint.h"

#import "DLNASetURI.h"
#import "DLNAPlay.h"
#import "DLNAPause.h"
#import "DLNAStop.h"
#import "DLNASeek.h"
#import "DLNAGetPositionInfo.h"
#import "DLNAGetVolume.h"
#import "DLNASetVolume.h"

@interface DLNADevice()
@property (nonatomic, strong) DLNAControlPoint *mediaCP;
@property (nonatomic, strong) DLNAControlPoint *renderingCP;
@end

@implementation DLNADevice
@synthesize uuid                    = _uuid;
@synthesize name                    = _name;
@synthesize location                = _location;
@synthesize mediaControlService     = _mediaControlService;
@synthesize renderingControlService = _renderingControlService;

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    
    if (other != nil && [other isMemberOfClass:DLNADevice.class]) {
        DLNADevice *device = (DLNADevice *)other;
        return [self.uuid isEqualToString:device.uuid];
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.uuid hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name: %@\nlocation: %@\nuuid: %@\nmediaControl: %@\nrenderingControl: %@", self.name, self.location, self.uuid, self.mediaControlService, self.renderingControlService];
}


- (void)setUriWithURI:(NSString *)uri
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock
{
    DLNASetURI *setUriAction = [[DLNASetURI alloc] initWithURI:uri
                                               success:successBlock
                                               failure:failureBlock];
    [self.mediaCP executeAction:setUriAction];
}

- (void)setUriWithURI:(NSString *)uri
  useDefaultAudioMeta:(BOOL)flag
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock
{
    DLNASetURI *setUriAction = [[DLNASetURI alloc] initWithURI:uri
                                   useDefaultAudioMeta:flag
                                               success:successBlock
                                               failure:failureBlock];
    [self.mediaCP executeAction:setUriAction];
}

- (void)setUriWithURI:(NSString *)uri
  useDefaultVideoMeta:(BOOL)flag
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock
{
    DLNASetURI *setUriAction = [[DLNASetURI alloc] initWithURI:uri
                                   useDefaultVideoMeta:flag
                                               success:successBlock
                                               failure:failureBlock];
    [self.mediaCP executeAction:setUriAction];
}

- (void)setUriWithURI:(NSString *)uri
             metaData:(NSString *)metaData
              success:(void(^)(void))successBlock
              failure:(void(^)(NSError *error))failureBlock
{
    DLNASetURI *setUriAction = [[DLNASetURI alloc] initWithURI:uri
                                              metaData:metaData
                                               success:successBlock
                                               failure:failureBlock];
    [self.mediaCP executeAction:setUriAction];
}

- (void)stopWithSuccess:(void(^)(void))successBlock
                failure:(void(^)(NSError *error))failureBlock
{
    // 流程: 停止 -> 设置uri -> 获取进度和音量 -> 播放 -> 更新进度
    DLNAStop *stopAction = [[DLNAStop alloc] initWithSuccess:successBlock failure:failureBlock];
    [self.mediaCP executeAction:stopAction];
}

- (void)playWithSuccess:(void(^)(void))successBlock
                failure:(void(^)(NSError *error))failureBlock
{
    DLNAPlay *playAction = [[DLNAPlay alloc] initWithSuccess:successBlock failure:failureBlock];
    [self.mediaCP executeAction:playAction];
}

- (void)pauseWithSuccess:(void(^)(void))successBlock
                 failure:(void(^)(NSError *error))failureBlock
{
    DLNAPause *pauseAction = [[DLNAPause alloc] initWithSuccess:successBlock failure:failureBlock];
    [self.mediaCP executeAction:pauseAction];
}

- (void)seekWithCurPosition:(NSInteger)curPosition
                    success:(void(^)(void))successBlock
                    failure:(void(^)(NSError *error))failureBlock
{
    DLNASeek *seekAction = [[DLNASeek alloc] initWithTarget:[DLNADevice timeStringFromInteger:curPosition]
                                            success:successBlock
                                            failure:failureBlock];
    [self.mediaCP executeAction:seekAction];
}

- (void)setVolumeWithVolume:(NSInteger)volume
                    success:(void(^)(void))successBlock
                    failure:(void(^)(NSError *error))failureBlock
{
    DLNASetVolume *setvolume = [[DLNASetVolume alloc] initWithVolume:volume success:successBlock failure:failureBlock];
    [self.renderingCP executeAction:setvolume];
}

- (void)getVolumeWithSuccess:(void(^)(NSInteger volume))successBlock
                     failure:(void(^)(NSError *error))failureBlock
{
    DLNAGetVolume *getVolumeAction = [[DLNAGetVolume alloc] initWithSuccess:successBlock failure:failureBlock];
    [self.renderingCP executeAction:getVolumeAction];
}

- (void)positionInfoWithSuccess:(void(^)(NSString *currentDuration, NSString *totalDuration))successBlock
                        failure:(void(^)(NSError *error))failureBlock
{
    DLNAGetPositionInfo *getPosInfoAction = [[DLNAGetPositionInfo alloc] initWithSuccess:successBlock failure:failureBlock];
    [self.mediaCP executeAction:getPosInfoAction];
}

- (DLNAControlPoint*)mediaCP
{
    if(!_mediaCP)
    {
        _mediaCP = [[DLNAControlPoint alloc] initWithService:self.mediaControlService];
    }
    return _mediaCP;
}
- (DLNAControlPoint*)renderingCP
{
    if(!_renderingCP)
    {
        _renderingCP = [[DLNAControlPoint alloc] initWithService:self.renderingControlService];
    }
    return _renderingCP;
}
/**
 * 时间(秒)转String, 格式(xx:xx:xx)
 */
+ (NSString *)timeStringFromInteger:(NSInteger)seconds
{
    NSInteger hours, remainder, minutesm, secs;
     hours = seconds / 3600;
     remainder = seconds % 3600;
     minutesm = remainder / 60;
     secs = remainder % 60;
     return [NSString stringWithFormat:@"%@:%@:%@",
             (hours < 10 ? [NSString stringWithFormat:@"0%@", [[NSNumber numberWithInteger:hours] stringValue]] : [[NSNumber numberWithInteger:hours] stringValue]),
             (minutesm < 10 ? [NSString stringWithFormat:@"0%@", [[NSNumber numberWithInteger:minutesm] stringValue]] : [[NSNumber numberWithInteger:minutesm] stringValue]),
             (secs < 10 ? [NSString stringWithFormat:@"0%@", [[NSNumber numberWithInteger:secs] stringValue]] : [[NSNumber numberWithInteger:secs] stringValue])];
}
@end

