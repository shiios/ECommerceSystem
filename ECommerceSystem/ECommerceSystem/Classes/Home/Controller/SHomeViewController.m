//
//  SHomeViewController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SHomeViewController.h"

@interface SHomeViewController() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mineTableView;

@end

@implementation SHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";

    [self.view addSubview:self.mineTableView];
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
