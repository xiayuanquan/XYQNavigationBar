//
//  BaseNavigationBar.m
//  Yuwen
//
//  Created by 夏远全 on 2017/7/13.
//  Copyright © 2017年 yimilan. All rights reserved.
//

#import "XYQNavigationBar.h"
#import <Masonry.h>


// Color
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define colorBlue   HEXCOLOR(0x00C3F5)
#define colorWhite  HEXCOLOR(0xFFFFFF)


// Screen
#define kWidth      [[UIScreen mainScreen] bounds].size.width
#define kHeight     [[UIScreen mainScreen] bounds].size.height


@interface XYQNavigationBar ()
@property (strong , nonatomic)UILabel  *titleLable;
@property (strong , nonatomic)UIButton *leftButton;
@property (strong , nonatomic)UIButton *rightButton;
@property (strong , nonatomic)UIImageView *bgBroundView;
@end

@implementation XYQNavigationBar

#pragma mark - custom init
+(instancetype)createCustomNavigationBar{
    XYQNavigationBar *navigationBar = [[self alloc] initWithFrame:CGRectMake(0,0,kWidth,64)];
    return navigationBar;
}

#pragma mark - life cycle

-(instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    [self setDefalut];
    [self setupSubViews];
    [self setupSubviewsConstraints];
}

-(void)setDefalut{
    self.titleLable.textColor = colorWhite;
    self.backgroundColor = self.navBackgroundColor = colorBlue;
    self.bgBroundView.alpha = 0.0;
    self.backgroundColor = [self.navBackgroundColor colorWithAlphaComponent:0.0];
}

#pragma mark - add subViews
-(void)setupSubViews{
    
    [self addSubview:self.bgBroundView];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLable];
    [self addSubview:self.rightButton];
}


#pragma mark - layout subviews
-(void)setupSubviewsConstraints {
    
    [self.bgBroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.mas_equalTo(20);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 44));
        make.top.mas_equalTo(20);
        make.left.mas_equalTo((kWidth-180)/2);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(20);
    }];
}

#pragma mark - event response
-(void)clickBack{
    if (self.clickLeftItemBlock) {
        self.clickLeftItemBlock();
    }
}

-(void)clickRight{
    if (self.clickRightItemBlock) {
        self.clickRightItemBlock();
    }
}

#pragma mark - public methods

-(void)setupBgColorAlpha:(CGFloat)alpha animation:(NSTimeInterval)duration compeleteBlock:(void (^)())compeleteBlock{
    
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = [self.navBackgroundColor colorWithAlphaComponent:alpha];
        self.titleLable.textColor = [colorWhite colorWithAlphaComponent:alpha];
        if (compeleteBlock) {
            compeleteBlock();
        }
    }];
}

-(void)setupBgImageAlpha:(CGFloat)alpha animation:(NSTimeInterval)duration compeleteBlock:(void (^)())compeleteBlock{
    
    [UIView animateWithDuration:duration animations:^{
        self.bgBroundView.alpha = alpha;
        self.titleLable.textColor = [colorWhite colorWithAlphaComponent:alpha];
        if (compeleteBlock) {
            compeleteBlock();
        }
    }];
}

-(void)setLftItemImage:(NSString *)imgName leftItemtitle:(NSString *)leftItemtitle textColor:(UIColor *)color{
    
    [self.leftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.leftButton setTitle:leftItemtitle forState:UIControlStateNormal];
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
}

-(void)setRightItemImage:(NSString *)imgName rightItemtitle:(NSString *)rightItemtitle textColor:(UIColor *)color{
    
    [self.rightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.rightButton setTitle:rightItemtitle forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
}

-(void)setLeftItemImage:(NSString *)imgName{
    [self.leftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}

-(void)setRightItemImage:(NSString *)imgName{
     [self.rightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}

-(void)showCustomNavigationBar:(BOOL)show{
    self.hidden = !show;
}


#pragma mark - private methods


#pragma mark - getters and setters
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLable.text = title;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLable.textColor = titleColor;
}

-(void)setNavBackgroundColor:(UIColor *)navBackgroundColor{
    
    _navBackgroundColor = navBackgroundColor;
    self.backgroundColor = navBackgroundColor;
}

-(void)setNavBackgroundImage:(UIImage *)navBackgroundImage{
    _navBackgroundImage = navBackgroundImage;
    self.bgBroundView.image = navBackgroundImage;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        
        _rightButton = [[UIButton alloc] init];
        [_rightButton setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _rightButton;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:18];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(UIImageView *)bgBroundView{
    if (!_bgBroundView) {
        _bgBroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_bar"]];
    }
    return _bgBroundView;
}

@end
