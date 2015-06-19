//
//  PcmViewController.h
//  record
//
//  Created by fengshen on 15/6/18.
//  Copyright (c) 2015年 fengshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"

@interface PcmViewController : UIViewController

@property(nonatomic,copy)NSString *path;
@property (weak, nonatomic) IBOutlet MyView *myView;

@end
