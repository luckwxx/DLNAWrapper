//
//  Config.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/23.
//  Copyright © 2016年 Key. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define LogSwitch 0

#if LogSwitch  // 调试状态, 打开LOG功能
    #define DLNALog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
    #define DLNALog(...)
#endif

#define UDP_CLIENT_PROT                    1900

#define UDP_SERVER_HOST                    @"239.255.255.250"

#define UDP_SERVER_PROT                    1900

#define FILE_SERVER_PORT                   5438

#define SEARCH_DATA                        @"M-SEARCH * HTTP/1.1\r\nMAN: \"ssdp:discover\"\r\nMX: 5\r\nHOST: 239.255.255.250:1900\r\nST: urn:schemas-upnp-org:service:AVTransport:1\r\n\r\n"

#define MEDIA_CONTROL_SERVICE_ID           @"urn:upnp-org:serviceId:AVTransport"

#define RENDERING_CONTROL_SERVICE_ID       @"urn:upnp-org:serviceId:RenderingControl"

#define SERVICE_TYPE_AVTRANSPORT           @"urn:schemas-upnp-org:service:AVTransport:1"

#define SERVICE_TYPE_RENDERING_CONTROL     @"urn:schemas-upnp-org:service:RenderingControl:1"


#endif /* Config_h */
