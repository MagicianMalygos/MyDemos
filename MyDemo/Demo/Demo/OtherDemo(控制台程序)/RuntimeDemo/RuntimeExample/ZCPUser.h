//
//  ZCPUser.h
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCPUser : NSObject <NSCoding>
{
    NSNumber *_level;
}

- (NSNumber *)level;
- (void)setLevel:(NSNumber *)level;

@property (nonatomic, copy) NSString *uID;

@end

#import "ZCPUser+AddProperty.h"
