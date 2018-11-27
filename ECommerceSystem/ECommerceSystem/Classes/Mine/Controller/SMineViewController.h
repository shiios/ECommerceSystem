//
//  SMineViewController.h
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMineViewController : SBaseViewController
//  cover视图
@property (nonatomic, weak) UIView * coverView;

//  nav视图
@property (nonatomic, weak) UIView* navView;

//标题
@property (strong,nonatomic) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
