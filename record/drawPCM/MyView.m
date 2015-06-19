//
//  MyView.m
//  record
//
//  Created by fengshen on 15/6/18.
//  Copyright (c) 2015年 fengshen. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)drawRect:(CGRect)rect {
    NSUInteger offset = 10;
    double y;
    RDValue *v;
    UIBezierPath *lineGraph = [UIBezierPath bezierPath];
    
    lineGraph.lineCapStyle = kCGLineCapRound;
    lineGraph.lineJoinStyle = kCGLineJoinRound;
    lineGraph.lineWidth = 1;
    
    v = self.pointArr[0];
    y = v.value;
    [lineGraph moveToPoint:CGPointMake(0, y+offset)];
    
    for (int i = 0; i<self.pointArr.count; i++) {
        v = self.pointArr[i];
        y = v.value;
        y = y*100/0xffff + offset;
        [lineGraph addLineToPoint:CGPointMake(i*4, y)];
    }
    
    [lineGraph stroke];
    
    v = self.pointArr[0];
    y = v.value;
    offset = 200;
    [lineGraph moveToPoint:CGPointMake(0, y+offset)];
    
    for (int i = 0; i<self.pointArr.count; i++) {
        v = self.pointArr[i];
        y = v.value;
        y = y + offset;
        [lineGraph addLineToPoint:CGPointMake(i*4, y)];
    }
    
    [lineGraph stroke];
}

@end
