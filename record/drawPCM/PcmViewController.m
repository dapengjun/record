//
//  PcmViewController.m
//  record
//
//  Created by fengshen on 15/6/18.
//  Copyright (c) 2015年 fengshen. All rights reserved.
//

#import "PcmViewController.h"

@interface PcmViewController ()

@property(nonatomic,retain)NSData *data;

@end

@implementation PcmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RDValue *value;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    self.data = [NSData dataWithContentsOfFile:self.path];
    const unsigned char *bytes = [self.data bytes];
    for (int i = 0; i < [self.data length]/2; i++)
    {
        value = [[RDValue alloc] init];
        value.value = bytes[i*2] + (bytes[i*2+1]<<8);
        if(value.value > 0xffff)
        {
            NSLog(@"%d",value.value);
        }
        [arr addObject:value];
    }
    self.myView.pointArr = arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
