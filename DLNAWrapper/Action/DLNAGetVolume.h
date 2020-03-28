//
//  DLNAGetVolume.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNAActionDelegate.h"
#import "DLNAActionBase.h"

@interface DLNAGetVolume : DLNAActionBase <DLNAActionDelegate>

- (instancetype)initWithSuccess:(void(^)(NSInteger volume))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
