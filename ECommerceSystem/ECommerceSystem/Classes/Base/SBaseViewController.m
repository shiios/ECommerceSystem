//
//  SBaseViewController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SBaseViewController.h"
#import "SHomeViewController.h"
#import "SMessageViewController.h"
#import "SMineViewController.h"
#import "SRepublishViewController.h"
#import "SHotViewController.h"

@interface SBaseViewController ()

@end

@implementation SBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self config_NAV_LEFT_BARITEM];
    self.view.backgroundColor = UIColorWithHex(0xEBEBF1);
    
    [self setConstant];
    [self config_NAV_LEFT_BARITEM];
}
- (void)config_NAV_LEFT_BARITEM
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(-10, 0, 50, 50);
    
    [leftButton setImage:[UIImage imageNamed:@"left_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 5.0, 50.0, 50.0)];
    [view addSubview:leftButton];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    for (UIViewController *Vc in self.navigationController.childViewControllers) {
        if ([Vc isKindOfClass:[SHotViewController class]] || [Vc isKindOfClass:[SHotViewController class]] || [Vc isKindOfClass:[SMineViewController class]] || [Vc isKindOfClass:[SMessageViewController class]] || [Vc isKindOfClass:[SRepublishViewController class]] || [Vc isKindOfClass:[SHomeViewController class]]) {

            self.navigationItem.leftBarButtonItem.customView.hidden = YES;

        }else{
            self.navigationItem.leftBarButtonItem.customView.hidden = NO;
        }

    }
}

- (void)back_click:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setConstant
{
    if (KH_SCREEN < 812) {
        self.NAV_HEIGHT = 64.0;
        self.TAB_HEIGHT = 49;
    }else{
        self.NAV_HEIGHT = 88;
        self.TAB_HEIGHT = 83;
    }
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
