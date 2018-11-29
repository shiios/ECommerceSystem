//
//  Constant.h
//  OASystem
//
//  Created by Sandwind on 2018/5/30.
//  Copyright © 2018年 Sandwind. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//测试
//oatestapi.chinatelling.com(172.20.200.61:8088)   域名测试地址
//#define LINK_HOST @"http://172.20.200.61:8066/api/"
#define LINK_HOST @"https://oatestapi.chinatelling.com/api/"
////测试文件服务器oatestfileapi.chinatelling.com(172.20.200.64:8089)
#define FILE_HOST @"http://oatestfileapi.chinatelling.com/"
//是否进行密码校验
#define PWD_CHECKFLAG 0

//数据平台
#define DATA_HOST @"http://typortaldev.chinatelling.com:8080/tycenter/front/mobile/page/home/index.jsp?userAD="

//文件上传
#define UPLOADFILE_HOST @"http://oatestapi.chinatelling.com/Common/UploadFiles.ashx"


//正式
//oatestapi.chinatelling.com(172.20.200.61:8088)   域名正式地址
//#define LINK_HOST @"https://oaapi.chinatelling.com/api/"
////正式文件服务器oatestfileapi.chinatelling.com(172.20.200.64:8089)
//#define FILE_HOST @"http://oafileapi.chinatelling.com/"
////是否进行密码校验
//#define PWD_CHECKFLAG 1
//
////数据平台
//#define DATA_HOST @"http://typortal.chinatelling.com:8080/tydcenter/front/mobile/page/home/index.jsp?userAD="
//
////文件上传
//#define UPLOADFILE_HOST @"http://oaapi.chinatelling.com/Common/UploadFiles.ashx"




//IT资讯测试
//#define ZIXUNIMAGE_HOST @"http://retailapptest.chinatelling.com/" //图片域名
//#define ZIXUNIMAGE_HOST @"http://172.20.200.71:8080/" //图片域名

//IT资讯正式
#define ZIXUNIMAGE_HOST @"http://retailappimg.chinatelling.com/" //图片正式
//#define ZIXUNIMAGE_HOST @"http://172.20.100.71:8080/" //图片正式

#define JPUSH_AppKey @"cf1c361639e322606a97b06c"
#define BUGLY_AppID @"6be858bbb5"
#define JSPATCH_Appkey @"5946c369a4b6a3fd"
#define JSPATCH_PublicKey @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXBv3yEUlYsZ71hIEVO17O+aCv\neoXpp0AkhYhJVOAtg1JY3MoFxWnXot9ZN42zgsXTAWMwbRXjadVVQLwPi6VTjAtF\nsjfSe+VIlLjjTXJfpHVGzr//rw9fPiccVGfkqBb8lgX0TSqLnT407yKiga8ARTM+\nYrw+jbPZFRkte5WqZQIDAQAB\n-----END PUBLIC KEY-----"



#define RESPONSE_MSG [dic objectForKey:@"Msg"]
#define RESPONSE_CODE [[dic objectForKey:@"IsSuccess"] isEqualToString:@"true"]
#define RESPONSE_number_CODE [[dic objectForKey:@"IsSuccess"] intValue] == 1

#pragma mark - SCREEN_SIZE
#define KW_SCREEN ([UIScreen mainScreen].bounds.size.width)
#define KH_SCREEN ([UIScreen mainScreen].bounds.size.height)

#pragma mark - SCREEN_SCALE
#define KW(widthValue) (KW_SCREEN/375) * widthValue
#define KH(heightValue) (KH_SCREEN/667) * heightValue

/**
 16进制颜色转换
 */
#define UIColorWithHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

/**
 RGB颜色
 */
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#pragma mark - 打印
#ifdef __OBJC__
#if DEBUG
#define SGHLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define SGHLog(FORMAT, ...) nil
#endif



#pragma mark - 提示框
#define mCustomAlertView(title, msg) \
if((msg).length)\
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:nil \
cancelButtonTitle:@"我知道了!" otherButtonTitles:nil]; \
[alert show];\
}\
else\
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求出错" delegate:nil \
cancelButtonTitle:@"我知道了！" otherButtonTitles:nil]; \
[alert show];\
}

#endif
#endif /* Constant_h */
