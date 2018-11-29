//
//  SLoginViewController.m
//  OASystem
//
//  Created by Sandwind on 2018/5/30.
//  Copyright © 2018年 Sandwind. All rights reserved.
//

#import "SLoginViewController.h"
#import "SCustomeTabBarController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "AppDelegate.h"


@interface SLoginViewController ()<UITextFieldDelegate,TencentSessionDelegate,WeiBoDelegate>

{
    AppDelegate *delgate;
}
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UITextField *userTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) TencentOAuth *tencentOAuth;



//登录时加一个看不见的蒙版，让控件不能再被点击
@property (nonatomic,strong) UIView *HUDView;
//执行登录按钮动画的view (动画效果不是按钮本身，而是这个view)
@property (nonatomic,strong) UIView *LoginAnimView;
//登录转圈的那条白线所在的layer
@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@end

@implementation SLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.loginBtn];
    [self createThirdLogin];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 懒加载

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.backgroundColor = [UIColor redColor];
        _logoImageView.frame = CGRectMake((KW_SCREEN - KW(120)) / 2.0, KH(100), KW(120), KW(96));
    }
    return _logoImageView;
}

- (UITextField *)userTextField
{
    if (!_userTextField) {
        _userTextField = [[UITextField alloc] init];
        _userTextField.font = [UIFont systemFontOfSize:20];
        _userTextField.frame = CGRectMake(KW_SCREEN*0.2, CGRectGetMaxY(self.logoImageView.frame) + KH(40), KW_SCREEN*0.6, KH(30));
        [_userTextField setValue:[NSNumber numberWithInt:KH(15)] forKey:@"paddingLeft"];
        UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        eyeBtn.frame = CGRectMake(0, 0, KW(18), KH(22));
        
        _userTextField.delegate = self;
        [eyeBtn setImage:[UIImage imageNamed:@"User"] forState:UIControlStateNormal];
        _userTextField.leftView = eyeBtn;
        _userTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *seperatorLine = [[UIView alloc] init];
        [self.view addSubview:seperatorLine];
        seperatorLine.backgroundColor = UIColorWithHex(0xa8a8a8);
        seperatorLine.frame = CGRectMake(_userTextField.frame.origin.x, CGRectGetMaxY(_userTextField.frame) + KH(2), _userTextField.frame.size.width, KH(1));
        
    }
    return _userTextField;
}

- (UITextField *)pwdTextField
{
    if(_pwdTextField == nil)
    {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.font = [UIFont systemFontOfSize:20];
        _pwdTextField.frame = CGRectMake(KW_SCREEN*0.2, CGRectGetMaxY(self.userTextField.frame) + KH(16), KW_SCREEN*0.6, KH(30));
        [_pwdTextField setValue:[NSNumber numberWithInt:KH(15)] forKey:@"paddingLeft"];
        _pwdTextField.borderStyle = UITextBorderStyleNone;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.tintColor = RGBColor(156, 197, 251);
#warning 测试密码
        self.pwdTextField.textColor = [UIColor blackColor];
        _pwdTextField.delegate = self;
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, KW(18), KH(22));
        [leftBtn setImage:[UIImage imageNamed:@"PWD"] forState:UIControlStateNormal];
        _pwdTextField.leftView = leftBtn;
        _pwdTextField.leftViewMode = UITextFieldViewModeAlways;
        UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        eyeBtn.frame = CGRectMake(0, 0, KW(24), KH(28));
        [eyeBtn setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [eyeBtn setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _pwdTextField.rightView = eyeBtn;
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
        
        
        UIView *seperatorLine = [[UIView alloc] init];
        [self.view addSubview:seperatorLine];
        seperatorLine.backgroundColor = UIColorWithHex(0xa8a8a8);
        seperatorLine.frame = CGRectMake(_pwdTextField.frame.origin.x, CGRectGetMaxY(_pwdTextField.frame) + KH(2), _pwdTextField.frame.size.width, KH(1));
        
        
    }
    return _pwdTextField;
}
#pragma mark - 密码的显示隐藏
- (void)eyeBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        _pwdTextField.secureTextEntry = NO;
    }else{
        _pwdTextField.secureTextEntry = YES;
    }
}
- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(KW_SCREEN*0.25, CGRectGetMaxY(self.pwdTextField.frame) + KH(45), KW_SCREEN * 0.5, KH(40));
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _loginBtn.hidden = NO;
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor clearColor];
        _loginBtn.layer.cornerRadius = 4.0;
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.borderColor = UIColorWithHex(0xa8a8a8).CGColor;
        _loginBtn.layer.borderWidth = 0.5;
        [_loginBtn addTarget:self action:@selector(LoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _loginBtn;
}

- (void)createThirdLogin
{
    
    for (int i = 0; i < 3; i++) {
        UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdButton.frame = CGRectMake(KW_SCREEN*0.03 + i * KW_SCREEN * 0.3 , CGRectGetMaxY(self.loginBtn.frame) + KH(45), KW_SCREEN * 0.3, KH(40));
        thirdButton.titleLabel.font = [UIFont systemFontOfSize:20];
        thirdButton.hidden = NO;
        [thirdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i == 0) {
            [thirdButton setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
        }else if (i == 1){
            [thirdButton setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        }else if (i == 2){
            [thirdButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        }
        
//        thirdButton.backgroundColor = [UIColor clearColor];
//        thirdButton.layer.cornerRadius = 4.0;
//        thirdButton.layer.masksToBounds = YES;
//        thirdButton.layer.borderColor = UIColorWithHex(0xa8a8a8).CGColor;
//        thirdButton.layer.borderWidth = 0.5;
        thirdButton.tag = i + 10;
        [thirdButton addTarget:self action:@selector(thirdButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:thirdButton];
    }
    
}

- (void)thirdButtonClick:(UIButton *)sender
{
    if (sender.tag == 10) {
        NSLog(@"微博");
        [SToastObject showToastInView:self.view text:@"微博授权登录被点击"];
        
        [self weiboLoginButtonPressed];
        
        
    }else if (sender.tag == 11){
        NSLog(@"微信");
        [SToastObject showToastInView:self.view text:@"微信授权登录被点击"];
    }else if (sender.tag == 12){
        NSLog(@"QQ");
//        [SToastObject showToastIrnView:self.view text:@"QQ授权登录被点击"];
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1108004556" andDelegate:self];
        _tencentOAuth.authShareType = AuthShareType_QQ;//特别要注意，登录前需要授权，否则会爆出未授权错误（多看文档还是有好处的哈）
        NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
        [_tencentOAuth authorize:permissions inSafari:NO];
        
    }
}

#pragma mark - 微博授权登录
- (void)weiboLoginButtonPressed
{
    NSLog(@"%s",__func__);
#define kRedirectURI    @"https://me.csdn.net"
    delgate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delgate.weiboDelegate = self;

    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;

    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

-(void)weiboLoginByResponse:(WBBaseResponse *)response{
    NSDictionary *dic = (NSDictionary *) response.requestUserInfo;
    NSLog(@"userinfo %@",dic);
    
}
- (IBAction)weiboShareAction:(id)sender {
}

#pragma mark - qq授权登录
- (void)tencentDidLogin
{
    NSLog(@"yes");
    NSLog(@"%@ -- %@",_tencentOAuth.accessToken, _tencentOAuth.openId);// 打印下accessToken和openId 代表我成功了，存储起来用的时候直接用，或者此处请求服务器接口传给服务器，获取我们项目中用到的userSession
    //获取用户个人信息
    [_tencentOAuth getUserInfo];
    [SToastObject showToastInView:self.view text:@"QQ授权登录登录成功"];
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        NSLog(@"取消登录");
    }
}
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}
-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
}
#pragma mark - login按钮点击事件——执行动画
- (void)LoginButtonClick
{
    [self.view endEditing:YES];
    
    //HUDView，盖住view，以屏蔽掉点击事件
    self.HUDView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KW_SCREEN, KH_SCREEN)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.HUDView];
    self.HUDView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    //执行登录按钮转圈动画的view
    self.LoginAnimView = [[UIView alloc] initWithFrame:self.loginBtn.frame];
    self.LoginAnimView.layer.cornerRadius = 10;
    self.LoginAnimView.layer.masksToBounds = YES;
    self.LoginAnimView.frame = self.loginBtn.frame;
    self.LoginAnimView.backgroundColor = self.loginBtn.backgroundColor;
    [self.view addSubview:self.LoginAnimView];
    self.loginBtn.hidden = YES;
    
    //把view从宽的样子变圆
    CGPoint centerPoint = self.LoginAnimView.center;
    CGFloat radius = MIN(self.loginBtn.frame.size.width, self.loginBtn.frame.size.height);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.LoginAnimView.frame = CGRectMake(0, 0, radius, radius);
        self.LoginAnimView.center = centerPoint;
        self.LoginAnimView.layer.cornerRadius = radius/2;
        self.LoginAnimView.layer.masksToBounds = YES;
        
    }completion:^(BOOL finished) {
        
        //给圆加一条不封闭的白色曲线
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path addArcWithCenter:CGPointMake(radius/2, radius/2) radius:(radius/2 - 5) startAngle:0 endAngle:M_PI_2 * 2 clockwise:YES];
        self.shapeLayer = [[CAShapeLayer alloc] init];
        self.shapeLayer.lineWidth = 1.5;
        self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.fillColor = self.loginBtn.backgroundColor.CGColor;
        self.shapeLayer.frame = CGRectMake(0, 0, radius, radius);
        self.shapeLayer.path = path.CGPath;
        [self.LoginAnimView.layer addSublayer:self.shapeLayer];
        
        //让圆转圈，实现"加载中"的效果
        CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        baseAnimation.duration = 0.4;
        baseAnimation.fromValue = @(0);
        baseAnimation.toValue = @(2 * M_PI);
        baseAnimation.repeatCount = MAXFLOAT;
        [self.LoginAnimView.layer addAnimation:baseAnimation forKey:nil];
        
        [self loginSuccess];
        
    }];
    
    
    
}

#pragma mark - 登录成功
- (void)loginSuccess
{
    
    [self clearLoginAnimate];
    SCustomeTabBarController *benchVc = [[SCustomeTabBarController alloc] init];
    [self.navigationController pushViewController:benchVc animated:YES];
    
}

- (void)loginFaild
{
    [self clearLoginAnimate];
}
#pragma mark - 移除登录模板
- (void)clearLoginAnimate
{
    //移除蒙版
    self.loginBtn.hidden = NO;
    [self.HUDView removeFromSuperview];
    [self.LoginAnimView removeFromSuperview];
    [self.LoginAnimView.layer removeAllAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    NSLog(@"内存泄露");
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
