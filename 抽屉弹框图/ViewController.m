//
//  ViewController.m
//  抽屉弹框图
//
//  Created by wyx on 2019/7/26.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "ViewController.h"
#import "SliderMenuView.h"
@interface ViewController ()
@property (nonatomic,strong) SliderMenuView *menView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SliderMenuView *men = [[SliderMenuView alloc]initWithTitleArr:@[@"1",@"2",@"3",@"4",@"5"]];
    _menView = men;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)switchClick:(id)sender {
    [_menView switchClick];
}

@end
