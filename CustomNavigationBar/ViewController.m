//
//  ViewController.m
//  CustomNavigationBar
//
//  Created by 夏远全 on 2017/8/30.
//  Copyright © 2017年 夏远全. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *pressButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [pressButton setCenter:self.view.center];
    [pressButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [pressButton setTitle:@"push" forState:UIControlStateNormal];
    [pressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pressButton setBackgroundColor:[UIColor redColor]];
    [pressButton addTarget:self action:@selector(pushTableViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pressButton];
    
}

-(void)pushTableViewController{
    
    FirstViewController *tableVc = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:tableVc animated:YES];
}

@end
