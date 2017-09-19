//
//  DecoratorGPS.h
//  Demo
//
//  Created by 朱超鹏 on 2017/9/18.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "Decorator.h"

@interface DecoratorGPS : Decorator

@property (nonatomic, assign, readonly) BOOL gps;

- (NSString *)closeGPS;
- (NSString *)openGPS;

@end
