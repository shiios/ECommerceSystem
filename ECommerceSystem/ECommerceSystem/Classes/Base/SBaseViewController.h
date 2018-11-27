//
//  SBaseViewController.h
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBaseViewController : UIViewController

@property (nonatomic,assign) CGFloat NAV_HEIGHT;
@property (nonatomic,assign) CGFloat TAB_HEIGHT;
- (void)back_click:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
