//
//  DLNAGetPositionInfo.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNAActionDelegate.h"
#import "DLNAActionBase.h"

@interface DLNAGetPositionInfo : DLNAActionBase <DLNAActionDelegate>

- (instancetype)initWithSuccess:(void(^)(NSString *currentDuration, NSString *totalDuration))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
