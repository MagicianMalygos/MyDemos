//
//  ZCPViewController.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPViewController.h"

@implementation ZCPViewController

#pragma mark - synthesize
@synthesize tap                         = _tap;
@synthesize needsTapToDismissKeyboard   = _needsTapToDismissKeyboard;
@synthesize formerViewController        = _formerViewController;
@synthesize latterViewController        = _latterViewController;
@synthesize viewJumpModel               = _viewJumpModel;

// ----------------------------------------------------------------------
#pragma mark - init
// ----------------------------------------------------------------------
- (instancetype)initWithQuery:(NSDictionary *)query {
    if (self = [super init]) {
    }
    return self;
}
- (void)dealloc {
    // 移除键盘事件监听
    [self breakdown];
}

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------
- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 键盘点击隐藏事件
    self.needsTapToDismissKeyboard = @YES;
    if ([self isHideLeftBarButton] == NO) {
        [self setBackBarButton];
    }
    // 添加键盘响应事件
    [self registerKeyboardNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

// ----------------------------------------------------------------------
#pragma mark - keyboard
// ----------------------------------------------------------------------
/**
 *  添加键盘监听
 */
- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if (SYSTEM_VERSION >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

/**
 *  移除键盘监听
 */
- (void)breakdown {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    if (SYSTEM_VERSION >= 5.0) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    }
}

/**
 *  缩回键盘
 */
- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if ([self.needsTapToDismissKeyboard boolValue]) {
        [self.view addGestureRecognizer:self.tap];
    }
}
- (void)keyboardDidShow:(NSNotification *)notification {
}
- (void)keyboardWillHide:(NSNotification *)notification {
    if (_tap) {
        [self.view removeGestureRecognizer:self.tap];
    }
}
- (void)keyboardDidHide:(NSNotification *)notification {
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification {
}

// ----------------------------------------------------------------------
#pragma mark - Action Handler
// ----------------------------------------------------------------------
- (void)selfViewTapped:(UITapGestureRecognizer *)tap {
    if (tap.view == self.view) {
        // 让键盘消失
        [self dismissKeyboard];
    }
}

// ----------------------------------------------------------------------
#pragma mark - navigation bar
// ----------------------------------------------------------------------
- (BOOL)isHideLeftBarButton {
    return NO;
}
- (void)initNavigationBar {
}

//返回上级视图
- (void)backTo {
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tabBarController.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setBackBarButton {
}

// ----------------------------------------------------------------------
#pragma mark - jump / back
// ----------------------------------------------------------------------
- (void)presentViewController:(UIViewController<ZCPNavigatorProtocol> *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    self.latterViewController                       = viewControllerToPresent;
    viewControllerToPresent.formerViewController    = self;
    viewControllerToPresent.viewJumpModel           = ZCPViewModalJumpMode;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    self.formerViewController.latterViewController  = nil;
    [super dismissViewControllerAnimated:flag completion:completion];
}

// ----------------------------------------------------------------------
#pragma mark - getter / setter
// ----------------------------------------------------------------------
- (UITapGestureRecognizer *)tap {
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTapped:)];
        _tap.cancelsTouchesInView = YES;
    }
    return _tap;
}

@end
