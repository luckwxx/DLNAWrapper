//
//  DLNASetVolume.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNAActionDelegate.h"
#import "DLNAActionBase.h"

@interface DLNASetVolume : DLNAActionBase <DLNAActionDelegate>

- (instancetype)initWithVolume:(NSInteger)targetVolume success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
