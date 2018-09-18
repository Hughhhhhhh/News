//
//  HgMineInfoNameViewController.m
//  News
//
//  Created by CZG on 18/2/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMineInfoNameViewController.h"
#import "HgMineRequest.h"

@interface HgMineInfoNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
- (IBAction)save;

@end

@implementation HgMineInfoNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    self.nameTF.delegate = self;
    
    [self.nameTF addTarget:self
                     action:@selector(textFieldDidChangeValue:)
           forControlEvents:UIControlEventEditingChanged];
    
    self.nameTF.text = (NSString *)[NSObject readObjforKey:@"nickname"];
    
    self.nameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
}

- (void)textFieldDidChangeValue:(UITextField*)textField
{
    self.nameStr = textField.text;
}

- (IBAction)save {
    
    [HgMineRequest userWithNickname:self.nameStr block:^(NSString *msg, id responseData) {
        if ([msg isEqualToString: @"0"]) {
            [NSObject saveObj:self.nameStr withKey:@"nickname"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showHUDMsg:@"修改失败"];
        }
    }];
    
}
@end
