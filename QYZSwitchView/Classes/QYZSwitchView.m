//
//  QYZSwitchView.m
//
//  Created by iMac-qinyuanzhi on 18/6/27.
//  Copyright © 2018年 iMac-qinyuanzhi. All rights reserved.
//

#import "QYZSwitchView.h"

@interface QYZSwitchView ()
    
@property(nonatomic,strong) UIImageView     *bgView;//背景图片
@property(nonatomic,strong) UIImageView     *btnView;//按钮图片

@property(nonatomic,strong) UILabel         *textLabelOff;//按钮图片
@property(nonatomic,strong) UILabel         *textLabelOn;//按钮图片

@property(nonatomic,assign) CGFloat         duration;//动画时长

@end

@implementation QYZSwitchView

-(instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame onTitle:nil offTitle:nil backgroundImage:nil];
}
    
-(instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)image {

    return [self initWithFrame:frame onTitle:nil offTitle:nil backgroundImage:image];
}
    
-(instancetype)initWithFrame:(CGRect)frame onTitle:(NSString *)onTitle offTitle:(NSString *)offTitle {
    return [self initWithFrame:frame onTitle:onTitle offTitle:offTitle backgroundImage:nil];
}
    
-(instancetype)initWithFrame:(CGRect)frame onTitle:(NSString *)onTitle offTitle:(NSString *)offTitle backgroundImage:(UIImage *)image {
    
    if (self = [super initWithFrame:frame]) {

        self.on = NO;
        self.duration = 0.3;
        
        if (onTitle) {
            [self addSubview:self.textLabelOn];
            self.textLabelOn.text = onTitle;
        }
        if (offTitle) {
            [self addSubview:self.textLabelOff];
            self.textLabelOff.text = offTitle;
        }

        [self addSubview:self.btnView];
        
        if (image) {
            [self addSubview:self.bgView];
            self.bgView.image = image;
        }

        self.imageOn = [UIImage imageNamed:@"sign_anonym"];
        self.imageOff = [UIImage imageNamed:@"default_avatar_ask"];
    }
    return self;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    self.on = on;
    if (on) {
        [self switchOpenAnimate:animated];
    } else {
        [self switchCloseAnimate:animated];
    }
}


//触摸方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (!self.on) {
        [self switchOpenAnimate:YES];
        self.on = YES;
  
    } else {
        
        [self switchCloseAnimate:YES];
        self.on = NO;
    }
    
    //实现协议方法
    if (self.statusBlock) {
        self.statusBlock(self.on);
    }
}

/**
 *  开启
 */
-(void)switchOpenAnimate:(BOOL)animate {
    
    CGFloat X = CGRectGetWidth(self.frame) - self.btnView.frame.size.width - 2;
    CGRect frame = self.btnView.frame;
    
    if (animate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.btnView setImage:self.imageOn];
        });
        /*创建弹性动画
         damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
         velocity:弹性复位的速度
         */
        self.textLabelOff.alpha = 1.0;
        self.textLabelOn.alpha = 0.0;
        [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.btnView setFrame:CGRectMake(X, frame.origin.y, frame.size.width, frame.size.height)];
            self.textLabelOn.alpha = 1.0;
            self.textLabelOff.alpha = 0.0;
        } completion:nil];
        
    } else {
        [self.btnView setImage:self.imageOn];
        [self.btnView setFrame:CGRectMake(X, frame.origin.y, frame.size.width, frame.size.height)];
        self.textLabelOn.alpha = 1.0;
        self.textLabelOff.alpha = 0.0;
    }
}

/**
 *  关闭
 */
-(void)switchCloseAnimate:(BOOL)animate {
    
    CGFloat X = 2;
    CGRect frame = self.btnView.frame;
    
    if (animate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.btnView setImage:self.imageOff];
        });
        self.textLabelOn.alpha = 1.0;
        self.textLabelOff.alpha = 0.0;
        [UIView animateWithDuration:self.duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.btnView setFrame:CGRectMake(X, frame.origin.y, frame.size.width, frame.size.height)];
            self.textLabelOn.alpha = 0.0;
            self.textLabelOff.alpha = 1.0;
        } completion:nil];
    } else {
        [self.btnView setImage:self.imageOff];
        [self.btnView setFrame:CGRectMake(X, frame.origin.y, frame.size.width, frame.size.height)];
        self.textLabelOn.alpha = 0.0;
        self.textLabelOff.alpha = 1.0;
    }
}

    
#pragma mark - getter and setter
- (UIImageView *)bgView {
        if (_bgView == nil) {
            CGFloat width = CGRectGetHeight(self.frame);
            _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,width, width)];
            //[_bgView setImage:[UIImage imageNamed:@"default_avatar_ask"]];
        }
        return _bgView;
    }
    
- (UILabel *)textLabelOn {
    if (_textLabelOn == nil) {
        _textLabelOn = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, CGRectGetWidth(self.frame)/2 - 5, CGRectGetHeight(self.frame) - 4)];
        _textLabelOn.backgroundColor = [UIColor clearColor];
        _textLabelOn.font = [UIFont systemFontOfSize:16.0];
        _textLabelOn.textColor = [UIColor grayColor];
        _textLabelOn.alpha = 0.0;
    }
    return _textLabelOn;
}
    
- (UILabel *)textLabelOff {
    if (_textLabelOff == nil) {
        _textLabelOff = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2, 2, CGRectGetWidth(self.frame) / 2 - 5, CGRectGetHeight(self.frame) - 4)];
        _textLabelOff.backgroundColor = [UIColor clearColor];
        _textLabelOff.font = [UIFont systemFontOfSize:16.0];
        _textLabelOff.textColor = [UIColor grayColor];
        _textLabelOff.textAlignment = NSTextAlignmentRight;
    }
    return _textLabelOff;
}
    
- (UIImageView *)btnView {
    if (_btnView == nil) {
        CGFloat width = CGRectGetHeight(self.frame);
        _btnView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,width, width)];
        [_btnView setImage:[UIImage imageNamed:@"default_avatar_ask"]];
    }
    return _btnView;
}

@end
