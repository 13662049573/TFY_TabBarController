//
//  UIButton+TFY_Chain.m
//  TFY_CHESHI
//
//  Created by 田风有 on 2019/6/5.
//  Copyright © 2019 田风有. All rights reserved.
//

#import "UIButton+TFY_Chain.h"
#import <objc/runtime.h>

#define WSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define RGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface UIButton ()
/**
 *  🐶nn    👇
 */
@property(nonatomic,strong)dispatch_source_t timer;
/**
 *  🐶记录外边的时间    👇
 */
@property(nonatomic,assign)NSInteger userTime;

@end

static NSInteger const TimeInterval = 60; // 默认时间
static NSString * const ButtonTitleFormat = @"剩余%ld秒";
static NSString * const RetainTitle = @"重试";

@implementation UIButton (TFY_Chain)
CALayer *_layer;
UIColor *_startColorOne;
UIColor *_startColorTwo;
NSInteger _lineWidths;
NSInteger _topHeight;
static NSString *keyOfMethod_btn; //关联者的索引key-用于获取block

@dynamic startColorOne;
@dynamic startColorTwo;
@dynamic lineWidths;
@dynamic topHeight;
/**
 *  按钮初始化
 */
UIButton *tfy_button(void){
    return [UIButton new];
}

/**
 *  文本输入
 */
-(UIButton *(^)(NSString *title_str))tfy_text{
    WSelf(myself);
    return ^(NSString *title_str){
        [myself setTitle:title_str forState:UIControlStateNormal];
        return myself;
    };
}
/**
 *  文本颜色
 */
-(UIButton *(^)(NSString *color_str))tfy_textcolor{
    WSelf(myself);
    return ^(NSString *color_str){
        [myself setTitleColor:[myself btncolorWithHexString:color_str alpha:1] forState:UIControlStateNormal];
        return myself;
    };
}
/**
 *  文本大小
 */
-(UIButton *(^)(CGFloat font))tfy_font{
    WSelf(myself);
    return ^(CGFloat font){
        myself.titleLabel.font = [UIFont systemFontOfSize:font];
        return myself;
    };
}

/**
 *  按钮 title_str 文本文字 color_str 文字颜色  font文字大小
 */
-(UIButton *(^)(NSString *title_str,NSString *color_str,CGFloat font))tfy_title{
    WSelf(myself);
    return ^(NSString *title_str,NSString *color_str,CGFloat font){
        [myself setTitle:title_str forState:UIControlStateNormal];
        [myself setTitleColor:[myself btncolorWithHexString:color_str alpha:1] forState:UIControlStateNormal];
        myself.titleLabel.font = [UIFont systemFontOfSize:font];
        return myself;
    };
}
/**
 *  按钮  HexString 背景颜色 alpha 背景透明度
 */
-(UIButton *(^)(NSString *HexString,CGFloat alpha))tfy_backgroundColor{
    WSelf(myself);
    return ^(NSString *HexString,CGFloat alpha){
        [myself setBackgroundColor:[myself btncolorWithHexString:HexString alpha:alpha]];
        return myself;
    };
}
/**
 *  按钮  alignment 0 左 1 中 2 右
 */
-(UIButton *(^)(NSInteger alignment))tfy_alAlignment{
    WSelf(myself);
    return ^(NSInteger alignment){
        switch (alignment) {
            case 0:
                myself.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
                break;
            case 1:
                myself.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
                break;
            case 2:
                myself.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
                break;
        }
        return myself;
    };
}
/**
 *  添加四边框和color 颜色  borderWidth 宽度
 */
-(UIButton *(^)(CGFloat borderWidth, NSString *color))tfy_borders{
    WSelf(myself);
    return ^(CGFloat borderWidth, NSString *color){
        myself.layer.borderWidth = borderWidth;
        myself.layer.borderColor = [myself btncolorWithHexString:color alpha:1].CGColor;
        return myself;
    };
}
/**
 *  添加四边 color_str阴影颜色  shadowRadius阴影半径
 */
-(UIButton *(^)(NSString *color_str, CGFloat shadowRadius))tfy_bordersShadow{
    WSelf(myself);
    return ^(NSString *color_str, CGFloat shadowRadius){
        // 阴影颜色
        myself.layer.shadowColor = [myself btncolorWithHexString:color_str alpha:1].CGColor;
        // 阴影偏移，默认(0, -3)
        myself.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        myself.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        myself.layer.shadowRadius = shadowRadius;
        
        return myself;
    };
}

/**
 *  按钮  cornerRadius 圆角
 */
-(UIButton *(^)(CGFloat cornerRadius))tfy_cornerRadius{
    WSelf(myself);
    return ^(CGFloat cornerRadius){
        myself.layer.cornerRadius = cornerRadius;
        return myself;
    };
}
/**
 *  按钮  image_str 图片字符串
 */
-(UIButton *(^)(NSString *image_str,UIControlState state))tfy_image{
    WSelf(myself);
    return ^(NSString *image_str,UIControlState state){
        [myself setImage:[[UIImage imageNamed:image_str] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:state];
        return myself;
    };
}
/**
 *  按钮  backimage_str 背景图片
 */
-(UIButton *(^)( NSString *backimage_str,UIControlState state))tfy_backgroundImage{
    WSelf(myself);
    return ^( NSString *backimage_str,UIControlState state){
        [myself setBackgroundImage:[[UIImage imageNamed:backimage_str] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:state];
        return myself;
    };
}
/**
 *  按钮 点击方法
 */
-(UIButton *(^)(id object, SEL action))tfy_action{
    WSelf(myself);
    return ^(id object, SEL action){
        [myself addTarget:object action:action forControlEvents:UIControlEventTouchUpInside];
        return myself;
    };
}

- (UIButton *(^)(BOOL adjustsWidth))tfy_adjustsWidth{
    WSelf(weakSelf);
    return ^(BOOL adjustsWidth){
        weakSelf.titleLabel.adjustsFontSizeToFitWidth = adjustsWidth;
        return weakSelf;
    };
}

- (UIButton *(^)(NSAttributedString *attributrdString))tfy_attributrdString{
    WSelf(weakSelf);
    return ^(NSAttributedString *attributrdString){
        [weakSelf setAttributedTitle:attributrdString forState:UIControlStateNormal];
        return weakSelf;
    };
}
/**
 *  button的大小要大于 图片大小+文字大小+spacing   spacing 图片和文字的间隔
 */
-(void)tfy_layouEdgeInsetsPosition:(ButtonPosition)postion spacing:(CGFloat)spacing{
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (postion) {
        case ButtonPositionImageTop_titleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-spacing/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-spacing/2.0, 0);
        }
            break;
        case ButtonPositionImageLeft_titleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2.0, 0, spacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, spacing/2.0, 0, -spacing/2.0);
        }
            break;
        case ButtonPositionImageBottom_titleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-spacing/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-spacing/2.0, -imageWith, 0, 0);
        }
            break;
        case ButtonPositionImageRight_titleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+spacing/2.0, 0, -labelWidth-spacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-spacing/2.0, 0, imageWith+spacing/2.0);
        }
            break;
        default:
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



-(UIColor *)btncolorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r                       截取的range = (0,2)
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;//     截取的range = (2,2)
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;//     截取的range = (4,2)
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;//将字符串十六进制两位数字转为十进制整数
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

- (void)setTime:(NSInteger)time{
    objc_setAssociatedObject(self, @selector(time), @(time), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)time{
    
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setFormat:(NSString *)format{
    
    objc_setAssociatedObject(self, @selector(format), format, OBJC_ASSOCIATION_COPY);
}

- (NSString *)format{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setUserTime:(NSInteger)userTime{
    
    objc_setAssociatedObject(self, @selector(userTime), @(userTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)userTime{
    
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTimer:(dispatch_source_t)timer{
    
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN);
}

- (dispatch_source_t)timer{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCompleteBlock:(void (^)(void))CompleteBlock{
    objc_setAssociatedObject(self, @selector(CompleteBlock), CompleteBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(void))CompleteBlock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)startTimer
{
    if (!self.time) {
        self.time = TimeInterval;
    }
    if (!self.format) {
        self.format = ButtonTitleFormat;
    }
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.time <= 1) {
            dispatch_source_cancel(self.timer);
        }else
        {
            self.time --;
            dispatch_async(mainQueue, ^{
                self.enabled = NO;
                [self setTitle:[NSString stringWithFormat:self.format,self.time] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_source_set_cancel_handler(self.timer, ^{
        dispatch_async(mainQueue, ^{
            self.enabled = YES;
            [self setTitle:RetainTitle forState:UIControlStateNormal];
            if (self.CompleteBlock) {
                self.CompleteBlock();
            }
            if (self.userTime) {
                self.time = self.userTime;
            }else
            {
                self.time = TimeInterval;
            }
        });
    });
    dispatch_resume(self.timer);
}

- (void)endTimer{
    
    dispatch_source_cancel(self.timer);
}

/**
 *  动画启动
 */
- (void)show{
    if (!self.hidden) return;
    
    self.hidden = NO;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:2.0];
    scaleAnimation.toValue   = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration  = .3;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue  = [NSNumber numberWithFloat:.5];
    opacityAnimation.toValue    = [NSNumber numberWithFloat:1];
    opacityAnimation.duration   = .3;
    
    [self.layer addAnimation:scaleAnimation forKey:@"scale"];
    [self.layer addAnimation:opacityAnimation forKey:@"opacity"];
}
/**
 *  动画结束
 */
- (void)hide {
    self.hidden = YES;
}

/**
 *  绑定button
 **/
-(void)BindingBtnactionBlock:(ActionBlock)actionBlock{
    [self addTarget:nil action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject (self , &keyOfMethod_btn, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)buttonClick{
    //判断动画-如果正在加载就不能点击
    if (_layer.animationKeys.count>0) {
        return;
    }
    //旋转
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    [self creatLayerWithStartLoadingButton];
    
    
}

/**
 *  加载完毕停止旋转
 *  title:停止后button的文字
 *  textColor :字体色 如果颜色不变就为nil
 *  backgroundColor :背景色 如果颜色不变就为nil
 **/

-(void)stopLoading:(NSString*)title textColor:(UIColor*)textColor backgroundColor:(UIColor*)backColor{
    
    if (textColor) {
        [self setTitleColor:textColor forState:UIControlStateNormal];
    }
    
    if (backColor) {
        self.backgroundColor = backColor;
    }
    
    [self setTitle:title forState:UIControlStateNormal];
    [_layer removeAllAnimations];//停止动画
    [_layer removeFromSuperlayer];//移除动画

    
}


-(void)setStartColorOne:(UIColor *)startColorOne{
    
    _startColorOne = startColorOne;
}
-(void)setStartColorTwo:(UIColor *)startColorTwo{
    
    _startColorTwo = startColorTwo;
}

-(void)setLineWidths:(NSInteger)lineWidths{
    _lineWidths = lineWidths;
}
-(void)setTopHeight:(NSInteger)topHeight{
    
    _topHeight = topHeight;
}

-(void)creatLayerWithStartLoadingButton{
    UIColor *backgroundColor = self.backgroundColor;//获取背景色
    UIColor *textColor = self.currentTitleColor;//获取字体色
    if (_startColorOne) {
        backgroundColor = _startColorOne;
    }
    if (_startColorTwo) {
        textColor = _startColorTwo;
    }
    NSInteger lineW =  5;//圆圈的宽度默认5
    if (_lineWidths>0) {
        lineW = _lineWidths;
    }
    NSInteger topWid = 5;
    if (_topHeight) {
        topWid = _topHeight;
    }
    
    CGRect rect = self.frame;
    float wid = rect.size.height-topWid*2;
    float x = rect.size.width/2-wid/2;
    
    _layer = [CALayer layer];
    _layer.frame = CGRectMake(x, topWid, wid, wid);
    _layer.backgroundColor = backgroundColor.CGColor;
    
    [self.layer addSublayer:_layer];
    //创建圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(wid/2, wid/2) radius:(wid-lineW*2)/2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = textColor.CGColor;
    shapeLayer.lineWidth = lineW;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    [_layer setMask:shapeLayer];
    
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)backgroundColor.CGColor,(id)[RGBA(255, 255, 255, 0.5) CGColor], nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, wid, wid/2);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)[RGBA(255, 255, 255, 0.5) CGColor],(id)[textColor CGColor], nil];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.shadowPath = bezierPath.CGPath;
    gradientLayer1.frame = CGRectMake(0, wid/2, wid, wid/2);
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
    [_layer addSublayer:gradientLayer]; //设置颜色渐变
    [_layer addSublayer:gradientLayer1];
    

    [self animation];
    [self loadActionBlock];
    
}

- (void)animation {
    //动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 0.8;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_layer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
}

-(void)loadActionBlock{
    //获取关联
    ActionBlock block1 = (ActionBlock)objc_getAssociatedObject(self, &keyOfMethod_btn);
    if(block1){
        block1(self);
    }
}

@end
