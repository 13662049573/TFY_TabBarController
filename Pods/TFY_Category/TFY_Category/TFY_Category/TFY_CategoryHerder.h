//
//  TFY_CategoryHerder.h
//  TFY_AutoLayoutModelTools
//
//  Created by 田风有 on 2019/4/30.
//  Copyright © 2019 恋机科技. All rights reserved.
//  最新版本号:3.3.4

#ifndef TFY_CategoryHerder_h
#define TFY_CategoryHerder_h

//UI头文件
#import "TFY_UIHeader.h"
//Foundation头文件
#import "TFY_FoundationHeader.h"
//ITools头文件
#import "TFY_IToolsHeader.h"

#pragma -------------------------------------------常用的宏---------------------------------------------
/**
 * copy
 */
#define TFY_CATEGORY_CHAIN_PROPERTY  @property(nonatomic , copy)
/**
 * BLOCK
 */
#define TFY_CATEGORY_CHAIN_BLOCK_PROPERTY  @property (nonatomic, copy, nullable)
/**
 * strong
 */
#define TFY_CATEGORY_STRONG_PROPERTY @property(nonatomic , strong)
/**
 * assign
 */
#define TFY_CATEGORY_ASSIGN_PROPERTY @property(nonatomic , assign)
/**
 * weak
 */
#define TFY_CATEGORY_WEAK_PROPERTY @property(nonatomic , weak)

/**点语法*/

#define WSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//.h文件需求
#define TFY_StatementAndPropSetFuncStatement(className,propertyModifier,propertyPointerType,propertyName) \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;\
- (className * (^) (propertyPointerType propertyName))propertyName##Set;
//.m文件需求
#define TFY_SetFuncImplementation(className,propertyPointerType, propertyName)  \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{ \
    WSelf(myself);\
    return ^(propertyPointerType propertyName){\
        myself.propertyName = propertyName;\
        return myself;\
    };\
}

/***线程****/
#define LM_queueGlobalStart dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
// 当所有队列执行完成之后
#define LM_group_notify dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

#define LM_queueMainStart dispatch_async(dispatch_get_main_queue(), ^{

#define LM_QueueStartAfterTime(time) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){

#define LM_queueEnd  });


// 创建队列组，可以使多个网络请求异步执行，执行完之后再进行操作
//这段放在for循环外
#define LM_dispatch_group dispatch_group_t group = dispatch_group_create(); \
                          dispatch_queue_t queue = dispatch_get_global_queue(0, 0); \
                          dispatch_group_async(group, queue, ^{

//这段放在for循环中
#define LM_Forwait   dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

//这段放在for循环任务执行中也是网络请求结果中使用
#define LM_semaphore dispatch_semaphore_signal(semaphore);

//信号量减1，如果>0，则向下执行，否则等待
#define LM_semaphore_wait  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

//这段放在for循环结束
#define LM_semaphoreEnd  });


#ifdef DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr, "\n\n******(class)%s(begin)******\n(SEL)%s\n(line)%d\n(data)%s\n******(class)%s(end)******\n\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String], [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String])

#else

#define NSLog(FORMAT, ...) nil

#endif

//屏幕高
#define  Height_H [UIScreen mainScreen].bounds.size.height
//屏幕宽
#define  Width_W  [UIScreen mainScreen].bounds.size.width
/**
 * 是否是竖屏
 */
#define isPortrait  ( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait ||  [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown ) ?YES:NO
//对应屏幕比例宽
#define DEBI_width(width)    width *(isPortrait ?(375/Width_W):(Height_H/375))

#define DEBI_height(height)  height *(isPortrait ?(667/Height_H):(Width_W/667))

// iPhoneX  iPhoneXS  iPhoneXS Max  iPhoneXR 机型判断
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)

#define kNavBarHeight           (iPhoneX ? 88.0 : 64.0)
#define kBottomBarHeight        (iPhoneX ? 83.0 : 49.0)
#define kNavTimebarHeight       (iPhoneX ? 44.0 : 20.0)
#define kContentHeight          (Height_H - kNavBarHeight-kBottomBarHeight)


#endif /* TFY_CategoryHerder_h */


/**
rand() ----随机数
abs() / labs() ----整数绝对值
fabs() / fabsf() / fabsl() ----浮点数绝对值
floor() / floorf() / floorl() ----向下取整
ceil() / ceilf() / ceill() ----向上取整
round() / roundf() / roundl() ----四舍五入
sqrt() / sqrtf() / sqrtl() ----求平方根
fmax() / fmaxf() / fmaxl() ----求最大值
fmin() / fminf() / fminl() ----求最小值
hypot() / hypotf() / hypotl() ----求直角三角形斜边的长度
fmod() / fmodf() / fmodl() ----求两数整除后的余数
modf() / modff() / modfl() ----浮点数分解为整数和小数
frexp() / frexpf() / frexpl() ----浮点数分解尾数和二为底的指数
sin() / sinf() / sinl() ----求正弦值
sinh() / sinhf() / sinhl() ----求双曲正弦值
cos() / cosf() / cosl() ----求余弦值
cosh() / coshf() / coshl() ----求双曲余弦值
tan() / tanf() / tanl() ----求正切值
tanh() / tanhf() / tanhl() ----求双曲正切值
asin() / asinf() / asinl() ----求反正弦值
asinh() / asinhf() / asinhl() ----求反双曲正弦值
acos() / acosf() / acosl() ----求反余弦值
acosh() / acoshf() / acoshl() ----求反双曲余弦值
atan() / atanf() / atanl() ----求反正切值
atan2() / atan2f() / atan2l() ----求坐标值的反正切值
atanh() / atanhf() / atanhl() ----求反双曲正切值
注:要消除链式编程的警告

要在Buildding Settings 把CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF 设为NO
*/
