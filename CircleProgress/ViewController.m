//
//  ViewController.m
//  CircleProgress
//
//  Created by L-H-T on 2019/1/22.
//  Copyright © 2019 L-H-T. All rights reserved.
//

#import "ViewController.h"
#import "RingProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RingProgressView * progressView = [[RingProgressView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:progressView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


@end
