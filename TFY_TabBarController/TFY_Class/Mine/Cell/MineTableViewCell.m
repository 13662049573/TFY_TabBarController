//
//  MineTableViewCell.m
//  TFY_TabarController
//
//  Created by 田风有 on 2019/6/12.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()
@property(nonatomic , strong)UIView *back_View;
@property (strong, nonatomic)UIImageView *iconImageV;
@property (strong, nonatomic)UILabel *nameLabel;
@property (strong, nonatomic)UILabel *phoneNumLabel;
@end

@implementation MineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.back_View];
        self.back_View.tfy_LeftSpace(20).tfy_TopSpace(10).tfy_RightSpace(20).tfy_BottomSpace(10);
        
        [self.back_View addSubview:self.iconImageV];
        self.iconImageV.tfy_LeftSpace(20).tfy_CenterY(0).tfy_size(50, 50);
        
        [self.back_View addSubview:self.nameLabel];
        self.nameLabel.tfy_LeftSpaceToView(10, self.iconImageV).tfy_TopSpace(0).tfy_RightSpace(20).tfy_Height(30);
        
        [self.back_View addSubview:self.phoneNumLabel];
        self.phoneNumLabel.tfy_LeftSpaceToView(10, self.iconImageV).tfy_TopSpaceToView(0, self.nameLabel).tfy_RightSpace(20).tfy_BottomSpace(0);
    }
    return self;
}
-(void)setModel:(TFY_PersonModel *)model{
    _model = model;
    
    self.iconImageV.image = _model.image ? model.image : [[UIImage imageNamed:@"my_head_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.nameLabel.tfy_text(_model.fullName);
    
    TFY_Phone *phone = _model.phones.firstObject;
    
    self.phoneNumLabel.tfy_text(phone.phone);
}

-(UIView *)back_View{
    if (!_back_View) {
        _back_View = [UIView new];
        _back_View.backgroundColor = [UIColor cyanColor];
        _back_View.layer.shadowOffset = CGSizeMake(0, 0);
        _back_View.layer.shadowRadius = 5;
        _back_View.layer.shadowOpacity = 0.3;
        _back_View.layer.shadowColor = [UIColor blackColor].CGColor;
        _back_View.layer.cornerRadius = 15;
    }
    return _back_View;
}

-(UIImageView *)iconImageV{
    if (!_iconImageV) {
        _iconImageV = tfy_imageView();
        _iconImageV.tfy_cornerRadius(25);
    }
    return _iconImageV;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = tfy_label();
        _nameLabel.tfy_textcolor(@"212121", 1).tfy_alignment(0).tfy_fontSize([UIFont systemFontOfSize:15]);
    }
    return _nameLabel;
}

-(UILabel *)phoneNumLabel{
    if (!_phoneNumLabel) {
        _phoneNumLabel = tfy_label();
        _phoneNumLabel.tfy_textcolor(@"212121", 1).tfy_fontSize([UIFont systemFontOfSize:15]).tfy_alignment(0);
    }
    return _phoneNumLabel;
}
@end
