//
//  DLNAPlay.m
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/19.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "DLNAPlay.h"

@interface DLNAPlay ()

@property (nonatomic, copy) void(^successCallback)(void);

@property (nonatomic, copy) void(^failureCallback)(NSError *error);

@end

@implementation DLNAPlay

@synthesize successCallback = _successCallback;

@synthesize failureCallback = _failureCallback;

- (instancetype)initWithSuccess:(void (^)(void))successBlock failure:(void (^)(NSError *))failureBlock
{
    self = [self init];
    
    self.successCallback = successBlock;
    
    self.failureCallback = failureBlock;
    
    return self;
}

- (NSString *)name
{
    return @"Play";
}

- (NSString *)soapAction
{
    return [NSString stringWithFormat:@"\"%@#%@\"", SERVICE_TYPE_AVTRANSPORT, [self name]];
}

- (NSData *)postData
{
    GDataXMLElement *playElement = [GDataXMLElement elementWithName:@"u:Play"];
    
    [playElement addAttribute:[GDataXMLNode attributeWithName:@"xmlns:u" stringValue:SERVICE_TYPE_AVTRANSPORT]];
    
    GDataXMLElement *instanceIDElement = [GDataXMLElement elementWithName:@"InstanceID" stringValue:@"0"];
    
    GDataXMLElement *speedElement = [GDataXMLElement elementWithName:@"Speed" stringValue:@"1"];
    
    [playElement addChild:instanceIDElement];
    
    [playElement addChild:speedElement];
    
    return [self dataXML:playElement];
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
