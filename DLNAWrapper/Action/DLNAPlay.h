//
//  DLNAPlay.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNAActionDelegate.h"
#import "DLNAActionBase.h"

@interface DLNAPlay : DLNAActionBase <DLNAActionDelegate>

- (instancetype)initWithSuccess:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
