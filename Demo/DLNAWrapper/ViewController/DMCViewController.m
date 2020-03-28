//
//  DMCViewController.m
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/21.
//  Copyright © 2016年 Key. All rights reserved.
//

#import "DMCViewController.h"

#import "Masonry.h"

#import "ExampleDefine.h"
#import "UIColor+ColorFormat.h"
#import "DLNAUpnpServer.h"

@interface DMCViewController ()

@property UILabel *currentTimeLabel;
@property UILabel *totalTimeLabel;
@property UIProgressView *progressView;

@property NSInteger currentVolume;
@property NSInteger currentTime;
@property NSInteger totalTime;

@property BOOL isUpdateProgress;

@end

@implementation DMCViewController

@synthesize deviceIndex;
@synthesize url;
@synthesize currentTimeLabel;
@synthesize totalTimeLabel;
@synthesize progressView;

@synthesize currentVolume;
@synthesize currentTime;
@synthesize totalTime;

@synthesize isUpdateProgress;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isUpdateProgress = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger padding = 30;
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    UIView *statusBarView = [[UIView alloc] initWithFrame:statusBarFrame];
    statusBarView.backgroundColor = THEME_COLOR;
    [self.view addSubview:statusBarView];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"DLNAController";
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = THEME_COLOR;
    topLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:topLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    progressView = [[UIProgressView alloc] init];
    progressView.progressViewStyle = UIProgressViewStyleDefault;
    progressView.progressTintColor = THEME_COLOR;
    progressView.trackTintColor = [UIColor colorWithFormat:@"#cccccc"];
    [progressView setProgress:0.0f animated:NO];
    [self.view addSubview:progressView];
    
    currentTimeLabel = [[UILabel alloc] init];
    currentTimeLabel.text = @"00:00";
    currentTimeLabel.textColor = [UIColor blackColor];
    currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:currentTimeLabel];
    
    totalTimeLabel = [[UILabel alloc] init];
    totalTimeLabel.text = @"00:00";
    totalTimeLabel.textColor = [UIColor blackColor];
    totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:totalTimeLabel];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.layer.masksToBounds = YES;
    playBtn.layer.cornerRadius = 8;
    [playBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [playBtn setTitle:@"Play" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playBtn setBackgroundColor:THEME_COLOR];
    [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn.layer.masksToBounds = YES;
    pauseBtn.layer.cornerRadius = 8;
    [pauseBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    [pauseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pauseBtn setBackgroundColor:THEME_COLOR];
    [pauseBtn addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.layer.masksToBounds = YES;
    stopBtn.layer.cornerRadius = 8;
    [stopBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopBtn setBackgroundColor:THEME_COLOR];
    [stopBtn addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    UIButton *upVolumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upVolumeBtn.layer.masksToBounds = YES;
    upVolumeBtn.layer.cornerRadius = 8;
    [upVolumeBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [upVolumeBtn setTitle:@"+" forState:UIControlStateNormal];
    [upVolumeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upVolumeBtn setBackgroundColor:THEME_COLOR];
    [upVolumeBtn addTarget:self action:@selector(volumeUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upVolumeBtn];
    
    UIButton *downVolumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downVolumeBtn.layer.masksToBounds = YES;
    downVolumeBtn.layer.cornerRadius = 8;
    [downVolumeBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [downVolumeBtn setTitle:@"-" forState:UIControlStateNormal];
    [downVolumeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downVolumeBtn setBackgroundColor:THEME_COLOR];
    [downVolumeBtn addTarget:self action:@selector(volumeDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downVolumeBtn];
    
    UIButton *seekBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seekBackBtn.layer.masksToBounds = YES;
    seekBackBtn.layer.cornerRadius = 8;
    [seekBackBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [seekBackBtn setTitle:@"<<" forState:UIControlStateNormal];
    [seekBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seekBackBtn setBackgroundColor:THEME_COLOR];
    [seekBackBtn addTarget:self action:@selector(seekBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seekBackBtn];
    
    UIButton *seekForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seekForwardBtn.layer.masksToBounds = YES;
    seekForwardBtn.layer.cornerRadius = 8;
    [seekForwardBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [seekForwardBtn setTitle:@">>" forState:UIControlStateNormal];
    [seekForwardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seekForwardBtn setBackgroundColor:THEME_COLOR];
    [seekForwardBtn addTarget:self action:@selector(seekForward:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seekForwardBtn];
    
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusBarView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@50);
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.centerY.equalTo(topLabel);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
    }];
    
    [currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressView.mas_bottom).offset(5);
        make.left.equalTo(progressView.mas_left);
    }];
    
    [totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(progressView.mas_bottom).offset(5);
        make.right.equalTo(progressView.mas_right);
    }];
    
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentTimeLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(pauseBtn.mas_left).offset(-padding);
        make.width.equalTo(stopBtn);
    }];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentTimeLabel.mas_bottom).offset(20);
        make.left.equalTo(pauseBtn.mas_right).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.width.equalTo(playBtn);
    }];
    
    [pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentTimeLabel.mas_bottom).offset(20);
        make.left.equalTo(playBtn.mas_right).offset(padding);
        make.right.equalTo(stopBtn.mas_left).offset(-padding);
        make.width.equalTo(playBtn);
    }];
    
    [upVolumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playBtn.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(downVolumeBtn.mas_left).offset(-padding);
        make.width.equalTo(downVolumeBtn);
    }];
    
    [downVolumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playBtn.mas_bottom).offset(20);
        make.left.equalTo(upVolumeBtn.mas_right).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.width.equalTo(upVolumeBtn);
    }];
    
    [seekBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upVolumeBtn.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(seekForwardBtn.mas_left).offset(-padding);
        make.width.equalTo(seekForwardBtn);
    }];
    
    [seekForwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upVolumeBtn.mas_bottom).offset(20);
        make.left.equalTo(seekBackBtn.mas_right).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.width.equalTo(seekBackBtn);
    }];

    // 流程: 停止 -> 设置uri -> 获取进度和音量 -> 播放 -> 更新进度
    [SelectedDevice stopWithSuccess:^{
        [self setUri];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setUri {
    [SelectedDevice setUriWithURI:url success:^{
        self.isUpdateProgress = YES;
        [self getPositionInfo];
        [self getVolume];
        [self play:nil];
    } failure:^(NSError *error) {
        NSLog(@"设置 URL 失败");
    }];
}

- (void)getPositionInfo {
    [SelectedDevice positionInfoWithSuccess:^(NSString *currentDuration, NSString *totalDuration) {
        self.currentTimeLabel.text = currentDuration;
        self.totalTimeLabel.text = totalDuration;
        
        self.currentTime = [DMCViewController timeIntegerFromString:currentDuration];
        self.totalTime = [DMCViewController timeIntegerFromString:totalDuration];
        
        if (self.totalTime != 0) {
            [self.progressView setProgress:self.currentTime / (float)self.totalTime animated:YES];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isUpdateProgress) {
                [self getPositionInfo];
            }
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getVolume {
    [SelectedDevice getVolumeWithSuccess:^(NSInteger volume) {
        self.currentVolume = volume;
    } failure:^(NSError *error) {
        NSLog(@"获取音量失败");
    }];
}

- (void)back:(id)sender {
    isUpdateProgress = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)play:(id)sender {
    [SelectedDevice playWithSuccess:^{
        
    } failure:^(NSError *error) {
        NSLog(@"播放失败");
    }];
}

- (void)pause:(id)sender {
    [SelectedDevice pauseWithSuccess:^{
        
    } failure:^(NSError *error) {
        NSLog(@"暂停失败");
    }];
}

- (void)stop:(id)sender {
    [SelectedDevice stopWithSuccess:^{
        
    } failure:^(NSError *error) {
        NSLog(@"停止失败");
    }];
}

- (void)seekForward:(id)sender {
    NSInteger targetDuration = currentTime + 30;
    if (targetDuration > totalTime) {
        targetDuration = totalTime;
    }
    [SelectedDevice seekWithCurPosition:targetDuration success:^{
        
    } failure:^(NSError *error) {
        NSLog(@"快进失败");
    }];
}

- (void)seekBack:(id)sender {
    NSInteger targetDuration = currentTime - 30;
    if (targetDuration < 0) {
        targetDuration = 0;
    }
    [SelectedDevice seekWithCurPosition:targetDuration success:^{
        
    } failure:^(NSError *error) {
        NSLog(@"快进失败");
    }];
}

- (void)volumeUp:(id)sender {
    NSInteger targetVolume = currentVolume + 10;
    if (targetVolume > 100) {
        targetVolume = 100;
    }
    NSLog(@"current volume: %ld, target volume: %ld", (long)currentVolume, (long)targetVolume);
    [SelectedDevice setVolumeWithVolume:targetVolume success:^{
        self.currentVolume = targetVolume;
    } failure:^(NSError *error) {
        NSLog(@"设置音量失败");
    }];
}

- (void)volumeDown:(id)sender {
    NSInteger targetVolume = currentVolume - 10;
    if (targetVolume < 0) {
        targetVolume = 0;
    }
    [SelectedDevice setVolumeWithVolume:targetVolume success:^{
        self.currentVolume = targetVolume;
    } failure:^(NSError *error) {
        NSLog(@"设置音量失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    isUpdateProgress = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 * 时间(String)转秒, 格式(xx:xx:xx)
 */
+ (NSInteger)timeIntegerFromString:(NSString *)string
{
    NSArray<NSString *> *split = [string componentsSeparatedByString:@":"];
    
    return ([[split objectAtIndex:0] integerValue] * 3600) + ([[split objectAtIndex:1] integerValue] * 60) + ([[split objectAtIndex:2] integerValue]);
}
@end
