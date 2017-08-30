//
//  BaseNavigationBar.h
//  Yuwen
//
//  Created by 夏远全 on 2017/7/13.
//  Copyright © 2017年 yimilan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYQNavigationBar : UIView
@property (copy , nonatomic)void(^clickLeftItemBlock)();  // click left button block
@property (copy , nonatomic)void(^clickRightItemBlock)(); // click right button block

@property (copy , nonatomic)NSString *title; // title
@property (assign,nonatomic)UIColor  *titleColor; // title color
@property (strong,nonatomic)UIColor  *navBackgroundColor;// navagationBar background color
@property (strong,nonatomic)UIImage  *navBackgroundImage;// navigationBar background image

+(instancetype)createCustomNavigationBar;  //create navigationBar

-(void)showCustomNavigationBar:(BOOL)show; //set navigationBar hide, defalut is NO

-(void)setupBgImageAlpha:(CGFloat)alpha animation:(NSTimeInterval)duration compeleteBlock:(void (^)())compeleteBlock;// navigationBar background image alpha

-(void)setupBgColorAlpha:(CGFloat)alpha animation:(NSTimeInterval)duration compeleteBlock:(void (^)())compeleteBlock;// navigationBar background color alpha


-(void)setLftItemImage:(NSString *)imgName leftItemtitle:(NSString *)leftItemtitle textColor:(UIColor *)color; // navigationBar left  button has title and image

-(void)setRightItemImage:(NSString *)imgName rightItemtitle:(NSString *)rightItemtitle textColor:(UIColor *)color;// navigationBar right  button has title and image

-(void)setLeftItemImage:(NSString *)imgName;  // navigationBar left  button only has image

-(void)setRightItemImage:(NSString *)imgName; // navigationBar right button only has image

@end
