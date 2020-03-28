//
//  DLNASetVolume.m
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "DLNASetVolume.h"

@interface DLNASetVolume ()

@property (nonatomic, assign) NSInteger targetVolume;

@property (nonatomic, copy)   void(^successCallback)(void);

@property (nonatomic, copy)   void(^failureCallback)(NSError *error);

@end

@implementation DLNASetVolume

@synthesize targetVolume    = _targetVolume;

@synthesize successCallback = _successCallback;

@synthesize failureCallback = _failureCallback;

- (instancetype)initWithVolume:(NSInteger)targetVolume success:(void (^)(void))successBlock failure:(void (^)(NSError *))failureBlock
{
    self = [self init];
    
    self.targetVolume = targetVolume;
    
    self.successCallback = successBlock;
    
    self.failureCallback = failureBlock;
    
    return self;
}

- (NSString *)name
{
    return @"SetVolume";
}

- (NSString *)soapAction
{
    return [NSString stringWithFormat:@"\"%@#%@\"", SERVICE_TYPE_RENDERING_CONTROL, [self name]];
}

- (NSData *)postData
{
    GDataXMLElement *setVolumeElement = [GDataXMLElement elementWithName:@"u:SetVolume"];
    
    [setVolumeElement addAttribute:[GDataXMLNode attributeWithName:@"xmlns:u" stringValue:SERVICE_TYPE_RENDERING_CONTROL]];
    
    GDataXMLElement *instanceIDElement = [GDataXMLElement elementWithName:@"InstanceID" stringValue:@"0"];
    
    GDataXMLElement *channelElement = [GDataXMLElement elementWithName:@"Channel" stringValue:@"Master"];
    
    GDataXMLElement *desiredVolumeElement = [GDataXMLElement elementWithName:@"DesiredVolume" stringValue:[[NSNumber numberWithInteger:self.targetVolume] stringValue]];
    
    [setVolumeElement addChild:instanceIDElement];
    
    [setVolumeElement addChild:channelElement];
    
    [setVolumeElement addChild:desiredVolumeElement];
    
    return [self dataXML:setVolumeElement];
}

- (void)success:(NSData *)data
{
    self.successCallback();
}

- (void)failure:(NSError *)error
{
    self.failureCallback(error);
}

@end
