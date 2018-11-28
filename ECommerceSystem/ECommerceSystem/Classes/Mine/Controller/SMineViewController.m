//
//  SMineViewController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SMineViewController.h"

#define oriOfftY -200
#define oriHeight 200

@interface SMineViewController() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mineTableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,assign) CGFloat imageHeight;
@end

@implementation SMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.imageHeight = 200;
    [self wjNavigationSettings];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KW_SCREEN, self.imageHeight)];
    self.headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mineTableView];
    [self.view addSubview:self.headerView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mineTableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
}

#pragma mark - navigation settings
- (void)wjNavigationSettings {
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 取消掉底部的那根线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置标题
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人主页";
    [title sizeToFit];
    // 开始的时候看不见，所以alpha值为0
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    
    self.navigationItem.titleView = title;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.textLabel.text = @"天上人间";
    return cell;
}
#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - oriOfftY;
    
    CGFloat imgH = oriHeight - offset;
    if (imgH < 64) {
        imgH = 64;
    }
    self.imageHeight = imgH;
    self.headerView.frame = CGRectMake(0, 0, KW_SCREEN, self.imageHeight);
    
    //根据透明度来生成图片
    //找最大值/
    CGFloat alpha = offset * 1 / 136.0;   // (200 - 64) / 136.0f
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    //拿到标题 标题文字的随着移动高度的变化而变化
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    //把颜色生成图片
    UIImage *alphaImage = [self imageWithColor:alphaColor];
    //修改导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    
}
- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 开启上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(ref, color.CGColor);
    // 渲染上下文
    CGContextFillRect(ref, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 懒加载
- (UITableView *)mineTableView
{
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KW_SCREEN, KH_SCREEN - self.TAB_HEIGHT) style:UITableViewStylePlain];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
    }
    return _mineTableView;
}

@end
