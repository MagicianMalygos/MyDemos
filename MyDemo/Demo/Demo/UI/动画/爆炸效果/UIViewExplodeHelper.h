//
//  UIViewExplodeHelper.h
//  Demo
//
//  Created by 朱超鹏 on 2018/6/25.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 爆炸状态
typedef NS_ENUM(NSInteger, UIViewExplodeState) {
    UIViewExplodeStateInitial   = 0, //!< 初始化状态
    UIViewExplodeStateExploding = 1, //!< 正在爆炸状态
    UIViewExplodeStateExploded  = 2, //!< 已爆炸状态
};

/// 爆炸效果
typedef NS_ENUM(NSInteger, UIViewExplodeEffect) {
    UIViewExplodeEffectGravity  = 0, //!< 重力爆炸效果
    UIViewExplodeEffectShockWave= 1  //!< 冲击波爆炸效果
};

/// 爆炸效果辅助类
@interface UIViewExplodeHelper : NSObject

/// 执行爆炸效果的view
@property (nonatomic, weak) UIView *view;
/// 爆炸状态
@property (nonatomic, assign) UIViewExplodeState explodeState;
/// 爆炸效果
@property (nonatomic, assign) UIViewExplodeEffect explodeEffect;

/// 开始爆炸
- (void)explode;
/// 恢复状态
- (void)recover;

@end
