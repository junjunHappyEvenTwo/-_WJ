//
//  SliderMenuView.h
//  抽屉弹框图
//
//  Created by wyx on 2019/7/26.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SliderMenuView : UIView
- (instancetype)initWithTitleArr:(NSArray *)titles;
- (void)switchClick;
@end

NS_ASSUME_NONNULL_END
