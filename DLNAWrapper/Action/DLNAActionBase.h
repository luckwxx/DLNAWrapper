//
//  DLNAActionBase.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/20.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "DLNAConfig.h"

@interface DLNAActionBase : NSObject

- (GDataXMLElement *)rootElement;

- (NSData *)dataXML:(GDataXMLElement *)body;

@end
