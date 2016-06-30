//
//  UIButton+Category.m
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

// 设置圆形
- (void)changeToRound {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.layer.bounds.size.height * 0.5;
}
// 设置圆角
- (void)changeToFillet {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
}

@end
