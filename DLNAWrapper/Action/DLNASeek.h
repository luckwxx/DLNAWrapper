//
//  DLNASeek.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNAActionDelegate.h"
#import "DLNAActionBase.h"

@interface DLNASeek : DLNAActionBase <DLNAActionDelegate>

- (instancetype)initWithTarget:(NSString *)target success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
