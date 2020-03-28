# DLNAWrapper

iOS DLNA投屏功能<br>

基于 https://github.com/KeyYao/DLNAWrapper 代码修改<br>


## 引入方式
pod 'DLNAWrapper'


## Using
#### 1.启动并搜索可投屏设备 DLNAUpnpServer

```objective-c
[DLNAUpnpServer shareServer].delegate = self;
[[DLNAUpnpServer shareServer] startAndSearch:YES];
```
#### 2.选择投屏设备
```objective-c
[[DLNAUpnpServer shareServer] selectedDeviceWithDevice:device];
```
#### 3.投屏控制
流程: 停止 -> 设置uri -> 获取进度和音量 -> 播放 -> 更新进度<br>
```objective-c
    [SelectedDevice stopWithSuccess:^{
        [self setUri];
    } failure:^(NSError *error) {
        
    }];

```
设置uri<br>
```objective-c
    [SelectedDevice setUriWithURI:url success:^{
        self.isUpdateProgress = YES;
        [self getPositionInfo];
        [self getVolume];
        [self play:nil];
    } failure:^(NSError *error) {
        NSLog(@"设置 URL 失败");
    }];
```
播放<br>
```objective-c
    [SelectedDevice playWithSuccess:^{
        
    } failure:^(NSError *error) {
        NSLog(@"播放失败");
    }];
```
##### 其他对设备的控制操作请参考Demo

#### 4.启动FileServer（可选）
```objective-c
[[FileServer shareServer] start];
```

### 运行例子：

* Demo目录下
```bash
pod install
```
* 打开DLNAWrapper.xcworkspace
* ps: 例子写的有点随便，请不要在意

<br>
感谢 KeyYao！<br>
