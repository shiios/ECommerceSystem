//
//  SToastObject.h
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/29.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SToastObject : NSObject
//弹框
+ (void)showToastInView:(UIView *)view text:(NSString *)text;
//数据加载
+ (void)showStatusWithText:(NSString *)text;
//消失加载
+ (void)dismiss;
@end

NS_ASSUME_NONNULL_END
