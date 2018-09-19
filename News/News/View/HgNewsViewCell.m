//
//  HgNewsViewCell.m
//  News
//
//  Created by CZG on 18/2/9.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNewsViewCell.h"
#import "HgNews.h"

@interface HgNewsViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *click;
- (IBAction)clickEvent:(UIButton *)sender;

@end

@implementation HgNewsViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"newsViewCell";
    HgNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HgNewsViewCell" owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

-(void)setNews:(HgNews *)news{
    _news = news;
    
    [self settingData];
}

-(void) settingData{
    HgNews *model = self.news;
    
    NSString *img = model.imgsrc;
    NSURL *url = [NSURL URLWithString:img];
    [self.image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    self.title.text = model.ltitle;
    self.desc.text = model.digest;
    
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.2;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 3);
    
    self.name.text = (NSString *)[NSObject readObjforKey:@"nickname"];
    NSString *headImg = (NSString *)[NSObject readObjforKey:@"avatar"];
    NSURL *url2 = [NSURL URLWithString:headImg];
    [self.iconimage sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    self.iconimage.layer.masksToBounds = YES;
    self.iconimage.layer.cornerRadius = self.iconimage.bounds.size.width * 0.5;
    
}

- (IBAction)clickEvent:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickName)]) {
        [self.delegate clickName];
    }
}
@end
