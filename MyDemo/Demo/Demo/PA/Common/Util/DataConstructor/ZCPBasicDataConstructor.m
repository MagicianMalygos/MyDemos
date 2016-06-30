//
//  ZCPBasicDataConstructor.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPBasicDataConstructor.h"

@implementation ZCPBasicDataConstructor

#pragma mark - synthesize
@synthesize items       = _items;
@synthesize responder   = _responder;

#pragma mark - getter / setter
- (NSMutableArray *)items {
    if (_items == nil) {
        self.items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark - Override Method
- (void)constructData {
}

@end
