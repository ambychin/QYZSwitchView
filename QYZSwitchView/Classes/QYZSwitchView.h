//
//  QYZSwitchView.h
//
//  Created by iMac-qinyuanzhi on 18/6/27.
//  Copyright © 2018年 iMac-qinyuanzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYZSwitchView;

typedef void(^QYZSwitchStatusBlock)(BOOL on);

@interface QYZSwitchView : UIView

@property(nonatomic,assign,getter=isOn) BOOL    on;//是否开启
@property(nonatomic,strong) UIImage         *imageOn;
@property(nonatomic,strong) UIImage         *imageOff;
@property(nonatomic,copy)   QYZSwitchStatusBlock         statusBlock;
    
    
-(instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)image;
-(instancetype)initWithFrame:(CGRect)frame onTitle:(NSString *)onTitle offTitle:(NSString *)offTitle;
-(instancetype)initWithFrame:(CGRect)frame onTitle:(NSString *)onTitle offTitle:(NSString *)offTitle backgroundImage:(UIImage *)image;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
