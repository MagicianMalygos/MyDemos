//
//  BookViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2017/6/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "BookViewController.h"
#import "BookPageViewController.h"

#define PAGESIZE    1000

@interface BookViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, copy) NSString *article;
@property (nonatomic, strong) BookPageViewController *currPageVC;
@property (nonatomic, strong) BookPageViewController *previousPageVC;
@property (nonatomic, strong) BookPageViewController *nextPageVC;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL next;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.doubleSided    = NO;
    self.dataSource     = self;
    self.delegate       = self;
    
    self.page = 1;
    
    [self.currPageVC setText:[self getTextWithPage:1]];
    [self.nextPageVC setText:[self getTextWithPage:2]];
    
    [self addChildViewController:self.currPageVC];
    [self addChildViewController:self.previousPageVC];
    [self addChildViewController:self.nextPageVC];
    [self setViewControllers:@[self.currPageVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
}

#pragma mark - private

- (NSString *)getTextWithPage:(NSInteger)page {
    NSString *text = nil;
    if (page < 0 || (page - 1) * PAGESIZE > self.article.length) {
        text = @"";
        return text;
    }
    
    if ((int)self.article.length - (page - 1) * PAGESIZE < PAGESIZE) {
        text = [self.article substringWithRange:NSMakeRange((page - 1) * PAGESIZE, (int)self.article.length - (page - 1) * PAGESIZE)];
        return text;
    }
    
    text = [self.article substringWithRange:NSMakeRange((page - 1) * PAGESIZE, PAGESIZE)];
    return text;
}

#pragma mark - UIPageViewControllerDataSource

// 返回当前视图控制器之前的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    self.next = NO;
    
    if (self.page == 1) {
        return nil;
    }
    return self.previousPageVC;
}
// 返回当前控制器之后的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    self.next = YES;
    
    if ((int)self.article.length - (self.page - 1) * PAGESIZE < PAGESIZE) {
        return nil;
    }
    
    return self.nextPageVC;
}

// A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
// Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 3;
//}
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 1;
//}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    NSLog(@"将要翻页");
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"结束翻页");
    
    if (!completed) {
        return;
    }
    if (self.next) {
        BookPageViewController *temp = self.nextPageVC;
        self.nextPageVC = self.previousPageVC;
        self.previousPageVC = self.currPageVC;
        self.currPageVC = temp;
        
        self.page ++;
    } else {
        BookPageViewController *temp = self.previousPageVC;
        self.previousPageVC = self.nextPageVC;
        self.nextPageVC = self.currPageVC;
        self.currPageVC = temp;
        
        self.page --;
    }
    
    [self.previousPageVC setText:[self getTextWithPage:self.page - 1]];
    [self.currPageVC setText:[self getTextWithPage:self.page]];
    [self.nextPageVC setText:[self getTextWithPage:self.page + 1]];
}

// 根据旋转方向设置书脊的位置
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return UIPageViewControllerSpineLocationMin;
}

// 支持旋转方向
- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationMaskAll;
}

// 初始旋转状态
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - getter / setter

- (BookPageViewController *)currPageVC {
    if (!_currPageVC) {
        _currPageVC = [[BookPageViewController alloc] init];
        _currPageVC.view.backgroundColor = [UIColor greenColor];
    }
    return _currPageVC;
}

- (BookPageViewController *)previousPageVC {
    if (!_previousPageVC) {
        _previousPageVC = [[BookPageViewController alloc] init];
        _previousPageVC.view.backgroundColor = [UIColor redColor];
    }
    return _previousPageVC;
}

- (BookPageViewController *)nextPageVC {
    if (!_nextPageVC) {
        _nextPageVC = [[BookPageViewController alloc] init];
        _nextPageVC.view.backgroundColor = [UIColor blueColor];
    }
    return _nextPageVC;
}

- (NSString *)article {
    if (!_article) {
//        _article = @"人活着的，只是事情多，不计较白天和黑夜。人一旦死了日子就堆起来；算一算，再有20天，我妈3周年了。\n3年里，我一直有个奇怪的想法，就是觉得我妈没有死，而且还觉得我妈自己也不以为她就死了。常说人死如睡，可睡的人是知道要睡去，睡在了床上，却并不知道在什么时候睡着的呀。我妈跟我在西安生活了14年。大病后医生认定她的各个器官已衰竭，我送她回棣花老家维持治疗。每日在老家挂液体，她也清楚每一瓶液体完了，儿女们会换上另一瓶液体，所以便放心地闭了眼躺着。到了第3天的晚上，她闭着的眼再没有睁开。但她肯定还是认为她在挂液体了，没有意识到从此再不醒来。她躺下时，还让我妹把给她擦脸的毛巾洗一洗，梳子放在了枕边，系在裤带上的钥匙没有解，也没有交待任何后事啊。\n3年以前我每打喷嚏，总要说一句：这是谁想我呀？我妈爱说笑，就接茬说：谁想哩，妈想哩！这3年里，我的喷嚏尤其多，往往错过吃饭时间，熬夜太久，就要打喷嚏。喷嚏一打，便想到我妈了，认定是我妈还在牵挂我哩。我妈在牵挂着我，她并不以为她已经死了。我更是觉得我妈还在，尤其我一个人静静地呆在家里，这种感觉就十分强烈。我常在写作时，突然能听到我妈在叫我。叫得很真切，一听到叫声我便习惯地朝右边扭过头去。从前我妈坐在右边那个房间的床头上，我一伏案写作，她就不再走动，也不出声，却要一眼一眼看着我，看得时间久了，她要叫我一声，然后说：世上的字你能写完吗，出去么。现在，每听到我妈叫我，我就放下笔走进那个房间，心想我妈从棣花来西安了？当然房间里什么也没有，却要立上半天，自言自语，妈是来了又出门，去街上给我买青辣子和萝卜。或许，她在逗我，故意藏到挂在墙上的她那张照片里，我便给照片前的香炉里上香，要说上一句：我不累。 整整3年了，我给别人写过了十多篇文章，却始终没给我妈写过一个字。因为所有的母亲，儿女们都认为是伟大又善良，我不愿意重复这些词语。我妈是一位普通的妇女，缠过脚，没有文化，户籍还在乡下，但我妈对于我是那样的重要。已经很长时间了，虽然再不为她的病而提心吊胆了，可我出远门，再没有人啰啰嗦嗦地叮嘱着这样叮嘱着那样，我有了好吃的好喝的，也不知道该送给谁去。\n在西安的家里，我妈住过的那个房间，我没有动一件家具，一切摆设还原模原样，而我再没有看见过我妈的身影，我一次又一次难受着，给自己说，我妈没有死，她是住回乡下老家了。今年的夏天太湿太热，每晚被湿热醒来，恍惚里还想着该给我妈的房间换个新空调了。待清醒过来，又宽慰着我妈在乡下的新住处里，应该是清凉的吧。\n3周年的日子一天天临近。乡下的风俗是要办一场仪式的，我准备着香烛花果，回一趟棣花了。但一回棣花，就要去坟上，现实告诉着我妈是死了，我在地上，她在地下，阴阳两隔，母子再也难以相见，顿时热泪肆流，长声哭泣啊。";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"笑傲江湖" ofType:@".txt"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _article = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _article;
}

@end
