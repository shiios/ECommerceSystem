//
//  SRepublishViewController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SRepublishViewController.h"
#import "SWaitSaleListViewController.h"
#import "BHBPopView.h"


@interface SRepublishViewController ()



@end

@implementation SRepublishViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加背景图
    [self addBackImage];
}

/**
 *  添加背景图
 */
- (void)addBackImage{
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"backgroundImage"];
    [self.view addSubview:backImageView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"文字" Icon:@"images.bundle/tabbar_compose_idea"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"相册" Icon:@"images.bundle/tabbar_compose_photo"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"拍照" Icon:@"images.bundle/tabbar_compose_camera"];
//    //第4个按钮内部有一组
//    BHBGroup * item3 = [[BHBGroup alloc]initWithTitle:@"Check in" Icon:@"images.bundle/tabbar_compose_lbs"];
//    BHBItem * item31 = [[BHBItem alloc]initWithTitle:@"Friend Circle" Icon:@"images.bundle/tabbar_compose_friend"];
//    BHBItem * item32 = [[BHBItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
//    BHBItem * item33 = [[BHBItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
//    item3.items = @[item31,item32,item33];
//
//    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"Review" Icon:@"images.bundle/tabbar_compose_review"];
//
//    //第六个按钮内部有一组
//    BHBGroup * item5 = [[BHBGroup alloc]initWithTitle:@"More" Icon:@"images.bundle/tabbar_compose_more"];
//    BHBItem * item51 = [[BHBItem alloc]initWithTitle:@"Friend Circle" Icon:@"images.bundle/tabbar_compose_friend"];
//    BHBItem * item52 = [[BHBItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
//    BHBItem * item53 = [[BHBItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
//    BHBItem * item54 = [[BHBItem alloc]initWithTitle:@"Blog" Icon:@"images.bundle/tabbar_compose_weibo"];
//    BHBItem * item55 = [[BHBItem alloc]initWithTitle:@"Collection" Icon:@"images.bundle/tabbar_compose_transfer"];
//    BHBItem * item56 = [[BHBItem alloc]initWithTitle:@"Voice" Icon:@"images.bundle/tabbar_compose_voice"];
//    item5.items = @[item51,item52,item53,item54,item55,item56];
    
    
    //添加popview
    [BHBPopView showToView:self.view.window withItems:@[item0,item1,item2,]andSelectBlock:^(BHBItem *item) {
        if ([item isKindOfClass:[BHBGroup class]]) {
            NSLog(@"选中%@分组",item.title);
        }else{
            NSLog(@"选中%@项",item.title);
        }
    }];
    
    //添加popview
    //    [BHBPopView showToView:self.view andImages:@[@"images.bundle/tabbar_compose_idea",@"images.bundle/tabbar_compose_photo",@"images.bundle/tabbar_compose_camera",@"images.bundle/tabbar_compose_lbs",@"images.bundle/tabbar_compose_review",@"images.bundle/tabbar_compose_more"] andTitles:@[@"Text",@"Albums",@"Camera",@"Check in",@"Review",@"More"] andSelectBlock:^(BHBItem *item) {
    //
    //    }];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//     self.navigationItem.title = @"发布宝贝";
//
//    [self customNavUI];
//}
//
//- (void)customNavUI
//{
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setTitle:@"待卖清单" forState:UIControlStateNormal];
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    rightButton.frame = CGRectMake(-10, 0, 80, 50);
//    [rightButton setTitleColor:UIColorWithHex(0x575757) forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(waitSaleBtn) forControlEvents:UIControlEventTouchUpInside];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 5.0, 80.0, 50.0)];
//    [view addSubview:rightButton];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
//
//    self.navigationItem.rightBarButtonItem = rightItem;
//
//}
//
//- (void)waitSaleBtn
//{
//    SWaitSaleListViewController *waitVc = [[SWaitSaleListViewController alloc]init];
//    waitVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:waitVc animated:YES];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
