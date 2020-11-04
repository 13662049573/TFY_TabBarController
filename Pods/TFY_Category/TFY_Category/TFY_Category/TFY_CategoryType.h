//
//  TFY_CategoryType.h
//  TFY_Category
//
//  Created by 田风有 on 2020/8/17.
//  Copyright © 2020 恋机科技. All rights reserved.
//

#ifndef TFY_CategoryType_h
#define TFY_CategoryType_h

#pragma mark -------------------------------------------属性快速声明-------------------------------------------

#define TFY_PROPERTY_CHAIN                    @property (nonatomic , copy)
#define TFY_PROPERTY_STRONG                   @property (nonatomic , strong)
#define TFY_PROPERTY_ASSIGN                   @property (nonatomic , assign)
#define TFY_PROPERTY_WEAK                     @property (nonatomic , weak)
#define TFY_PROPERTY_CHAIN_BLOCK(name,...)    @property (nonatomic , copy, nullable) void (^name)(__VA_ARGS__)

#define TFY_PROPERTY_BOOL(name)                TFY_PROPERTY_ASSIGN BOOL                  name
#define TFY_PROPERTY_NSString(name)            TFY_PROPERTY_CHAIN  NSString            * name
#define TFY_PROPERTY_NSUInteger(name)          TFY_PROPERTY_ASSIGN NSUInteger            name
#define TFY_PROPERTY_NSInteger(name)           TFY_PROPERTY_ASSIGN NSInteger             name
#define TFY_PROPERTY_Float(name)               TFY_PROPERTY_ASSIGN float                 name
#define TFY_PROPERTY_LongLong(name)            TFY_PROPERTY_ASSIGN long long             name
#define TFY_PROPERTY_NSDictionary(name)        TFY_PROPERTY_STRONG NSDictionary        * name
#define TFY_PROPERTY_NSArray(name)             TFY_PROPERTY_CHAIN  NSArray * name
#define TFY_PROPERTY_NSMutableArray(name)      TFY_PROPERTY_STRONG NSMutableArray      * name
#define TFY_PROPERTY_NSData(name)              TFY_PROPERTY_STRONG NSData * name
#define TFY_PROPERTY_NSMutableDictionary(name) TFY_PROPERTY_STRONG NSMutableDictionary * name

/**快捷创建对象属性 如 (Label) (name)*/
#define TFY_PROPERTY_OBJECT_STRONG(object,name)  TFY_PROPERTY_STRONG object  * name
#define TFY_PROPERTY_OBJECT_CHAIN(object,name)   TFY_PROPERTY_CHAIN  object  * name
#define TFY_PROPERTY_OBJECT_ASSIGN(object,name)  TFY_PROPERTY_ASSIGN object    name
#define TFY_PROPERTY_OBJECT_WEAK(object,name)    TFY_PROPERTY_WEAK   object    name

/**点语法*/
#pragma mark-------------------------------------------点语法---------------------------------------------

#define TFY_WSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//.h文件需求
#define TFY_StatementAndPropSetFuncStatement(className,propertyModifier,propertyPointerType,propertyName) \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;\
- (className * (^) (propertyPointerType propertyName))propertyName##Set;
//.m文件需求
#define TFY_SetFuncImplementation(className,propertyPointerType, propertyName)  \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{ \
    TFY_WSelf(myself);\
    return ^(propertyPointerType propertyName){\
        myself.propertyName = propertyName;\
        return myself;\
    };\
}

#pragma mark-------------------------------------------线程---------------------------------------------
/***线程****/
#define TFY_queueGlobalStart dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
// 当所有队列执行完成之后
#define TFY_group_notify dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

#define TFY_queueMainStart dispatch_async(dispatch_get_main_queue(), ^{

#define TFY_QueueStartAfterTime(time) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){

#define TFY_queueEnd  });


// 创建队列组，可以使多个网络请求异步执行，执行完之后再进行操作
//这段放在for循环外
#define TFY_dispatch_group dispatch_group_t group = dispatch_group_create(); \
                          dispatch_queue_t queue = dispatch_get_global_queue(0, 0); \
                          dispatch_group_async(group, queue, ^{

//这段放在for循环中
#define TFY_Forwait   dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

//这段放在for循环任务执行中也是网络请求结果中使用
#define TFY_semaphore dispatch_semaphore_signal(semaphore);

//信号量减1，如果>0，则向下执行，否则等待
#define TFY_semaphore_wait  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

//这段放在for循环结束
#define TFY_semaphoreEnd  });


#ifdef DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr, "\n\n******(class)%s(begin)******\n(SEL)%s\n(line)%d\n(data)%s\n******(class)%s(end)******\n\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String], [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String])

#else

#define NSLog(FORMAT, ...) nil

#endif


#pragma mark-------------------------------------------内联函数---------------------------------------------
/** 发送通知 */
CG_INLINE void TFY_PostNotification(NSNotificationName name,id obj,NSDictionary *info) {
    return [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:info];
}
/** 监听通知 */
CG_INLINE void TFY_ObserveNotification(id observer,SEL aSelector,NSNotificationName aName,id obj) {
    return [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:obj];
}
/** 移除所有通知 */
CG_INLINE void TFY_RemoveNotification(id<WKHTTPCookieStoreObserver> observer) API_AVAILABLE(ios(11.0)) {
    return [[NSNotificationCenter defaultCenter] removeObserver:observer];
}
/** 移除一个已知通知 */
CG_INLINE void TFY_RemoveOneNotification(id observer,NSNotificationName aName,id obj) {
    return [[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:obj];
}


#pragma mark-------------------------------------------单例---------------------------------------------

#define  TFY_adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
     NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
     NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
     NSInteger argument = 2;\
     invocation.target = scrollView;\
     invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
     [invocation setArgument:&argument atIndex:2];\
     [invocation invoke];\
} else {\
    vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


/** 单例（声明）.h */
#define TFY_SingtonInterface + (instancetype)sharedInstance;

/** 单例（实现）.m */
#define TFY_SingtonImplement(class) \
\
static class *sharedInstance_; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance_ = [super allocWithZone:zone]; \
    }); \
    return sharedInstance_; \
} \
\
+ (instancetype)sharedInstance { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance_ = [[class alloc] init]; \
    }); \
    return sharedInstance_; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
    return sharedInstance_; \
}

/** weakSelf */
#ifndef tfy_weakify
   #if DEBUG
       #if __has_feature(objc_arc)
           #define tfy_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
       #else
           #define tfy_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
      #endif
   #else
#if __has_feature(objc_arc)
          #define tfy_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
      #else
          #define tfy_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
      #endif
   #endif
#endif

/** strongSelf */
#ifndef tfy_strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define tfy_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define tfy_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
#if __has_feature(objc_arc)
           #define tfy_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
           #define tfy_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* TFY_CategoryType_h */

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
