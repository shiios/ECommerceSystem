//
//  SCustomeNavgationViewController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SCustomeNavgationViewController.h"

@interface SCustomeNavgationViewController ()

@end

@implementation SCustomeNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    // 重新设置侧滑手势的代理
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]
                                               };
}
// 开始接收到手势的代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断是否是侧滑相关的手势
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // 如果当前展示的控制器是根控制器就不让其响应
        if (self.viewControllers.count < 2 ||
            self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
