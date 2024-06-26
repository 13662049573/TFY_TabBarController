//
//  TfySY_TabBarItem.m
//  TFY_TabarController
//
//  Created by tiandengyou on 2019/11/25.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "TfySY_TabBarItem.h"

@interface TfySY_TabBarItem ()
@property(nonatomic , strong)UIImageView *backgroundImageView;
@end

@implementation TfySY_TabBarItem

#pragma mark - 构造
- (instancetype)init{
    self = [super init];
    if (self) {
        [self configuration];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self configuration];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configuration];
    }
    return self;
}
- (instancetype)initWithModel:(TfySY_TabBarConfigModel *)itemModel{
    self = [super init];
    if (self) {
        [self configuration];
        [self setItemModel:itemModel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self itemDidLayoutControl]; // 进行组件布局 （因为需要封装，所以没打算在第一时间进行布局）
    [self itemDidLayoutBadgeLabel]; // 进行脚标布局
}
////////
#pragma mark - 配置实例
- (void)configuration{
    self.backgroundImageView = UIImageView.new;
    [self addSubview:self.backgroundImageView];
}

- (void)itemDidLayoutBadgeLabel{
    if (self.badgePoint.x > 0 || self.badgePoint.y > 0) {
        self.badgeLabel.center = self.badgePoint;
    } else {
        switch (self.itemModel.itemBadgeStyle) {
            case TfySY_TabBarItemBadgeStyleTopRight:{ // 右上方 默认
                self.badgeLabel.center = CGPointMake(self.icomImgView.tabbar_width - (self.badgeLabel.tabbar_width/2),self.badgeLabel.tabbar_height/2);
            }break;
            case TfySY_TabBarItemBadgeStyleTopCenter:{ // 上中间
                self.badgeLabel.center = CGPointMake(self.tabbar_width/2,self.badgeLabel.tabbar_height/2);
            }break;
            case TfySY_TabBarItemBadgeStyleTopLeft:{ // 左上方
                self.badgeLabel.center = CGPointMake(self.icomImgView.tabbar_width/2-(self.badgeLabel.tabbar_width/2),self.badgeLabel.tabbar_height/2);
            }break;
            default:
                break;
        }
    }
}

#define iconImgView_Proportion (2.0/3.0)
#define titleLabel_Proportion (1.0/3.0)
- (void)itemDidLayoutControl{
    // 开始内部布局
    self.backgroundImageView.frame = self.bounds;
    CGRect iconImgFrame = self.icomImgView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    BOOL isIcomImgViewSize = self.itemModel.icomImgViewSize.width || self.itemModel.icomImgViewSize.height;
    BOOL isTitleLabelSize = self.itemModel.titleLabelSize.width || self.itemModel.titleLabelSize.height;
    // 除去边距后的最大宽度
    CGFloat marginWidth = self.tabbar_width - self.componentMargin.left - self.componentMargin.right;
    // 进行决策设置大小
    if (isIcomImgViewSize){
        iconImgFrame.size = self.itemModel.icomImgViewSize;
    }else{
        iconImgFrame.size = CGSizeMake(marginWidth, self.tabbar_height * iconImgView_Proportion - self.componentMargin.top - 5);
    }
    if (isTitleLabelSize){
        titleFrame.size = self.itemModel.titleLabelSize;
    }else{
        titleFrame.size = CGSizeMake(marginWidth, self.tabbar_height - iconImgFrame.size.height - self.componentMargin.bottom);
    }
    // 至此大小已计算完毕，开始布局
    self.titleLabel.hidden = NO;
    self.icomImgView.hidden = NO;
    switch (self.itemModel.itemLayoutStyle) {
        case TfySY_TabBarItemLayoutStyleTopPictureBottomTitle:{         // 上图片下文字 使用图3 文1比
            iconImgFrame.origin.y = self.componentMargin.top;
            iconImgFrame.origin.x = (self.tabbar_width - iconImgFrame.size.width)/2;
            // 图上文下 文label的高度要减去间距
            titleFrame.size.height -= self.pictureWordsMargin;
            titleFrame.origin.y = iconImgFrame.origin.y + iconImgFrame.size.height + self.pictureWordsMargin;
            titleFrame.origin.x = (self.tabbar_width - titleFrame.size.width)/2;
        }break;
        case TfySY_TabBarItemLayoutStyleBottomPictureTopTitle:{         // 下图片上文字
            titleFrame.origin.y = self.componentMargin.top;
            titleFrame.origin.x = (self.tabbar_width - iconImgFrame.size.width)/2;
            titleFrame.size.height = self.tabbar_height * iconImgView_Proportion - self.componentMargin.top - self.pictureWordsMargin - 5;
            // 下图片上文字 图的高度要减去间距
            iconImgFrame.origin.y = titleFrame.origin.y + titleFrame.size.height + self.pictureWordsMargin;
            iconImgFrame.origin.x = self.componentMargin.left;
            iconImgFrame.size = CGSizeMake(marginWidth, self.tabbar_height -
                                           titleFrame.size.height - titleFrame.origin.y - self.componentMargin.bottom - self.pictureWordsMargin);
        }break;
        case TfySY_TabBarItemLayoutStyleLeftPictureRightTitle:{         // 左图片右文字
            // 左右布局要重新计算图片宽度和文本高度 比例要按照相反的1：3计算
            iconImgFrame.size.width = self.tabbar_width * titleLabel_Proportion ;
            titleFrame.size.height = self.tabbar_height - self.componentMargin.top - self.componentMargin.bottom;
            titleFrame.size.width = self.tabbar_width - // 图片的右下终点坐标 + 边距 + 组件右边距极限
            (iconImgFrame.size.width + iconImgFrame.origin.x + self.pictureWordsMargin + self.componentMargin.right);
            
            iconImgFrame.origin.y = (self.tabbar_height - iconImgFrame.size.height)/2;
            iconImgFrame.origin.x = self.componentMargin.left;
            // 左图片右文字 文label的宽度要减去间距
            titleFrame.size.width -= self.pictureWordsMargin;
            titleFrame.origin.y = self.componentMargin.top;
            titleFrame.origin.x = iconImgFrame.size.width + iconImgFrame.origin.x + self.pictureWordsMargin;
        }break;
        case TfySY_TabBarItemLayoutStyleRightPictureLeftTitle:{         // 右图片左文字
            // 左右布局要重新计算图片宽度和文本高度 比例要按照相反的1：3计算
            iconImgFrame.size.width = self.tabbar_width * titleLabel_Proportion ;
            titleFrame.size.height = self.tabbar_height - self.componentMargin.top - self.componentMargin.bottom;
            titleFrame.size.width = self.tabbar_width - // 图片的右下终点坐标 + 边距 + 组件右边距极限
            (iconImgFrame.size.width  + self.pictureWordsMargin + self.componentMargin.right);
            
            titleFrame.origin.x = self.componentMargin.left;
            // 左图片右文字 文label的宽度要减去间距
            titleFrame.size.width -= self.pictureWordsMargin;
            titleFrame.origin.y = self.componentMargin.top;
            
            iconImgFrame.origin.y = (self.tabbar_height - iconImgFrame.size.height)/2;
            iconImgFrame.origin.x = titleFrame.size.width + titleFrame.origin.x + self.pictureWordsMargin;
        }break;
        case TfySY_TabBarItemLayoutStylePicture:{                       // 单图片占满全部
            iconImgFrame.size = CGSizeMake(self.tabbar_width - self.componentMargin.left - self.componentMargin.right,
                                           self.tabbar_height - self.componentMargin.top - self.componentMargin.bottom);
            iconImgFrame.origin = CGPointMake(self.componentMargin.right, self.componentMargin.top);
            self.titleLabel.hidden = YES;
        }break;
        case TfySY_TabBarItemLayoutStyleTitle:{                         // 单标题占满全部
            titleFrame.size = CGSizeMake(self.tabbar_width - self.componentMargin.left - self.componentMargin.right,
                                           self.tabbar_height - self.componentMargin.top - self.componentMargin.bottom);
            titleFrame.origin = CGPointMake(self.componentMargin.right, self.componentMargin.top);
            self.icomImgView.hidden = YES;
        }break;
        default:  break;
    }
    self.icomImgView.frame = iconImgFrame;
    self.titleLabel.frame = titleFrame;
}
#pragma mark - 动画函数
- (void)startStrringConfigAnimation{
    WeakSelf;//添加动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    switch (self.itemModel.interactionEffectStyle) {
        case TfySY_TabBarInteractionEffectStyleNone:{ // 无
        }break;
        case TfySY_TabBarInteractionEffectStyleSpring:{ // 放大放小
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
            animation.duration = 0.6;
            animation.calculationMode = kCAAnimationCubic;
            
        }break;
        case TfySY_TabBarInteractionEffectStyleShake:{ // 摇动
            animation.keyPath = @"transform.rotation";
            CGFloat angle = M_PI_4 / 10;
            animation.values = @[@(-angle), @(angle), @(-angle)];
            animation.duration = 0.2f;
        }break;
        case TfySY_TabBarInteractionEffectStyleAlpha:{ // 透明
            animation.keyPath = @"opacity";
            animation.values = @[@1.0,@0.7,@0.5,@0.7,@1.0];
            animation.duration = 0.6;
        }break;
        case TfySY_TabBarInteractionEffectStyleCustom:{ // 自定义动画
            if (weakSelf.itemModel.customInteractionEffectBlock) {
                weakSelf.itemModel.customInteractionEffectBlock(weakSelf);
            }
        }break;
        default: break;
    }
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view.layer addAnimation:animation forKey:nil];
    }];
}

#pragma mark - SET/GET
- (void)setItemModel:(TfySY_TabBarConfigModel *)itemModel{
    _itemModel = itemModel;
//    self.backgroundImageView = itemModel.backgroundImageView; // 先添加背景
    self.title = _itemModel.itemTitle;
    if (itemModel.normalImage != nil && itemModel.selectImage != nil) {
        self.normalImage = itemModel.normalImage;
        self.selectImage = itemModel.selectImage;
    } else {
        self.normalImage = [UIImage imageNamed:itemModel.normalImageName];
        self.selectImage = [UIImage imageNamed:itemModel.selectImageName];
    }
    self.normalColor = itemModel.normalColor;
    self.selectColor = itemModel.selectColor;
    self.normalTintColor = itemModel.normalTintColor;
    self.selectTintColor = itemModel.selectTintColor;
    self.normalBackgroundColor = itemModel.normalBackgroundColor;
    self.selectBackgroundColor = itemModel.selectBackgroundColor;
    if (itemModel.backgroundImage != nil) {
        self.backgroundImage = itemModel.backgroundImage;
    } else {
        if (itemModel.normalBackgroundImage != nil) {
            self.normalBackgroundImage = itemModel.normalBackgroundImage;
        }
        if (itemModel.selectBackgroundImage != nil) {
            self.selectBackgroundImage = itemModel.selectBackgroundImage;
        }
    }
    self.titleLabel = itemModel.titleLabel;
    self.icomImgView = itemModel.icomImgView;
    self.badgePoint = itemModel.badgePoint;
    self.componentMargin = itemModel.componentMargin;
    self.pictureWordsMargin = itemModel.pictureWordsMargin;
    if (itemModel.medianReduction > 0) {
        self.medianReduction = itemModel.medianReduction;
    }
    CGRect itemFrame = self.frame;
    itemFrame.size = itemModel.itemSize;
    self.badgeLabel.automaticHidden = itemModel.automaticHidden;
    self.frame = itemFrame;
    self.badge = itemModel.badge;
}

- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect) { // 是选中
        self.icomImgView.image = self.selectImage;
        self.titleLabel.textColor = self.selectColor;
        if (self.backgroundImage == nil) {
            self.backgroundImageView.image = self.selectBackgroundImage;
        }
        // 如果有设置tintColor，那么就选中图片后将图片渲染成TintColor
        if (self.selectTintColor) {
            self.icomImgView.image = [self.icomImgView.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            [self.icomImgView setTintColor:self.selectTintColor];
            
        }
        [UIView animateWithDuration:0.3 animations:^{
            if (self.selectBackgroundColor) {
                self.backgroundColor = self.selectBackgroundColor;
            }else{
                self.backgroundColor = [UIColor clearColor];
            }
        }];
    }else{
        self.icomImgView.image = self.normalImage;
        self.titleLabel.textColor = self.normalColor;
        if (self.backgroundImage == nil) {
            self.backgroundImageView.image = self.normalBackgroundImage;
        }
        // 如果有设置tintColor，那么未选中将图片渲染成TintColor
        if (self.normalTintColor) {
            self.icomImgView.image = [self.icomImgView.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            [self.icomImgView setTintColor:self.normalTintColor];
        }
        [UIView animateWithDuration:0.3 animations:^{
            if (self.normalBackgroundColor) {
                self.backgroundColor = self.normalBackgroundColor;
            }else{
                self.backgroundColor = [UIColor clearColor];
            }
        }];
    }
    self.titleLabel.text = self.title;
}

- (void)setIcomImgView:(UIImageView *)icomImgView{
    _icomImgView = icomImgView;
    [self addSubview:_icomImgView];
    self.isSelect = self.isSelect;
}

- (void)setTitleLabel:(UILabel *)titleLabel{
    _titleLabel = titleLabel;
    [self addSubview:_titleLabel];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.backgroundImageView.image = backgroundImage;
}

- (void)setBadge:(NSString *)badge{
    _badge = badge;
    if (_badge) {
        self.badgeLabel.badgeText = _badge;
        [self itemDidLayoutBadgeLabel]; // 布局Badge
    }
}

#pragma mark - 懒加载
- (TfySY_TabBarBadge *)badgeLabel{
    if (!_badgeLabel) {
        _badgeLabel = [TfySY_TabBarBadge new];
        [self addSubview:_badgeLabel];
    }
    return _badgeLabel;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = UIImageView.new;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundImageView;
}

@end

@implementation UIView (tabbar)

- (void)setTabbar_origin:(CGPoint)tabbar_origin {
    CGRect frame = self.frame;
    frame.origin = tabbar_origin;
    self.frame = frame;
}

- (CGPoint)tabbar_origin {
    return self.frame.origin;
}

- (void)setTabbar_x:(CGFloat)tabbar_x {
    CGRect frame = self.frame;
    frame.origin.x = tabbar_x;
    self.frame = frame;
}

- (CGFloat)tabbar_x {
    return self.frame.origin.x;
}

- (void)setTabbar_y:(CGFloat)tabbar_y {
    CGRect frame = self.frame;
    frame.origin.y = tabbar_y;
    self.frame = frame;
}

- (CGFloat)tabbar_y {
    return self.frame.origin.y;
}

- (void)setTabbar_size:(CGSize)tabbar_size {
    CGRect frame = self.frame;
    frame.size = tabbar_size;
    self.frame = frame;
}

- (CGSize)tabbar_size {
    return self.frame.size;
}

- (void)setTabbar_width:(CGFloat)tabbar_width {
    CGRect frame = self.frame;
    frame.size.width = tabbar_width;
    self.frame = frame;
}

- (CGFloat)tabbar_width {
    return self.frame.size.width;
}

- (void)setTabbar_height:(CGFloat)tabbar_height {
    CGRect frame = self.frame;
    frame.size.height = tabbar_height;
    self.frame = frame;
}

- (CGFloat)tabbar_height {
    return self.frame.size.height;
}

- (void)setTabbar_centerX:(CGFloat)tabbar_centerX {
    self.center = CGPointMake(tabbar_centerX, self.center.y);
}

- (CGFloat)tabbar_centerX {
    return self.center.x;
}

- (void)setTabbar_centerY:(CGFloat)tabbar_centerY {
    self.center = CGPointMake(self.center.x, tabbar_centerY);
}

- (CGFloat)tabbar_centerY {
    return self.center.y;
}

@end

@implementation TfySY_TabBarConfigModel

- (instancetype)init{
    self = [super init];
    if (self) { // 设置初始默认值
        // 默认标题正常颜色
        self.normalColor = [UIColor grayColor];
        // 默认选中标题颜色
        self.selectColor = TfySY_TabBarItemSlectBlue;
        // 默认凸出 20
        self.bulgeHeight = 20.0;
        self.pictureWordsMargin = 5.0;
        self.componentMargin = UIEdgeInsetsMake(5, 5, 5, 5);
        self.medianReduction = 60;
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)icomImgView{
    if (!_icomImgView) {
        _icomImgView = [UIImageView new];
        _icomImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icomImgView;
}

@end
