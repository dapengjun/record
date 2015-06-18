//
//  ViewController.m
//  record
//
//  Created by fengshen on 15/6/18.
//  Copyright (c) 2015年 fengshen. All rights reserved.
//

#import "ViewController.h"

#define RECORD_FILE @"record.pcm"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置Recorder，
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityMax],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                   nil];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:RECORD_FILE];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive: YES error: nil];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                // Microphone enabled code
                NSLog(@"enable microphone");
            }
            else {
                // Microphone disabled code
                NSLog(@"disable microphone");
            }
        }];
    }
    //录音文件保存地址的URL
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    
    if (error != nil) {
        NSLog(@"Init audioRecorder error: %@",error);
    }else{
        //准备就绪，等待录音，注意该方法会返回Boolean，最好做个成功判断，因为其失败的时候无任何错误信息抛出
        if ([self.audioRecorder prepareToRecord]) {
            self.audioRecorder.meteringEnabled = YES;
            NSLog(@"Prepare successful");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRecordClick:(id)sender {
    if (!self.audioRecorder.recording) {
        if ([self.audioRecorder record])
        {
            NSLog(@"record success");
        }
        else
        {
            NSLog(@"record fail");
        }
    }else {
        [self.audioRecorder stop];
    }
}

- (IBAction)onPlayClick:(id)sender {
    if (!self.audioPlayer.playing) {
        NSError *error;
        NSLog(@"%@",self.audioRecorder.url);
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioRecorder.url error:&error];
        self.audioPlayer.delegate = self;
        if (error != nil) {
            NSLog(@"Wrong init player:%@", error);
        }else{
            [self.audioPlayer play];
        }
    }else {
        [self.audioPlayer stop];
    }
}
#pragma mark audio delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"Finish playing");
    [player play];
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"Finish record!");
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}
@end
