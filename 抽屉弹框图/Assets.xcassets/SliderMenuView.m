//
//  SliderMenuView.m
//  抽屉弹框图
//
//  Created by wyx on 2019/7/26.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "SliderMenuView.h"
#import "slideMenuBtn.h"
#define menwidth 50
#define btnHeight 40
#define btnSapce 30
@interface SliderMenuView(){
    UIWindow *keywindow;
    UIVisualEffectView *feeView;
    BOOL ifshow;
    UIColor *mainCOlor;
    UIView *helpSideView;
    UIView *helpCenterView;
    CADisplayLink *dispalyLink;
     CGFloat diff;
   
}


@end

@implementation SliderMenuView
- (instancetype)initWithTitleArr:(NSArray *)titles{
    self = [super init];
    if (self) {
        keywindow = [UIApplication sharedApplication].delegate.window;
        UIVisualEffectView *bfeeView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        mainCOlor = [UIColor blueColor];
        feeView = bfeeView;
        bfeeView.frame = keywindow.frame;
        bfeeView.alpha = .5;
        self.frame = CGRectMake(-(CGRectGetWidth(keywindow.frame)/2 + menwidth), 0, CGRectGetWidth(keywindow.frame)/2 + menwidth, CGRectGetHeight(keywindow.frame));
      
        self.backgroundColor = [UIColor redColor];
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dimissal)];
        [feeView addGestureRecognizer:tap];
        helpSideView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
        helpSideView.backgroundColor = [UIColor purpleColor];
        helpCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, CGRectGetHeight(keywindow.frame)/2 - 20, 40, 40)];
        helpCenterView.backgroundColor = [UIColor lightGrayColor];
        [keywindow addSubview:helpCenterView];
        [keywindow addSubview:helpSideView];
        [keywindow insertSubview:self belowSubview:helpCenterView];
        [self btnSetTitles:titles];
    }
    return self;
}
- (void)btnSetTitles:(NSArray *)titlesArr{
    CGFloat space = ((CGRectGetHeight)(keywindow.frame) - titlesArr.count *  btnHeight - (titlesArr.count - 1) * btnSapce)/2;
    for (int i = 0; i < titlesArr.count; i++) {
        slideMenuBtn *sBtn = [[slideMenuBtn alloc]initWithTitle:titlesArr[i]];
        sBtn.center = CGPointMake(CGRectGetWidth(keywindow.bounds)/4, space + btnHeight*i + btnSapce*i + btnHeight/2);
         sBtn.bounds = CGRectMake(0, 0, CGRectGetWidth(keywindow.bounds)/2 - 20*2, btnHeight);
        [self addSubview:sBtn];
    }
   
}
- (void)addBtnAnni{
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *btn =self.subviews[i];
        btn.transform = CGAffineTransformMakeTranslation(-100,0);
        [UIView   animateWithDuration:.6   delay:i * (0.4/self.subviews.count) usingSpringWithDamping:.5 initialSpringVelocity:.6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            btn.transform = CGAffineTransformIdentity;
            NSLog(@"CGAffineTransformIdentity===%@",NSStringFromCGRect(btn.frame));
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)switchClick{
    if (!ifshow) {
        self.frame = self.bounds;
        feeView.alpha = 1;
        [keywindow insertSubview:feeView belowSubview:self];
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            helpSideView.center = CGPointMake(keywindow.center.x, CGRectGetHeight(helpSideView.bounds)/2);
          
        } completion:^(BOOL finished) {
            
        }];
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
             helpCenterView.center = keywindow.center;
            
        } completion:^(BOOL finished) {
            [self removeDisplay];
        }];
        [self getDiff];
        [self addBtnAnni];
    }
}
- (void)removeDisplay{
    [dispalyLink invalidate];
    dispalyLink = nil;
}
- (void)getDiff{
    if (!dispalyLink) {
        dispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [dispalyLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}
- (void)displayLinkAction:(CADisplayLink *)link{
    CALayer *layer1 = helpSideView.layer.presentationLayer;
    CALayer *layer2= helpCenterView.layer.presentationLayer;
    CGRect r1 = [[layer1 valueForKeyPath:@"frame"] CGRectValue];
    CGRect r2 = [[layer2 valueForKeyPath:@"frame"] CGRectValue];
    diff = r1.origin.x - r2.origin.x;
    NSLog(@"diff===%f",diff);
    [self setNeedsDisplay];
}
- (void)dimissal{
    ifshow = NO;
    [UIView animateWithDuration:.2 animations:^{
        self.frame = CGRectMake(-(CGRectGetWidth(keywindow.frame)/2 + menwidth), 0, CGRectGetWidth(keywindow.frame)/2 + menwidth, CGRectGetHeight(keywindow.frame));
        feeView.alpha = 0;
        helpSideView.center = CGPointMake(-CGRectGetWidth(helpSideView.frame), CGRectGetHeight(helpSideView.frame));
        helpCenterView.center = CGPointMake(-CGRectGetWidth(helpSideView.frame), CGRectGetHeight(keywindow.frame)/2);
    }];
    
}
- (void)drawRect:(CGRect)rect{
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(0, 0)];
    [bPath addLineToPoint:CGPointMake(CGRectGetWidth(keywindow.frame)/2, 0)];
    [bPath addQuadCurveToPoint:CGPointMake(CGRectGetWidth(keywindow.frame)/2,CGRectGetHeight(keywindow.frame)) controlPoint:CGPointMake(CGRectGetWidth(keywindow.frame)/2 + diff, CGRectGetHeight(keywindow.frame)/2)];
    [bPath addLineToPoint:CGPointMake(0,  CGRectGetHeight(keywindow.frame))];
 
    [bPath closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, bPath.CGPath);
       [mainCOlor set];
    CGContextFillPath(context);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
