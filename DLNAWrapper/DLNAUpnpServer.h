//
//  DLNAUpnpServer.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLNADeviceChangeDelegate.h"
#import "DLNADevice.h"

#define SelectedDevice [DLNAUpnpServer shareServer].selectedDevice

@interface DLNAUpnpServer : NSObject
@property (nonatomic, weak) id<DLNADeviceChangeDelegate> delegate;
@property (nonatomic, weak) DLNADevice *selectedDevice;//选中的投屏设备
/**
 获取实例
 @return DLNAUpnpServer instance
 */
+ (instancetype)shareServer;

/**
 启动Upnp服务，默认不搜索设备
 */
- (void)start;

/**
 启动Upnp服务
 @param isSearch 是否立刻搜索设备
 */
- (void)startAndSearch:(BOOL)isSearch;

/**
 搜索局域网内的设备
 */
- (void)search;

/**
 获取已经发现的设备
 @return DMR Array
 */
- (NSArray<DLNADevice *> *)getDeviceList;

/**
  选择投屏设备
 */
- (void)selectedDeviceWithDevice:(DLNADevice *)device;
@end
