//
//  TfySY_TabBar.m
//  TFY_TabarController
//
//  Created by tiandengyou on 2019/11/25.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "TfySY_TabBar.h"

#define Item_TAG_initial_Value 100

@interface TfySY_TabBar ()
// 对内指针
@property (nonatomic, strong) NSMutableArray <TfySY_TabBarItem *> *items;
@end

@implementation TfySY_TabBar

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
- (instancetype)initWithTabBarConfig:(NSArray<TfySY_TabBarConfigModel *> *)tabBarConfig{
    self = [super init];
    if (self) {
        [self configuration];
        [self setTabBarConfig:tabBarConfig];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self viewDidLayoutItems]; // 进行布局 （因为需要封装，所以没打算在第一时间进行布局）
    [self itemDidLayoutBulge];
    [self layoutTabBarSubViews];
}

#pragma mark - 配置实例
- (void)configuration{
    [self hiddenUITabBarButton]; // 8.4补丁
    [self addSubview:self.backgroundImageView]; // 添加背景图
    [self.backgroundImageView addSubview:self.effectView];
    [self.backgroundImageView addSubview:self.backgroundSelectImageView];
}
#pragma mark - 常规配置
// 设置items
- (void)setTabBarConfig:(NSArray<TfySY_TabBarConfigModel *> *)tabBarConfig{
    _tabBarConfig = tabBarConfig;
    [_tabBarConfig enumerateObjectsUsingBlock:^(TfySY_TabBarConfigModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TfySY_TabBarItem *item = [[TfySY_TabBarItem alloc] initWithModel:obj]; // 模型转成实例
        item.itemIndex = idx; // 交付索引
        item.tintColor = self.tintColor;
        item.tag = Item_TAG_initial_Value + idx; // 区分Tag
        [item addTarget:self action:@selector(click_tabBarItem:) forControlEvents:UIControlEventTouchUpInside];
        if (!idx) {
            item.isSelect = YES;
        }
        [self addSubview:item];
        [self.items addObject:item];
    }];
}
static TfySY_TabBarItem *lastItem;
// 点击的tabbarItem
- (void)click_tabBarItem:(TfySY_TabBarItem *)sender{
    NSInteger clickIndex = sender.tag - Item_TAG_initial_Value;
    [self switch_tabBarItemIndex:clickIndex WithAnimation:YES];
}
// 切换页面/状态
- (void)switch_tabBarItemIndex:(NSInteger )index WithAnimation:(BOOL )animation{
    self.selectIndex = index;
    // 1.切换tabbar的状态
    [self.items enumerateObjectsUsingBlock:^(TfySY_TabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.isSelect = index == idx; // 当前点击的调整选中，其他否定
    }];
    CGFloat screenAverageWidth = self.tabbar_width/self.items.count;
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundSelectImageView.tabbar_x = index * screenAverageWidth;
    }];
    // 动画逻辑
    WeakSelf; // 2.通过回调点击事件让代理去执行切换选项卡的任务
    TfySY_TabBarItem *item = self.items[index];
    if (animation) [item startStrringConfigAnimation]; // 开始执行设置的动画效果
    if (![lastItem isEqual: item]) { // 不是上次点击的
        lastItem = item;
        if (self.delegate && [self.delegate respondsToSelector:@selector(TfySY_TabBar:selectIndex:)]) {
            [self.delegate TfySY_TabBar:weakSelf selectIndex:index];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(TfySY_TabBarDoubleClick:selectIndex:)]) {
            [self.delegate TfySY_TabBarDoubleClick:weakSelf selectIndex:index];
        }
    }
    [self hiddenUITabBarButton];
}
// 文字重叠，隐藏系统的tabbaritem
- (void)hiddenUITabBarButton{
    if ([self.superview isKindOfClass:[UITabBar class]]) {
        UITabBar *tabbar = (UITabBar *)self.superview;
        dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                for (UIView *btn in tabbar.subviews) {
                    if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                        btn.hidden = YES;
                    }
                }
                [self.superview bringSubviewToFront:self]; // 放置到最前
            });
        });
    }
}

// 进行item布局
- (void)viewDidLayoutItems{
    CGFloat screenAverageWidth = self.tabbar_width/self.items.count;
    self.backgroundSelectImageView.frame = CGRectMake(0, 0, screenAverageWidth, self.tabbar_height);
    [self.items enumerateObjectsUsingBlock:^(TfySY_TabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect itemFrame = item.frame;
        CGFloat itemHeight = self.tabbar_height;
        if (TfySY_IsiPhoneX) {
            itemHeight = itemHeight-24;
        }
        BOOL isNoSettingItemSize = !item.itemModel.itemSize.width || !item.itemModel.itemSize.height;
        if (isNoSettingItemSize) { // 没设置则为默认填充模式
            if (item.itemModel.alignmentStyle == TfySY_TabBarConfigAlignmentStyleMedianReduction) {
                itemFrame.origin.x =  item.medianReduction + idx * (screenAverageWidth-item.medianReduction/2);
                itemFrame.size = CGSizeMake((screenAverageWidth-item.medianReduction/2) , itemHeight);
            } else {
                itemFrame.origin.x = idx * screenAverageWidth;
                itemFrame.size = CGSizeMake(screenAverageWidth , itemHeight);
            }
        }else{ // 如果设置了大小
            itemFrame.size = item.itemModel.itemSize;
            // 进行动态布局
            switch (item.itemModel.alignmentStyle) { // item对齐模式
                case TfySY_TabBarConfigAlignmentStyleMedianReduction:{
                    itemFrame.origin.x =  item.medianReduction + idx * (screenAverageWidth-item.medianReduction/2) + ((screenAverageWidth-item.medianReduction/2) - item.itemModel.itemSize.width)/2;
                    itemFrame.origin.y = (itemHeight - item.itemModel.itemSize.height)/2;
                }break;
                case TfySY_TabBarConfigAlignmentStyleCenter:{               // 居中 默认
                    itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - item.itemModel.itemSize.width)/2;
                    itemFrame.origin.y = (itemHeight - item.itemModel.itemSize.height)/2;
                }break;
                case TfySY_TabBarConfigAlignmentStyleCenterTop:{            // 居中顶部对齐
                    itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - item.itemModel.itemSize.width)/2;
                    itemFrame.origin.y = 0;
                }break;
                case TfySY_TabBarConfigAlignmentStyleCenterLeft:{           // 居中靠左对齐
                    itemFrame.origin.x = idx * screenAverageWidth;
                    itemFrame.origin.y = (itemHeight - item.itemModel.itemSize.height)/2;
                }break;
                case TfySY_TabBarConfigAlignmentStyleCenterRight:{          // 居中靠右对齐
                    itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - item.itemModel.itemSize.width);
                    itemFrame.origin.y = (itemHeight - item.itemModel.itemSize.height)/2;
                }break;
                case TfySY_TabBarConfigAlignmentStyleCenterBottom:{         // 居中靠下对齐
                    itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - item.itemModel.itemSize.width)/2;
                    itemFrame.origin.y = itemHeight - item.itemModel.itemSize.height;
                }break;
                case TfySY_TabBarConfigAlignmentStyleTopLeft:{        // 上左对齐
                    itemFrame.origin.x = idx * screenAverageWidth;
                    itemFrame.origin.y = 0;
                }break;
                case TfySY_TabBarConfigAlignmentStyleTopRight:{       // 上右对齐
                    itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - item.itemModel.itemSize.width);
                    itemFrame.origin.y = 0;
                }break;
                case TfySY_TabBarConfigAlignmentStyleBottomLeft:{     // 下左对齐
                    itemFrame.origin.x = idx * screenAverageWidth;
                    itemFrame.origin.y = itemHeight - item.itemModel.itemSize.height;
                }break;
                case TfySY_TabBarConfigAlignmentStyleBottomRight:{    // 下右对齐
                    itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - item.itemModel.itemSize.width);
                    itemFrame.origin.y = itemHeight - item.itemModel.itemSize.height;
                }break;
                default: break;
            }
        }
        item.frame = itemFrame;
        // 通知Item同时开始计算坐标
        [item itemDidLayoutControl];
    }];
}
- (void)setBadge:(NSString *)Badge index:(NSUInteger)index{
    if (index < self.items.count) {
        TfySY_TabBarItem *item = self.items[index];
        item.badge = Badge;
    }else{
        NSException *excp = [NSException exceptionWithName:@"TfySY_TabBar Error"
                                                    reason:@"设置脚标越界！" userInfo:nil];
        [excp raise]; // 抛出异常
    }
}
- (void)layoutTabBarSubViews{
    // 适配背景图
    self.backgroundImageView.frame = self.frame;
    self.effectView.frame = self.frame;
}
// 适配凸出
- (void)itemDidLayoutBulge{
    CGFloat screenAverageWidth = self.tabbar_width/self.items.count;
    self.backgroundSelectImageView.frame = CGRectMake(0, 0, screenAverageWidth, self.tabbar_height);
    [self.items enumerateObjectsUsingBlock:^(TfySY_TabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect itemFrame = item.frame;
        CGFloat sideLength = MAX(itemFrame.size.width, itemFrame.size.height);
        switch (item.itemModel.bulgeStyle) {
            case TfySY_TabBarConfigBulgeStyleNormal:{
            }break;         // 无 默认
            case TfySY_TabBarConfigBulgeStyleCircular:{
                itemFrame.size = CGSizeMake(sideLength, sideLength);
                itemFrame.origin.y = - item.itemModel.bulgeHeight;
                itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - sideLength)/2; // 居中
                item.frame = itemFrame;
                item.layer.masksToBounds = YES;
                if (item.itemModel.bulgeRoundedCorners) {
                    item.layer.cornerRadius = item.itemModel.bulgeRoundedCorners;
                }else{
                    item.layer.cornerRadius = sideLength/2;
                }
            }break;           // 圆形
            case TfySY_TabBarConfigBulgeStyleSquare:{
                itemFrame.origin.y = - item.itemModel.bulgeHeight;
                itemFrame.origin.x = idx * screenAverageWidth + (screenAverageWidth - itemFrame.size.width)/2; // 居中
                item.frame = itemFrame;
                if (item.itemModel.bulgeRoundedCorners) {
                    item.layer.masksToBounds = YES;
                    item.layer.cornerRadius = item.itemModel.bulgeRoundedCorners;
                }
            }break;              // 方形
            default: break;
        }
        item.frame = itemFrame;
    }];
}

#pragma mark - SET/GET
- (NSArray<TfySY_TabBarItem *> *)tabBarItems{
    return self.items;
}
- (TfySY_TabBarItem *)currentSelectItem{
    return [self.tabBarItems objectAtIndex:self.selectIndex];
}

- (void)setSelectIndex:(NSInteger)selectIndex WithAnimation:(BOOL )animation{
    [self switch_tabBarItemIndex:_selectIndex WithAnimation:animation];
}
- (void)setTranslucent:(BOOL)translucent{
    _translucent = translucent;
    self.effectView.hidden = !_translucent;
}

- (void)setThemeImage:(UIImage *)themeImage {
    _themeImage = themeImage;
    self.backgroundImageView.image = themeImage;
}

#pragma mark - 懒加载
- (UIBlurEffect *)effect{
    if (!_effect) {
        _effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    return _effect;
}

- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:self.effect];
        _effectView.frame = self.bounds;
        _effectView.hidden = YES;
    }
    return _effectView;
}

- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}


- (UIImageView *)backgroundSelectImageView {
    if (!_backgroundSelectImageView) {
        _backgroundSelectImageView = UIImageView.new;
    }
    return _backgroundSelectImageView;
}

- (NSMutableArray<TfySY_TabBarItem *> *)items{
    if (!_items) {
        _items = @[].mutableCopy;
    }
    return _items;
}

@end

