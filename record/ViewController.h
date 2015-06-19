//
//  ViewController.h
//  record
//
//  Created by fengshen on 15/6/18.
//  Copyright (c) 2015年 fengshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate,AVAudioSessionDelegate>

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)onRecordClick:(id)sender;
- (IBAction)onPlayClick:(id)sender;
- (IBAction)onDrawClick:(id)sender;

@end

