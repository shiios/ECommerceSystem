//
//  SToastObject.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/29.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SToastObject.h"

@implementation SToastObject
+ (void)showToastInView:(UIView *)view text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(text, @"HUD message title");
    hud.label.numberOfLines = 0;
    // Move to bottm center.
    //        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:1.f];
}

+ (void)showStatusWithText:(NSString *)text
{
    [SVProgressHUD setDefaultStyle: SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:text];
    
}
+ (void)dismiss
{
    [SVProgressHUD dismissWithDelay:0.5f];
}
@end
