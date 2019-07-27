//
//  slideMenuBtn.m
//  抽屉弹框图
//
//  Created by wyx on 2019/7/27.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "slideMenuBtn.h"
@interface slideMenuBtn(){
    NSString *btnTitle;
    UIColor *color;
}
@end

@implementation slideMenuBtn

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        btnTitle = title;
        color = [UIColor whiteColor];
    }
    return self;
}
/*
 
 
 */
- (void)drawRect:(CGRect)rect{
    NSLog(@"%@",NSStringFromCGRect(rect));
    NSLog(@"%@",NSStringFromCGRect(CGRectInset(rect, 2, 2)));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:CGRectGetHeight(rect)/2];
    path.lineWidth = 4;
    
    [[UIColor greenColor] setFill];
    [path fill];
    [color setStroke];
    [path stroke];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle]mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = @{NSParagraphStyleAttributeName:style,
                          NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    CGSize size2 = [btnTitle sizeWithAttributes:attr];
    CGRect r = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - size2.height)/2.0, rect.size.width, size2.height);
    [btnTitle drawInRect:r withAttributes:attr];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
