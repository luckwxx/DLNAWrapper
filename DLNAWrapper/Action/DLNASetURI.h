//
//  DLNASetURI.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/20.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNAActionDelegate.h"
#import "DLNAActionBase.h"

@interface DLNASetURI : DLNAActionBase <DLNAActionDelegate>

- (instancetype)initWithURI:(NSString *)uri success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

- (instancetype)initWithURI:(NSString *)uri useDefaultAudioMeta:(BOOL)flag success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

- (instancetype)initWithURI:(NSString *)uri useDefaultVideoMeta:(BOOL)flag success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

- (instancetype)initWithURI:(NSString *)uri metaData:(NSString *)metaData success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
