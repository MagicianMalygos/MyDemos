//
//  Note.h
//  PersistenceLayer
//
//  Created by 朱超鹏 on 2017/6/13.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *content;

@end
