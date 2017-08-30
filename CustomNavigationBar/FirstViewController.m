//
//  TableViewController.m
//  CustomNavigationBar
//
//  Created by 夏远全 on 2017/8/30.
//  Copyright © 2017年 夏远全. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "XYQNavigationBar.h"


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong , nonatomic)UITableView *tableView;
@property (strong , nonatomic)XYQNavigationBar *navigationBar;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationBar = [XYQNavigationBar createCustomNavigationBar];

    
    //update（此处可以自由改变导航栏的属性值）
    self.navigationBar.title = @"自定义导航栏";
    
    
    //block
    __weak typeof(self) weakSelf = self;
    self.navigationBar.clickLeftItemBlock = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.navigationBar.clickRightItemBlock = ^(){
        [weakSelf.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
    };
    
    
    // add
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navigationBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //hide system navigationBar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //show custom navigationBar
    [self.navigationBar showCustomNavigationBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //show system navigationBar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //hide custom navigationBar
    [self.navigationBar showCustomNavigationBar:NO];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuserIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    return cell;
}

#pragma mark - public methods
// animation show or hide navigationbar
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat colorOffset = offsetY / 64.0;
    colorOffset = colorOffset > 1 ? 1 : colorOffset;
    
    //method 1 : change backgrundViewImage alpha
    [self.navigationBar setupBgImageAlpha:colorOffset animation:0.4 compeleteBlock:nil];
    
    //method 2 : change backgrundViewColor alpha
    //[self.navigationBar setupBgColorAlpha:colorOffset animation:0.4 compeleteBlock:nil];
}


@end
