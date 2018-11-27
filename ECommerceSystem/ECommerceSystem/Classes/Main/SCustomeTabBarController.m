//
//  SCustomeTabBarController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SCustomeTabBarController.h"
#import "SHomeViewController.h"
#import "SMessageViewController.h"
#import "SMineViewController.h"
#import "SRepublishViewController.h"
#import "SHotViewController.h"
#import "AppDelegate.h"
#import "STabBar.h"


#import <AudioToolbox/AudioToolbox.h>

@interface SCustomeTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) STabBar *mcTabbar;
@property (nonatomic, assign) NSUInteger selectItem;//选中的item

@end

@implementation SCustomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mcTabbar = [[STabBar alloc] init];
    [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _mcTabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    
    self.selectItem = 0; //默认选中第一个
    self.delegate = self;
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[SHomeViewController alloc] init] andTitle:@"首页" andImageName:@"tab1" andSelectImage:@"tab1_p"];
    [self addChildrenViewController:[[SHotViewController alloc] init] andTitle:@"热门" andImageName:@"tab2" andSelectImage:@"tab2_p"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[SRepublishViewController alloc] init] andTitle:@"发布" andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[SMessageViewController alloc] init] andTitle:@"消息" andImageName:@"tab3" andSelectImage:@"tab3_p"];
    [self addChildrenViewController:[[SMineViewController alloc] init] andTitle:@"我的" andImageName:@"tab4" andSelectImage:@"tab4_p"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    self.tabBar.tintColor = [UIColor redColor];
    UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
    
    self.selectItem = 2;
}

//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[tabBarController.selectedIndex] layer] addAnimation:pulse forKey:nil];
    self.selectItem = tabBarController.selectedIndex;
    
    
}
////旋转动画
//- (void)rotationAnimation{
//    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
//    rotationAnimation.duration = 3.0;
//    rotationAnimation.repeatCount = HUGE;
//    [_mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
//}
//
//
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        /**
//         *  设置 TabBar
//         */
//        SHomeViewController *home                 = [[SHomeViewController alloc] init];
//        UINavigationController *homeNav            = [[UINavigationController alloc] initWithRootViewController:home];
//        homeNav.tabBarItem.title                   = @"首页";
//        homeNav.tabBarItem.selectedImage           = [UIImage imageNamed:@"tab1_p"];
//        homeNav.tabBarItem.image                   = [UIImage imageNamed:@"tab1"];
//
//        SMicroscouringViewController *micros     = [[SMicroscouringViewController alloc] init];
//        UINavigationController *microsNav        = [[UINavigationController alloc] initWithRootViewController:micros];
//        microsNav.tabBarItem.title               = @"热门";
//        microsNav.tabBarItem.selectedImage       = [UIImage imageNamed:@"tab2_p"];
//        microsNav.tabBarItem.image               = [UIImage imageNamed:@"tab2"];
//
//        SMessageViewController *message           = [[SMessageViewController alloc] init];
//        UINavigationController *messageNav       = [[UINavigationController alloc] initWithRootViewController:message];
//        messageNav.tabBarItem.title              = @"消息";
//        messageNav.tabBarItem.selectedImage      = [UIImage imageNamed:@"tab3_p"];
//        messageNav.tabBarItem.image              = [UIImage imageNamed:@"tab3"];
//
//        SShoppingCartViewController *shoppingCart = [[SShoppingCartViewController alloc] init];
//        UINavigationController *shoppingCartNav    = [[UINavigationController alloc] initWithRootViewController:shoppingCart];
//        shoppingCartNav.tabBarItem.title           = @"购物车";
//        shoppingCartNav.tabBarItem.selectedImage   = [UIImage imageNamed:@"tab4_p"];
//        shoppingCartNav.tabBarItem.image           = [UIImage imageNamed:@"tab4"];
//
//        SMineViewController *account             = [[SMineViewController alloc] init];
//        UINavigationController *accountNav         = [[UINavigationController alloc] initWithRootViewController:account];
//        accountNav.tabBarItem.title                = @"我的";
//        accountNav.tabBarItem.selectedImage        = [UIImage imageNamed:@"tab5_p"];
//        accountNav.tabBarItem.image                = [UIImage imageNamed:@"tab5"];
//
//        self.viewControllers  = @[homeNav, microsNav, messageNav, shoppingCartNav, accountNav];
//        self.tabBar.tintColor = [UIColor redColor];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    if ([self.view window] == nil) {
//        self.view = nil;
//    }
//}
//
//
//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    [self animationWithIndex:index];//动画
//    [self playSound];//音效
//    if([item.title isEqualToString:@"首页"]){
//
//    }
//}
//
//
//
//-(void) playSound{
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
//    SystemSoundID soundID;
//    NSURL *soundURL = [NSURL fileURLWithPath:path];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
//    AudioServicesPlaySystemSound(soundID);
//
//}
//
//- (void)animationWithIndex:(NSInteger) index {
//    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabbarbuttonArray addObject:tabBarButton];
//        }
//    }
//
//    if (index == 0) { //顺时针旋转效果
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        animation.duration = 0.3;
//        //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
//        animation.repeatCount = 1;
//        animation.autoreverses = NO;
//        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
//        animation.fromValue = [NSNumber numberWithFloat:0.f];
//        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
//        [[tabbarbuttonArray[index] layer] addAnimation:animation forKey:nil];
//
//    }else{ //抖动效果
//        CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        pulse.duration = 0.1;
//        pulse.repeatCount = 1;
//        pulse.autoreverses = YES;
//        pulse.fromValue = [NSNumber numberWithFloat:0.7];
//        pulse.toValue = [NSNumber numberWithFloat:1.3];
//        [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
//    }
//}

@end
