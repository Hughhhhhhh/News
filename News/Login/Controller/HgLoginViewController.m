//
//  HgLoginViewController.m
//  网易新闻
//
//  Created by CZG on 18/1/30.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgLoginViewController.h"
#import "HgTabBarController.h"
#import "NSObject+Hg.h"
#import<CommonCrypto/CommonDigest.h>
#import "HgLoginRequest.h"

@interface HgLoginViewController ()
{
    HgTabBarController * tabBarVc;
}
@property (weak, nonatomic) IBOutlet UITextField *loginTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (nonatomic, strong) NSString *loginStr;
@property (nonatomic, strong) NSString *pswStr;
- (IBAction)login;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation HgLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    [self.loginBtn setEnabled:NO];
    
    self.loginTF.delegate = self;
    self.pswTF.delegate = self;
    self.loginTF.tag = 1;
    self.pswTF.tag = 2;
    [self.loginTF addTarget:self
                     action:@selector(textFieldDidChangeValue:)
           forControlEvents:UIControlEventEditingChanged];
    [self.pswTF addTarget:self
                   action:@selector(textFieldDidChangeValue:)
         forControlEvents:UIControlEventEditingChanged];
    self.loginTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.pswTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    
}

- (void)textFieldDidChangeValue:(UITextField*)textField
{
    if (textField.tag == 1 ) {
        self.loginStr = textField.text;
    }
    if(textField.tag == 2 )
    {
        self.pswStr = textField.text;
    }
    if (self.loginStr.length > 0 && self.pswStr.length > 0) {
        [self.loginBtn setEnabled:YES];
    }
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)login {
    [self loginMain];
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


- (void) loginMain{
    NSString * psw = [self md5:self.pswStr];
    
    [HgLoginRequest userLoginWithUsername:self.loginStr withPassword:psw block:^(NSString *msg, id responseData) {
        NSLog(@"%@",responseData);
        if([msg isEqualToString:@"0"])
        {
            [MBProgressHUD showHUDMsg:@"登录成功~"];
            
            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
            [NSObject saveObj:@"1" withKey:@"isLogin"];
            [NSObject saveObj:responseData[@"avatar"] withKey:@"avatar"];
            [NSObject saveObj:responseData[@"id"] withKey:@"id"];
            [NSObject saveObj:responseData[@"nickname"] withKey:@"nickname"];
            [NSObject saveObj:responseData[@"sex"] withKey:@"sex"];
            [NSObject saveObj:responseData[@"username"] withKey:@"username"];
            [NSObject saveObj:responseData[@"whatisup"] withKey:@"whatisup"];
            
            tabBarVc = [[HgTabBarController alloc]init];
            tabBarVc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [tabBarVc addParentController:self];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"enterMainView" object:self];
            
            NSLog(@"请求成功！");
        }else{
            
            [MBProgressHUD showHUDMsg:@"账号密码错误"];
            
            NSLog(@"请求失败");
        }
    }];       
//            NSHTTPURLResponse* response = (NSHTTPURLResponse* )task.response;
//            
//            NSString* dataCookie = [NSString stringWithFormat:@"%@",[[response.allHeaderFields[@"Set-Cookie"]componentsSeparatedByString:@";"]objectAtIndex:0]];
//            
//            [[NSUserDefaults standardUserDefaults]setObject:dataCookie forKey:@"cookie"];
//            
//            NSLog(@">>>>>>>>>获取到的cookie = %@ <<<<<<<<<<< and >>>>>>>需要的PHPSESSIONID = %@ <<<<<<<<",response.allHeaderFields[@"Set-Cookie"],dataCookie);

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
