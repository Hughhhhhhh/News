//
//  HgMusicCell.m
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicCell.h"
#import "HgMusicInfoModel.h"

@interface HgMusicCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIImageView *playView;

@end

@implementation HgMusicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.2;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 3);
    
    self.imgView.layer.cornerRadius = 22.5;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
}

+(instancetype) initMusicViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MusicCell";
    
    HgMusicCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HgMusicCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)setModel:(HgMusicInfoModel *)model{
    _model = model;
    self.title.text = model.title;
    self.author.text = model.author;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic_big] placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    if (model.isPlay == YES) {
        self.playView.hidden = NO;
    }else{
        self.playView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
