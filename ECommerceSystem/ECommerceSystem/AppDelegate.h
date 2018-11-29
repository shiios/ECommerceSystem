//
//  AppDelegate.h
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"


@protocol WeiBoDelegate <NSObject>

//登录的代理
-(void)weiboLoginByResponse:(WBBaseResponse *)response;
//分享的大力
-(void)weiboShareSuccessCode:(NSInteger)shareResultCode;
@end


@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak  , nonatomic) id<WeiBoDelegate> weiboDelegate;


@end

