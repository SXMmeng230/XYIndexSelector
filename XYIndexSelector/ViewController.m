//
//  ViewController.m
//  XYIndexSelector
//
//  Created by 小萌 on 2017/5/16.
//  Copyright © 2017年 小萌. All rights reserved.
//

#import "ViewController.h"
#import "XYIndexView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XYIndexView *indexView = [[XYIndexView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 50, 30, self.view.frame.size.height - 100)];
    [self.view addSubview:indexView];
    [indexView setIndexViewWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"] seleted:^(NSInteger index) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
