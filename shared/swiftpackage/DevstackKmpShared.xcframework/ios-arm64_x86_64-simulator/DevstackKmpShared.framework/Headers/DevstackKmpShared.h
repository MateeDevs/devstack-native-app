#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSError.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>

@class DKSDatabaseCompanion, DKSKotlinThrowable, DKSFlowWrapperParent<Params, T>, DKSSuspendWrapperParent<Params, Out>, DKSBook, DKSUser, DKSUserPagingData, DKSUserPagingResult, DKSUserPagingParameters, DKSUserUpdateParameters, DKSResult<__covariant T>, DKSKotlinx_coroutines_coreCoroutineDispatcher, DKSUseCaseImpl<__contravariant Params, __covariant T>, DKSKotlinUnit, DKSUseCaseResultNoParamsImpl<__covariant T>, DKSLoginUseCaseParams, DKSUseCaseResultImpl<__contravariant Params, __covariant T>, DKSRegisterUseCaseParams, DKSUseCaseFlowImpl<__contravariant Params, __covariant T>, DKSUseCaseFlowResultNoParamsImpl<__covariant T>, DKSUseCaseFlowResultImpl<__contravariant Params, __covariant T>, DKSGetUserUseCaseParams, DKSUseCaseFlowNoParamsImpl<__covariant T>, DKSUseCaseNoParamsImpl<__covariant T>, DKSRefreshUsersUseCaseParams, DKSKotlinArray<T>, DKSKotlinException, DKSKtor_httpUrl, DKSBookEntity, DKSRuntimeQuery<__covariant RowType>, DKSUserCache, DKSUserEntity, DKSErrorResult, DKSResultError<__covariant T>, DKSResultSuccess<__covariant T>, DKSAuthError, DKSBackendError, DKSCommonError, DKSCommonErrorNoUserLoggedIn, DKSResultType, DKSSuccess, DKSLog, DKSKoin_coreScope, DKSKoin_coreParametersHolder, DKSKotlinLazyThreadSafetyMode, DKSKoin_coreModule, DKSKoin_coreLogger, DKSKoin_coreInstanceRegistry, DKSKoin_corePropertyRegistry, DKSKoin_coreScopeRegistry, DKSKoin_coreKoin, DKSKoin_coreKoinApplication, DKSRuntimeTransacterTransaction, DKSKotlinCancellationException, DKSKotlinRuntimeException, DKSKotlinIllegalStateException, DKSKotlinAbstractCoroutineContextElement, DKSKotlinx_coroutines_coreCoroutineDispatcherKey, DKSKtor_httpURLProtocol, DKSKtor_httpUrlCompanion, DKSKoin_coreParametersHolderCompanion, DKSKotlinEnumCompanion, DKSKotlinEnum<E>, DKSKoin_coreInstanceFactory<T>, DKSKotlinPair<__covariant A, __covariant B>, DKSKoin_coreScopeDSL, DKSKoin_coreSingleInstanceFactory<T>, DKSKoin_coreLevel, DKSKoin_coreScopeRegistryCompanion, DKSKoin_coreKoinApplicationCompanion, DKSKotlinByteArray, DKSKotlinAbstractCoroutineContextKey<B, E>, DKSKtor_httpURLProtocolCompanion, DKSKtor_httpUrlEncodingOption, DKSKoin_coreBeanDefinition<T>, DKSKoin_coreInstanceFactoryCompanion, DKSKoin_coreInstanceContext, DKSKotlinByteIterator, DKSKotlinx_coroutines_coreAtomicDesc, DKSKotlinx_coroutines_corePrepareOp, DKSKoin_coreKind, DKSKoin_coreCallbacks<T>, DKSKotlinx_coroutines_coreAtomicOp<__contravariant T>, DKSKotlinx_coroutines_coreOpDescriptor, DKSKotlinx_coroutines_coreLinkedListNode, DKSKotlinx_coroutines_coreAbstractAtomicDesc;

@protocol DKSBookQueries, DKSUserCacheQueries, DKSUserQueries, DKSRuntimeTransactionWithoutReturn, DKSRuntimeTransactionWithReturn, DKSRuntimeTransacter, DKSDatabase, DKSRuntimeSqlDriver, DKSRuntimeSqlDriverSchema, DKSKotlinSuspendFunction1, DKSKotlinx_coroutines_coreJob, DKSUseCaseResultNoParams, DKSDeleteAuthDataUseCase, DKSUseCase, DKSUseCaseResult, DKSLoginUseCase, DKSRegisterUseCase, DKSKotlinx_coroutines_coreFlow, DKSUseCaseFlowNoParams, DKSUseCaseFlow, DKSGetLocalUsersUseCase, DKSUseCaseFlowResultNoParams, DKSGetLoggedInUserUseCase, DKSGetRemoteUsersUseCase, DKSUseCaseFlowResult, DKSGetUserUseCase, DKSGetUsersUseCase, DKSUseCaseNoParams, DKSIsUserLoggedInUseCase, DKSRefreshUsersUseCase, DKSReplaceUserCacheWithUseCase, DKSUpdateLocalUserCacheUseCase, DKSUpdateUserUseCase, DKSUserCacheChangeFlowUseCase, DKSConfig, DKSLogger, DKSKoin_coreKoinScopeComponent, DKSKoin_coreQualifier, DKSKotlinKClass, DKSKotlinLazy, DKSKotlinx_coroutines_coreCoroutineScope, DKSErrorMessageProvider, DKSRuntimeTransactionCallbacks, DKSRuntimeSqlPreparedStatement, DKSRuntimeSqlCursor, DKSRuntimeCloseable, DKSKotlinFunction, DKSKotlinx_coroutines_coreChildHandle, DKSKotlinx_coroutines_coreChildJob, DKSKotlinx_coroutines_coreDisposableHandle, DKSKotlinSequence, DKSKotlinx_coroutines_coreSelectClause0, DKSKotlinCoroutineContextKey, DKSKotlinCoroutineContextElement, DKSKotlinCoroutineContext, DKSKotlinContinuation, DKSKotlinContinuationInterceptor, DKSKotlinx_coroutines_coreRunnable, DKSKotlinx_coroutines_coreFlowCollector, DKSKotlinIterator, DKSKtor_httpParameters, DKSRuntimeQueryListener, DKSKoin_coreScopeCallback, DKSKoin_coreKoinComponent, DKSKotlinKDeclarationContainer, DKSKotlinKAnnotatedElement, DKSKotlinKClassifier, DKSKotlinComparable, DKSKotlinx_coroutines_coreParentJob, DKSKotlinx_coroutines_coreSelectInstance, DKSKotlinSuspendFunction0, DKSKotlinMapEntry, DKSKtor_utilsStringValues;

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-warning-option"
#pragma clang diagnostic ignored "-Wincompatible-property-type"
#pragma clang diagnostic ignored "-Wnullability"

#pragma push_macro("_Nullable_result")
#if !__has_feature(nullability_nullable_result)
#undef _Nullable_result
#define _Nullable_result _Nullable
#endif

__attribute__((swift_name("KotlinBase")))
@interface DKSBase : NSObject
- (instancetype)init __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
+ (void)initialize __attribute__((objc_requires_super));
@end;

@interface DKSBase (DKSBaseCopying) <NSCopying>
@end;

__attribute__((swift_name("KotlinMutableSet")))
@interface DKSMutableSet<ObjectType> : NSMutableSet<ObjectType>
@end;

__attribute__((swift_name("KotlinMutableDictionary")))
@interface DKSMutableDictionary<KeyType, ObjectType> : NSMutableDictionary<KeyType, ObjectType>
@end;

@interface NSError (NSErrorDKSKotlinException)
@property (readonly) id _Nullable kotlinException;
@end;

__attribute__((swift_name("KotlinNumber")))
@interface DKSNumber : NSNumber
- (instancetype)initWithChar:(char)value __attribute__((unavailable));
- (instancetype)initWithUnsignedChar:(unsigned char)value __attribute__((unavailable));
- (instancetype)initWithShort:(short)value __attribute__((unavailable));
- (instancetype)initWithUnsignedShort:(unsigned short)value __attribute__((unavailable));
- (instancetype)initWithInt:(int)value __attribute__((unavailable));
- (instancetype)initWithUnsignedInt:(unsigned int)value __attribute__((unavailable));
- (instancetype)initWithLong:(long)value __attribute__((unavailable));
- (instancetype)initWithUnsignedLong:(unsigned long)value __attribute__((unavailable));
- (instancetype)initWithLongLong:(long long)value __attribute__((unavailable));
- (instancetype)initWithUnsignedLongLong:(unsigned long long)value __attribute__((unavailable));
- (instancetype)initWithFloat:(float)value __attribute__((unavailable));
- (instancetype)initWithDouble:(double)value __attribute__((unavailable));
- (instancetype)initWithBool:(BOOL)value __attribute__((unavailable));
- (instancetype)initWithInteger:(NSInteger)value __attribute__((unavailable));
- (instancetype)initWithUnsignedInteger:(NSUInteger)value __attribute__((unavailable));
+ (instancetype)numberWithChar:(char)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedChar:(unsigned char)value __attribute__((unavailable));
+ (instancetype)numberWithShort:(short)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedShort:(unsigned short)value __attribute__((unavailable));
+ (instancetype)numberWithInt:(int)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedInt:(unsigned int)value __attribute__((unavailable));
+ (instancetype)numberWithLong:(long)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedLong:(unsigned long)value __attribute__((unavailable));
+ (instancetype)numberWithLongLong:(long long)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedLongLong:(unsigned long long)value __attribute__((unavailable));
+ (instancetype)numberWithFloat:(float)value __attribute__((unavailable));
+ (instancetype)numberWithDouble:(double)value __attribute__((unavailable));
+ (instancetype)numberWithBool:(BOOL)value __attribute__((unavailable));
+ (instancetype)numberWithInteger:(NSInteger)value __attribute__((unavailable));
+ (instancetype)numberWithUnsignedInteger:(NSUInteger)value __attribute__((unavailable));
@end;

__attribute__((swift_name("KotlinByte")))
@interface DKSByte : DKSNumber
- (instancetype)initWithChar:(char)value;
+ (instancetype)numberWithChar:(char)value;
@end;

__attribute__((swift_name("KotlinUByte")))
@interface DKSUByte : DKSNumber
- (instancetype)initWithUnsignedChar:(unsigned char)value;
+ (instancetype)numberWithUnsignedChar:(unsigned char)value;
@end;

__attribute__((swift_name("KotlinShort")))
@interface DKSShort : DKSNumber
- (instancetype)initWithShort:(short)value;
+ (instancetype)numberWithShort:(short)value;
@end;

__attribute__((swift_name("KotlinUShort")))
@interface DKSUShort : DKSNumber
- (instancetype)initWithUnsignedShort:(unsigned short)value;
+ (instancetype)numberWithUnsignedShort:(unsigned short)value;
@end;

__attribute__((swift_name("KotlinInt")))
@interface DKSInt : DKSNumber
- (instancetype)initWithInt:(int)value;
+ (instancetype)numberWithInt:(int)value;
@end;

__attribute__((swift_name("KotlinUInt")))
@interface DKSUInt : DKSNumber
- (instancetype)initWithUnsignedInt:(unsigned int)value;
+ (instancetype)numberWithUnsignedInt:(unsigned int)value;
@end;

__attribute__((swift_name("KotlinLong")))
@interface DKSLong : DKSNumber
- (instancetype)initWithLongLong:(long long)value;
+ (instancetype)numberWithLongLong:(long long)value;
@end;

__attribute__((swift_name("KotlinULong")))
@interface DKSULong : DKSNumber
- (instancetype)initWithUnsignedLongLong:(unsigned long long)value;
+ (instancetype)numberWithUnsignedLongLong:(unsigned long long)value;
@end;

__attribute__((swift_name("KotlinFloat")))
@interface DKSFloat : DKSNumber
- (instancetype)initWithFloat:(float)value;
+ (instancetype)numberWithFloat:(float)value;
@end;

__attribute__((swift_name("KotlinDouble")))
@interface DKSDouble : DKSNumber
- (instancetype)initWithDouble:(double)value;
+ (instancetype)numberWithDouble:(double)value;
@end;

__attribute__((swift_name("KotlinBoolean")))
@interface DKSBoolean : DKSNumber
- (instancetype)initWithBool:(BOOL)value;
+ (instancetype)numberWithBool:(BOOL)value;
@end;

__attribute__((swift_name("RuntimeTransacter")))
@protocol DKSRuntimeTransacter
@required
- (void)transactionNoEnclosing:(BOOL)noEnclosing body:(void (^)(id<DKSRuntimeTransactionWithoutReturn>))body __attribute__((swift_name("transaction(noEnclosing:body:)")));
- (id _Nullable)transactionWithResultNoEnclosing:(BOOL)noEnclosing bodyWithReturn:(id _Nullable (^)(id<DKSRuntimeTransactionWithReturn>))bodyWithReturn __attribute__((swift_name("transactionWithResult(noEnclosing:bodyWithReturn:)")));
@end;

__attribute__((swift_name("Database")))
@protocol DKSDatabase <DKSRuntimeTransacter>
@required
@property (readonly) id<DKSBookQueries> bookQueries __attribute__((swift_name("bookQueries")));
@property (readonly) id<DKSUserCacheQueries> userCacheQueries __attribute__((swift_name("userCacheQueries")));
@property (readonly) id<DKSUserQueries> userQueries __attribute__((swift_name("userQueries")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DatabaseCompanion")))
@interface DKSDatabaseCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSDatabaseCompanion *shared __attribute__((swift_name("shared")));
- (id<DKSDatabase>)invokeDriver:(id<DKSRuntimeSqlDriver>)driver __attribute__((swift_name("invoke(driver:)")));
@property (readonly) id<DKSRuntimeSqlDriverSchema> Schema __attribute__((swift_name("Schema")));
@end;

__attribute__((swift_name("FlowWrapperParent")))
@interface DKSFlowWrapperParent<Params, T> : DKSBase
- (instancetype)initWithSuspender:(id<DKSKotlinSuspendFunction1>)suspender __attribute__((swift_name("init(suspender:)"))) __attribute__((objc_designated_initializer));
- (id<DKSKotlinx_coroutines_coreJob>)subscribeParams:(Params _Nullable)params onEach:(void (^)(T _Nullable))onEach onComplete:(void (^)(void))onComplete onThrow:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(params:onEach:onComplete:onThrow:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("FlowWrapper")))
@interface DKSFlowWrapper<Params, Out> : DKSFlowWrapperParent<Params, Out>
- (instancetype)initWithFlow:(id<DKSKotlinSuspendFunction1>)flow __attribute__((swift_name("init(flow:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithSuspender:(id<DKSKotlinSuspendFunction1>)suspender __attribute__((swift_name("init(suspender:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((swift_name("SuspendWrapperParent")))
@interface DKSSuspendWrapperParent<Params, Out> : DKSBase
- (instancetype)initWithSuspender:(id<DKSKotlinSuspendFunction1>)suspender __attribute__((swift_name("init(suspender:)"))) __attribute__((objc_designated_initializer));
- (id<DKSKotlinx_coroutines_coreJob>)subscribeParams:(Params _Nullable)params onSuccess:(void (^)(Out _Nullable))onSuccess onThrow:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(params:onSuccess:onThrow:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SuspendWrapper")))
@interface DKSSuspendWrapper<Params, Out> : DKSSuspendWrapperParent<Params, Out>
- (instancetype)initWithSuspender:(id<DKSKotlinSuspendFunction1>)suspender __attribute__((swift_name("init(suspender:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Book")))
@interface DKSBook : DKSBase
- (instancetype)initWithId:(NSString *)id name:(NSString *)name author:(NSString *)author pages:(int64_t)pages __attribute__((swift_name("init(id:name:author:pages:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString *)component3 __attribute__((swift_name("component3()")));
- (int64_t)component4 __attribute__((swift_name("component4()")));
- (DKSBook *)doCopyId:(NSString *)id name:(NSString *)name author:(NSString *)author pages:(int64_t)pages __attribute__((swift_name("doCopy(id:name:author:pages:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *author __attribute__((swift_name("author")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) int64_t pages __attribute__((swift_name("pages")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("User")))
@interface DKSUser : DKSBase
- (instancetype)initWithId:(NSString *)id email:(NSString *)email bio:(NSString *)bio firstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString * _Nullable)phone __attribute__((swift_name("init(id:email:bio:firstName:lastName:phone:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString *)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (NSString *)component5 __attribute__((swift_name("component5()")));
- (NSString * _Nullable)component6 __attribute__((swift_name("component6()")));
- (DKSUser *)doCopyId:(NSString *)id email:(NSString *)email bio:(NSString *)bio firstName:(NSString *)firstName lastName:(NSString *)lastName phone:(NSString * _Nullable)phone __attribute__((swift_name("doCopy(id:email:bio:firstName:lastName:phone:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *bio __attribute__((swift_name("bio")));
@property (readonly) NSString *email __attribute__((swift_name("email")));
@property (readonly) NSString *firstName __attribute__((swift_name("firstName")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) NSString *lastName __attribute__((swift_name("lastName")));
@property (readonly) NSString * _Nullable phone __attribute__((swift_name("phone")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserPagingData")))
@interface DKSUserPagingData : DKSBase
- (instancetype)initWithId:(NSString *)id email:(NSString *)email firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName __attribute__((swift_name("init(id:email:firstName:lastName:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString * _Nullable)component3 __attribute__((swift_name("component3()")));
- (NSString * _Nullable)component4 __attribute__((swift_name("component4()")));
- (DKSUserPagingData *)doCopyId:(NSString *)id email:(NSString *)email firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName __attribute__((swift_name("doCopy(id:email:firstName:lastName:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *email __attribute__((swift_name("email")));
@property (readonly) NSString * _Nullable firstName __attribute__((swift_name("firstName")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) NSString * _Nullable lastName __attribute__((swift_name("lastName")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserPagingResult")))
@interface DKSUserPagingResult : DKSBase
- (instancetype)initWithUsers:(NSArray<DKSUserPagingData *> *)users totalCount:(int32_t)totalCount limit:(int32_t)limit offset:(int32_t)offset __attribute__((swift_name("init(users:totalCount:limit:offset:)"))) __attribute__((objc_designated_initializer));
- (NSArray<DKSUserPagingData *> *)component1 __attribute__((swift_name("component1()")));
- (int32_t)component2 __attribute__((swift_name("component2()")));
- (int32_t)component3 __attribute__((swift_name("component3()")));
- (int32_t)component4 __attribute__((swift_name("component4()")));
- (DKSUserPagingResult *)doCopyUsers:(NSArray<DKSUserPagingData *> *)users totalCount:(int32_t)totalCount limit:(int32_t)limit offset:(int32_t)offset __attribute__((swift_name("doCopy(users:totalCount:limit:offset:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) int32_t limit __attribute__((swift_name("limit")));
@property (readonly) int32_t offset __attribute__((swift_name("offset")));
@property (readonly) int32_t totalCount __attribute__((swift_name("totalCount")));
@property (readonly) NSArray<DKSUserPagingData *> *users __attribute__((swift_name("users")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserPagingParameters")))
@interface DKSUserPagingParameters : DKSBase
- (instancetype)initWithOffset:(int32_t)offset limit:(int32_t)limit __attribute__((swift_name("init(offset:limit:)"))) __attribute__((objc_designated_initializer));
- (int32_t)component1 __attribute__((swift_name("component1()")));
- (int32_t)component2 __attribute__((swift_name("component2()")));
- (DKSUserPagingParameters *)doCopyOffset:(int32_t)offset limit:(int32_t)limit __attribute__((swift_name("doCopy(offset:limit:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) int32_t limit __attribute__((swift_name("limit")));
@property (readonly) int32_t offset __attribute__((swift_name("offset")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserUpdateParameters")))
@interface DKSUserUpdateParameters : DKSBase
- (instancetype)initWithUserId:(NSString *)userId bio:(NSString * _Nullable)bio firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName pass:(NSString * _Nullable)pass phone:(NSString * _Nullable)phone __attribute__((swift_name("init(userId:bio:firstName:lastName:pass:phone:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString * _Nullable)component2 __attribute__((swift_name("component2()")));
- (NSString * _Nullable)component3 __attribute__((swift_name("component3()")));
- (NSString * _Nullable)component4 __attribute__((swift_name("component4()")));
- (NSString * _Nullable)component5 __attribute__((swift_name("component5()")));
- (NSString * _Nullable)component6 __attribute__((swift_name("component6()")));
- (DKSUserUpdateParameters *)doCopyUserId:(NSString *)userId bio:(NSString * _Nullable)bio firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName pass:(NSString * _Nullable)pass phone:(NSString * _Nullable)phone __attribute__((swift_name("doCopy(userId:bio:firstName:lastName:pass:phone:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString * _Nullable bio __attribute__((swift_name("bio")));
@property (readonly) NSString * _Nullable firstName __attribute__((swift_name("firstName")));
@property (readonly) NSString * _Nullable lastName __attribute__((swift_name("lastName")));
@property (readonly) NSString * _Nullable pass __attribute__((swift_name("pass")));
@property (readonly) NSString * _Nullable phone __attribute__((swift_name("phone")));
@property (readonly) NSString *userId __attribute__((swift_name("userId")));
@end;

__attribute__((swift_name("UseCaseResultNoParams")))
@protocol DKSUseCaseResultNoParams
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(DKSResult<id> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((swift_name("DeleteAuthDataUseCase")))
@protocol DKSDeleteAuthDataUseCase <DKSUseCaseResultNoParams>
@required
@end;

__attribute__((swift_name("UseCaseImpl")))
@interface DKSUseCaseImpl<__contravariant Params, __covariant T> : DKSBase
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(Params _Nullable)params completionHandler:(void (^)(T _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeParams:(Params _Nullable)params completionHandler:(void (^)(T _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(params:completionHandler:)")));
@property (readonly) DKSKotlinx_coroutines_coreCoroutineDispatcher *dispatcher __attribute__((swift_name("dispatcher")));
@end;

__attribute__((swift_name("UseCaseResultNoParamsImpl")))
@interface DKSUseCaseResultNoParamsImpl<__covariant T> : DKSUseCaseImpl<DKSKotlinUnit *, DKSResult<T> *>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(DKSResult<T> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("DeleteAuthDataUseCaseImpl")))
@interface DKSDeleteAuthDataUseCaseImpl : DKSUseCaseResultNoParamsImpl<DKSKotlinUnit *> <DKSDeleteAuthDataUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSKotlinUnit *)params completionHandler:(void (^)(DKSResult<DKSKotlinUnit *> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UseCase")))
@protocol DKSUseCase
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeParams:(id _Nullable)params completionHandler_:(void (^)(id _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(params:completionHandler_:)")));
@end;

__attribute__((swift_name("UseCaseResult")))
@protocol DKSUseCaseResult <DKSUseCase>
@required
@end;

__attribute__((swift_name("LoginUseCase")))
@protocol DKSLoginUseCase <DKSUseCaseResult>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("LoginUseCaseParams")))
@interface DKSLoginUseCaseParams : DKSBase
- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password __attribute__((swift_name("init(email:password:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (DKSLoginUseCaseParams *)doCopyEmail:(NSString *)email password:(NSString *)password __attribute__((swift_name("doCopy(email:password:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *email __attribute__((swift_name("email")));
@property (readonly) NSString *password __attribute__((swift_name("password")));
@end;

__attribute__((swift_name("UseCaseResultImpl")))
@interface DKSUseCaseResultImpl<__contravariant Params, __covariant T> : DKSUseCaseImpl<Params, DKSResult<T> *>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("LoginUseCaseImpl")))
@interface DKSLoginUseCaseImpl : DKSUseCaseResultImpl<DKSLoginUseCaseParams *, DKSKotlinUnit *> <DKSLoginUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSLoginUseCaseParams *)params completionHandler:(void (^)(DKSResult<DKSKotlinUnit *> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("RegisterUseCase")))
@protocol DKSRegisterUseCase <DKSUseCaseResult>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RegisterUseCaseParams")))
@interface DKSRegisterUseCaseParams : DKSBase
- (instancetype)initWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName password:(NSString *)password __attribute__((swift_name("init(email:firstName:lastName:password:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString *)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (DKSRegisterUseCaseParams *)doCopyEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName password:(NSString *)password __attribute__((swift_name("doCopy(email:firstName:lastName:password:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *email __attribute__((swift_name("email")));
@property (readonly) NSString *firstName __attribute__((swift_name("firstName")));
@property (readonly) NSString *lastName __attribute__((swift_name("lastName")));
@property (readonly) NSString *password __attribute__((swift_name("password")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RegisterUseCaseImpl")))
@interface DKSRegisterUseCaseImpl : DKSUseCaseResultImpl<DKSRegisterUseCaseParams *, DKSKotlinUnit *> <DKSRegisterUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSRegisterUseCaseParams *)params completionHandler:(void (^)(DKSResult<DKSKotlinUnit *> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UseCaseFlowNoParams")))
@protocol DKSUseCaseFlowNoParams <DKSUseCase>
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((swift_name("GetBooksUseCase")))
@protocol DKSGetBooksUseCase <DKSUseCaseFlowNoParams>
@required
@end;

__attribute__((swift_name("RefreshBooksUseCase")))
@protocol DKSRefreshBooksUseCase <DKSUseCaseResultNoParams>
@required
@end;

__attribute__((swift_name("UseCaseFlow")))
@protocol DKSUseCaseFlow <DKSUseCase>
@required
@end;

__attribute__((swift_name("GetLocalUsersUseCase")))
@protocol DKSGetLocalUsersUseCase <DKSUseCaseFlow>
@required
@end;

__attribute__((swift_name("UseCaseFlowImpl")))
@interface DKSUseCaseFlowImpl<__contravariant Params, __covariant T> : DKSUseCaseImpl<Params, id<DKSKotlinx_coroutines_coreFlow>>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GetLocalUsersUseCaseImpl")))
@interface DKSGetLocalUsersUseCaseImpl : DKSUseCaseFlowImpl<DKSUserPagingParameters *, DKSUserPagingResult *> <DKSGetLocalUsersUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSUserPagingParameters *)params completionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UseCaseFlowResultNoParams")))
@protocol DKSUseCaseFlowResultNoParams <DKSUseCase>
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((swift_name("GetLoggedInUserUseCase")))
@protocol DKSGetLoggedInUserUseCase <DKSUseCaseFlowResultNoParams>
@required
@end;

__attribute__((swift_name("UseCaseFlowResultNoParamsImpl")))
@interface DKSUseCaseFlowResultNoParamsImpl<__covariant T> : DKSUseCaseImpl<DKSKotlinUnit *, id<DKSKotlinx_coroutines_coreFlow>>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GetLoggedInUserUseCaseImpl")))
@interface DKSGetLoggedInUserUseCaseImpl : DKSUseCaseFlowResultNoParamsImpl<DKSUser *> <DKSGetLoggedInUserUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSKotlinUnit *)params completionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("GetRemoteUsersUseCase")))
@protocol DKSGetRemoteUsersUseCase <DKSUseCaseResult>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GetRemoteUsersUseCaseImpl")))
@interface DKSGetRemoteUsersUseCaseImpl : DKSUseCaseResultImpl<DKSUserPagingParameters *, DKSUserPagingResult *> <DKSGetRemoteUsersUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSUserPagingParameters *)params completionHandler:(void (^)(DKSResult<DKSUserPagingResult *> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UseCaseFlowResult")))
@protocol DKSUseCaseFlowResult <DKSUseCase>
@required
@end;

__attribute__((swift_name("GetUserUseCase")))
@protocol DKSGetUserUseCase <DKSUseCaseFlowResult>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GetUserUseCaseParams")))
@interface DKSGetUserUseCaseParams : DKSBase
- (instancetype)initWithUserId:(NSString *)userId __attribute__((swift_name("init(userId:)"))) __attribute__((objc_designated_initializer));
@property (readonly) NSString *userId __attribute__((swift_name("userId")));
@end;

__attribute__((swift_name("UseCaseFlowResultImpl")))
@interface DKSUseCaseFlowResultImpl<__contravariant Params, __covariant T> : DKSUseCaseImpl<Params, id<DKSKotlinx_coroutines_coreFlow>>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GetUserUseCaseImpl")))
@interface DKSGetUserUseCaseImpl : DKSUseCaseFlowResultImpl<DKSGetUserUseCaseParams *, DKSUser *> <DKSGetUserUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSGetUserUseCaseParams *)params completionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("GetUsersUseCase")))
@protocol DKSGetUsersUseCase <DKSUseCaseFlowNoParams>
@required
@end;

__attribute__((swift_name("UseCaseFlowNoParamsImpl")))
@interface DKSUseCaseFlowNoParamsImpl<__covariant T> : DKSUseCaseImpl<DKSKotlinUnit *, id<DKSKotlinx_coroutines_coreFlow>>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("GetUsersUseCaseImpl")))
@interface DKSGetUsersUseCaseImpl : DKSUseCaseFlowNoParamsImpl<NSArray<DKSUser *> *> <DKSGetUsersUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSKotlinUnit *)params completionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UseCaseNoParams")))
@protocol DKSUseCaseNoParams <DKSUseCase>
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(id _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((swift_name("IsUserLoggedInUseCase")))
@protocol DKSIsUserLoggedInUseCase <DKSUseCaseNoParams>
@required
@end;

__attribute__((swift_name("UseCaseNoParamsImpl")))
@interface DKSUseCaseNoParamsImpl<__covariant T> : DKSUseCaseImpl<DKSKotlinUnit *, T>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(T _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("IsUserLoggedInUseCaseImpl")))
@interface DKSIsUserLoggedInUseCaseImpl : DKSUseCaseNoParamsImpl<DKSBoolean *> <DKSIsUserLoggedInUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSKotlinUnit *)params completionHandler:(void (^)(DKSBoolean * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("RefreshUsersUseCase")))
@protocol DKSRefreshUsersUseCase <DKSUseCaseResult>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RefreshUsersUseCaseParams")))
@interface DKSRefreshUsersUseCaseParams : DKSBase
- (instancetype)initWithOffset:(int32_t)offset limit:(int32_t)limit __attribute__((swift_name("init(offset:limit:)"))) __attribute__((objc_designated_initializer));
- (int32_t)component1 __attribute__((swift_name("component1()")));
- (int32_t)component2 __attribute__((swift_name("component2()")));
- (DKSRefreshUsersUseCaseParams *)doCopyOffset:(int32_t)offset limit:(int32_t)limit __attribute__((swift_name("doCopy(offset:limit:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) int32_t limit __attribute__((swift_name("limit")));
@property (readonly) int32_t offset __attribute__((swift_name("offset")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("RefreshUsersUseCaseImpl")))
@interface DKSRefreshUsersUseCaseImpl : DKSUseCaseResultImpl<DKSRefreshUsersUseCaseParams *, DKSKotlinUnit *> <DKSRefreshUsersUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSRefreshUsersUseCaseParams *)params completionHandler:(void (^)(DKSResult<DKSKotlinUnit *> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("ReplaceUserCacheWithUseCase")))
@protocol DKSReplaceUserCacheWithUseCase <DKSUseCase>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ReplaceUserCacheWithUseCaseImpl")))
@interface DKSReplaceUserCacheWithUseCaseImpl : DKSUseCaseImpl<NSArray<DKSUserPagingData *> *, DKSKotlinUnit *> <DKSReplaceUserCacheWithUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(NSArray<DKSUserPagingData *> *)params completionHandler:(void (^)(DKSKotlinUnit * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UpdateLocalUserCacheUseCase")))
@protocol DKSUpdateLocalUserCacheUseCase <DKSUseCase>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UpdateLocalUserCacheUseCaseImpl")))
@interface DKSUpdateLocalUserCacheUseCaseImpl : DKSUseCaseImpl<NSArray<DKSUserPagingData *> *, DKSKotlinUnit *> <DKSUpdateLocalUserCacheUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(NSArray<DKSUserPagingData *> *)params completionHandler:(void (^)(DKSKotlinUnit * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UpdateUserUseCase")))
@protocol DKSUpdateUserUseCase <DKSUseCaseResult>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UpdateUserUseCaseImpl")))
@interface DKSUpdateUserUseCaseImpl : DKSUseCaseResultImpl<DKSUserUpdateParameters *, DKSUser *> <DKSUpdateUserUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSUserUpdateParameters *)params completionHandler:(void (^)(DKSResult<DKSUser *> * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("UserCacheChangeFlowUseCase")))
@protocol DKSUserCacheChangeFlowUseCase <DKSUseCaseNoParams>
@required
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserCacheChangeFlowUseCaseImpl")))
@interface DKSUserCacheChangeFlowUseCaseImpl : DKSUseCaseNoParamsImpl<id<DKSKotlinx_coroutines_coreFlow>> <DKSUserCacheChangeFlowUseCase>
- (instancetype)initWithDispatcher:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)dispatcher __attribute__((swift_name("init(dispatcher:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)doWorkParams:(DKSKotlinUnit *)params completionHandler:(void (^)(id<DKSKotlinx_coroutines_coreFlow> _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("doWork(params:completionHandler:)")));
@end;

__attribute__((swift_name("KotlinThrowable")))
@interface DKSKotlinThrowable : DKSBase
- (instancetype)initWithMessage:(NSString * _Nullable)message __attribute__((swift_name("init(message:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithCause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(cause:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (instancetype)initWithMessage:(NSString * _Nullable)message cause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(message:cause:)"))) __attribute__((objc_designated_initializer));
- (DKSKotlinArray<NSString *> *)getStackTrace __attribute__((swift_name("getStackTrace()")));
- (void)printStackTrace __attribute__((swift_name("printStackTrace()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) DKSKotlinThrowable * _Nullable cause __attribute__((swift_name("cause")));
@property (readonly) NSString * _Nullable message __attribute__((swift_name("message")));
- (NSError *)asError __attribute__((swift_name("asError()")));
@end;

__attribute__((swift_name("KotlinException")))
@interface DKSKotlinException : DKSKotlinThrowable
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (instancetype)initWithMessage:(NSString * _Nullable)message __attribute__((swift_name("init(message:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message cause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(message:cause:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithCause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(cause:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("NoTokenException")))
@interface DKSNoTokenException : DKSKotlinException
- (instancetype)initWithUrl:(DKSKtor_httpUrl *)url __attribute__((swift_name("init(url:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
- (instancetype)initWithMessage:(NSString * _Nullable)message __attribute__((swift_name("init(message:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
- (instancetype)initWithMessage:(NSString * _Nullable)message cause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(message:cause:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
- (instancetype)initWithCause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(cause:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("BookEntity")))
@interface DKSBookEntity : DKSBase
- (instancetype)initWithId:(NSString *)id name:(NSString *)name author:(NSString * _Nullable)author pageCount:(DKSLong * _Nullable)pageCount __attribute__((swift_name("init(id:name:author:pageCount:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString * _Nullable)component3 __attribute__((swift_name("component3()")));
- (DKSLong * _Nullable)component4 __attribute__((swift_name("component4()")));
- (DKSBookEntity *)doCopyId:(NSString *)id name:(NSString *)name author:(NSString * _Nullable)author pageCount:(DKSLong * _Nullable)pageCount __attribute__((swift_name("doCopy(id:name:author:pageCount:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString * _Nullable author __attribute__((swift_name("author")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) DKSLong * _Nullable pageCount __attribute__((swift_name("pageCount")));
@end;

__attribute__((swift_name("BookQueries")))
@protocol DKSBookQueries <DKSRuntimeTransacter>
@required
- (void)deleteId:(NSString *)id __attribute__((swift_name("delete(id:)")));
- (void)deleteAllBooks __attribute__((swift_name("deleteAllBooks()")));
- (DKSRuntimeQuery<DKSBookEntity *> *)getAllBooks __attribute__((swift_name("getAllBooks()")));
- (DKSRuntimeQuery<id> *)getAllBooksMapper:(id (^)(NSString *, NSString *, NSString * _Nullable, DKSLong * _Nullable))mapper __attribute__((swift_name("getAllBooks(mapper:)")));
- (DKSRuntimeQuery<DKSBookEntity *> *)getBookId:(NSString *)id __attribute__((swift_name("getBook(id:)")));
- (DKSRuntimeQuery<id> *)getBookId:(NSString *)id mapper:(id (^)(NSString *, NSString *, NSString * _Nullable, DKSLong * _Nullable))mapper __attribute__((swift_name("getBook(id:mapper:)")));
- (void)insertOrReplaceBookEntity:(DKSBookEntity *)BookEntity __attribute__((swift_name("insertOrReplace(BookEntity:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserCache")))
@interface DKSUserCache : DKSBase
- (instancetype)initWithId:(NSString *)id email:(NSString *)email firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName __attribute__((swift_name("init(id:email:firstName:lastName:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString * _Nullable)component3 __attribute__((swift_name("component3()")));
- (NSString * _Nullable)component4 __attribute__((swift_name("component4()")));
- (DKSUserCache *)doCopyId:(NSString *)id email:(NSString *)email firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName __attribute__((swift_name("doCopy(id:email:firstName:lastName:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *email __attribute__((swift_name("email")));
@property (readonly) NSString * _Nullable firstName __attribute__((swift_name("firstName")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) NSString * _Nullable lastName __attribute__((swift_name("lastName")));
@end;

__attribute__((swift_name("UserCacheQueries")))
@protocol DKSUserCacheQueries <DKSRuntimeTransacter>
@required
- (void)deleteId:(NSString *)id __attribute__((swift_name("delete(id:)")));
- (void)deleteCache __attribute__((swift_name("deleteCache()")));
- (DKSRuntimeQuery<DKSUserCache *> *)getCache __attribute__((swift_name("getCache()")));
- (DKSRuntimeQuery<id> *)getCacheMapper:(id (^)(NSString *, NSString *, NSString * _Nullable, NSString * _Nullable))mapper __attribute__((swift_name("getCache(mapper:)")));
- (DKSRuntimeQuery<DKSLong *> *)getUserCount __attribute__((swift_name("getUserCount()")));
- (DKSRuntimeQuery<DKSUserCache *> *)getUsersPaginatedLimit:(int64_t)limit offset:(int64_t)offset __attribute__((swift_name("getUsersPaginated(limit:offset:)")));
- (DKSRuntimeQuery<id> *)getUsersPaginatedLimit:(int64_t)limit offset:(int64_t)offset mapper:(id (^)(NSString *, NSString *, NSString * _Nullable, NSString * _Nullable))mapper __attribute__((swift_name("getUsersPaginated(limit:offset:mapper:)")));
- (void)insertOrReplaceUserCache:(DKSUserCache *)UserCache __attribute__((swift_name("insertOrReplace(UserCache:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("UserEntity")))
@interface DKSUserEntity : DKSBase
- (instancetype)initWithId:(NSString *)id email:(NSString *)email firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName phone:(NSString * _Nullable)phone bio:(NSString * _Nullable)bio __attribute__((swift_name("init(id:email:firstName:lastName:phone:bio:)"))) __attribute__((objc_designated_initializer));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (NSString * _Nullable)component3 __attribute__((swift_name("component3()")));
- (NSString * _Nullable)component4 __attribute__((swift_name("component4()")));
- (NSString * _Nullable)component5 __attribute__((swift_name("component5()")));
- (NSString * _Nullable)component6 __attribute__((swift_name("component6()")));
- (DKSUserEntity *)doCopyId:(NSString *)id email:(NSString *)email firstName:(NSString * _Nullable)firstName lastName:(NSString * _Nullable)lastName phone:(NSString * _Nullable)phone bio:(NSString * _Nullable)bio __attribute__((swift_name("doCopy(id:email:firstName:lastName:phone:bio:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString * _Nullable bio __attribute__((swift_name("bio")));
@property (readonly) NSString *email __attribute__((swift_name("email")));
@property (readonly) NSString * _Nullable firstName __attribute__((swift_name("firstName")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) NSString * _Nullable lastName __attribute__((swift_name("lastName")));
@property (readonly) NSString * _Nullable phone __attribute__((swift_name("phone")));
@end;

__attribute__((swift_name("UserQueries")))
@protocol DKSUserQueries <DKSRuntimeTransacter>
@required
- (void)deleteAllUsers __attribute__((swift_name("deleteAllUsers()")));
- (void)deleteUserId:(NSString *)id __attribute__((swift_name("deleteUser(id:)")));
- (DKSRuntimeQuery<DKSUserEntity *> *)getAllUsers __attribute__((swift_name("getAllUsers()")));
- (DKSRuntimeQuery<id> *)getAllUsersMapper:(id (^)(NSString *, NSString *, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable))mapper __attribute__((swift_name("getAllUsers(mapper:)")));
- (DKSRuntimeQuery<DKSUserEntity *> *)getUserId:(NSString *)id __attribute__((swift_name("getUser(id:)")));
- (DKSRuntimeQuery<id> *)getUserId:(NSString *)id mapper:(id (^)(NSString *, NSString *, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable))mapper __attribute__((swift_name("getUser(id:mapper:)")));
- (void)insertOrReplaceUserEntity:(DKSUserEntity *)UserEntity __attribute__((swift_name("insertOrReplace(UserEntity:)")));
@end;

__attribute__((swift_name("ErrorResult")))
@interface DKSErrorResult : DKSBase
- (instancetype)initWithMessage:(NSString * _Nullable)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(message:throwable:)"))) __attribute__((objc_designated_initializer));
@property NSString * _Nullable message __attribute__((swift_name("message")));
@property DKSKotlinThrowable * _Nullable throwable __attribute__((swift_name("throwable")));
@end;

__attribute__((swift_name("Result")))
@interface DKSResult<__covariant T> : DKSBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResultError")))
@interface DKSResultError<__covariant T> : DKSResult<T>
- (instancetype)initWithError:(DKSErrorResult *)error data:(T _Nullable)data __attribute__((swift_name("init(error:data:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
- (DKSErrorResult *)component1 __attribute__((swift_name("component1()")));
- (T _Nullable)component2 __attribute__((swift_name("component2()")));
- (DKSResultError<T> *)doCopyError:(DKSErrorResult *)error data:(T _Nullable)data __attribute__((swift_name("doCopy(error:data:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) T _Nullable data __attribute__((swift_name("data")));
@property (readonly) DKSErrorResult *error __attribute__((swift_name("error")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResultSuccess")))
@interface DKSResultSuccess<__covariant T> : DKSResult<T>
- (instancetype)initWithData:(T)data __attribute__((swift_name("init(data:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
- (T)component1 __attribute__((swift_name("component1()")));
- (DKSResultSuccess<T> *)doCopyData:(T)data __attribute__((swift_name("doCopy(data:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) T data __attribute__((swift_name("data")));
@end;

__attribute__((swift_name("ErrorMessageProvider")))
@protocol DKSErrorMessageProvider
@required
- (NSString *)getMessage:(DKSErrorResult *)receiver defMessage:(NSString *)defMessage __attribute__((swift_name("getMessage(_:defMessage:)")));
@property (readonly) NSString *defaultMessage __attribute__((swift_name("defaultMessage")));
@end;

__attribute__((swift_name("AuthError")))
@interface DKSAuthError : DKSErrorResult
- (instancetype)initWithMessage:(NSString * _Nullable)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(message:throwable:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("AuthError.EmailAlreadyExist")))
@interface DKSAuthErrorEmailAlreadyExist : DKSAuthError
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(throwable:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(message:throwable:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("AuthError.InvalidLoginCredentials")))
@interface DKSAuthErrorInvalidLoginCredentials : DKSAuthError
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(throwable:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(message:throwable:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((swift_name("BackendError")))
@interface DKSBackendError : DKSErrorResult
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable responseMessage:(NSString * _Nullable)responseMessage __attribute__((swift_name("init(throwable:responseMessage:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(message:throwable:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("BackendError.NotAuthorized")))
@interface DKSBackendErrorNotAuthorized : DKSBackendError
- (instancetype)initWithResponseMessage:(NSString * _Nullable)responseMessage throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(responseMessage:throwable:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable responseMessage:(NSString * _Nullable)responseMessage __attribute__((swift_name("init(throwable:responseMessage:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((swift_name("CommonError")))
@interface DKSCommonError : DKSErrorResult
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(throwable:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(message:throwable:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CommonError.NoNetworkConnection")))
@interface DKSCommonErrorNoNetworkConnection : DKSCommonError
- (instancetype)initWithT:(DKSKotlinThrowable * _Nullable)t __attribute__((swift_name("init(t:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(throwable:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("CommonError.NoUserLoggedIn")))
@interface DKSCommonErrorNoUserLoggedIn : DKSCommonError
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithThrowable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("init(throwable:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)noUserLoggedIn __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSCommonErrorNoUserLoggedIn *shared __attribute__((swift_name("shared")));
@end;

__attribute__((swift_name("ResultType")))
@interface DKSResultType : DKSBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Error")))
@interface DKSError : DKSResultType
- (instancetype)initWithError:(DKSErrorResult *)error __attribute__((swift_name("init(error:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
@property (readonly) DKSErrorResult *error __attribute__((swift_name("error")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Success")))
@interface DKSSuccess : DKSResultType
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
+ (instancetype)success __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSSuccess *shared __attribute__((swift_name("shared")));
@end;

__attribute__((swift_name("Config")))
@protocol DKSConfig
@required
@property (readonly) BOOL isRelease __attribute__((swift_name("isRelease")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ConfigImpl")))
@interface DKSConfigImpl : DKSBase <DKSConfig>
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
@property (readonly) BOOL isRelease __attribute__((swift_name("isRelease")));
@end;

__attribute__((swift_name("Logger")))
@protocol DKSLogger
@required
- (void)dTag:(NSString *)tag message:(NSString *)message __attribute__((swift_name("d(tag:message:)")));
- (void)eTag:(NSString *)tag message:(NSString *)message throwable:(DKSKotlinThrowable *)throwable __attribute__((swift_name("e(tag:message:throwable:)")));
- (void)wTag:(NSString *)tag message:(NSString *)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("w(tag:message:throwable:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Log")))
@interface DKSLog : DKSBase <DKSLogger>
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)log __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSLog *shared __attribute__((swift_name("shared")));
- (void)dTag:(NSString *)tag message:(NSString *)message __attribute__((swift_name("d(tag:message:)")));
- (void)eTag:(NSString *)tag message:(NSString *)message throwable:(DKSKotlinThrowable *)throwable __attribute__((swift_name("e(tag:message:throwable:)")));
- (void)wTag:(NSString *)tag message:(NSString *)message throwable:(DKSKotlinThrowable * _Nullable)throwable __attribute__((swift_name("w(tag:message:throwable:)")));
@end;

@interface DKSUser (Extensions)
@property (readonly) NSString *fullName __attribute__((swift_name("fullName")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreKoin")))
@interface DKSKoin_coreKoin : DKSBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)close __attribute__((swift_name("close()")));
- (void)createEagerInstances __attribute__((swift_name("createEagerInstances()")));
- (DKSKoin_coreScope *)createScopeT:(id<DKSKoin_coreKoinScopeComponent>)t __attribute__((swift_name("createScope(t:)")));
- (DKSKoin_coreScope *)createScopeScopeId:(NSString *)scopeId __attribute__((swift_name("createScope(scopeId:)")));
- (DKSKoin_coreScope *)createScopeScopeId:(NSString *)scopeId source:(id _Nullable)source __attribute__((swift_name("createScope(scopeId:source:)")));
- (DKSKoin_coreScope *)createScopeScopeId:(NSString *)scopeId qualifier:(id<DKSKoin_coreQualifier>)qualifier source:(id _Nullable)source __attribute__((swift_name("createScope(scopeId:qualifier:source:)")));
- (void)declareInstance:(id _Nullable)instance qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier secondaryTypes:(NSArray<id<DKSKotlinKClass>> *)secondaryTypes allowOverride:(BOOL)allowOverride __attribute__((swift_name("declare(instance:qualifier:secondaryTypes:allowOverride:)")));
- (void)deletePropertyKey:(NSString *)key __attribute__((swift_name("deleteProperty(key:)")));
- (void)deleteScopeScopeId:(NSString *)scopeId __attribute__((swift_name("deleteScope(scopeId:)")));
- (id _Nullable)getClazz:(id<DKSKotlinKClass>)clazz qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("get(clazz:qualifier:parameters:)")));
- (id)getQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("get(qualifier:parameters:)")));
- (NSArray<id> *)getAll __attribute__((swift_name("getAll()")));
- (DKSKoin_coreScope *)getOrCreateScopeScopeId:(NSString *)scopeId __attribute__((swift_name("getOrCreateScope(scopeId:)")));
- (DKSKoin_coreScope *)getOrCreateScopeScopeId:(NSString *)scopeId qualifier:(id<DKSKoin_coreQualifier>)qualifier source:(id _Nullable)source __attribute__((swift_name("getOrCreateScope(scopeId:qualifier:source:)")));
- (id _Nullable)getOrNullClazz:(id<DKSKotlinKClass>)clazz qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("getOrNull(clazz:qualifier:parameters:)")));
- (id _Nullable)getOrNullQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("getOrNull(qualifier:parameters:)")));
- (id _Nullable)getPropertyKey:(NSString *)key __attribute__((swift_name("getProperty(key:)")));
- (id)getPropertyKey:(NSString *)key defaultValue:(id)defaultValue __attribute__((swift_name("getProperty(key:defaultValue:)")));
- (DKSKoin_coreScope *)getScopeScopeId:(NSString *)scopeId __attribute__((swift_name("getScope(scopeId:)")));
- (DKSKoin_coreScope * _Nullable)getScopeOrNullScopeId:(NSString *)scopeId __attribute__((swift_name("getScopeOrNull(scopeId:)")));
- (id<DKSKotlinLazy>)injectQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier mode:(DKSKotlinLazyThreadSafetyMode *)mode parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("inject(qualifier:mode:parameters:)")));
- (id<DKSKotlinLazy>)injectOrNullQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier mode:(DKSKotlinLazyThreadSafetyMode *)mode parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("injectOrNull(qualifier:mode:parameters:)")));
- (void)loadModulesModules:(NSArray<DKSKoin_coreModule *> *)modules allowOverride:(BOOL)allowOverride __attribute__((swift_name("loadModules(modules:allowOverride:)")));
- (void)setPropertyKey:(NSString *)key value:(id)value __attribute__((swift_name("setProperty(key:value:)")));
- (void)setupLoggerLogger:(DKSKoin_coreLogger *)logger __attribute__((swift_name("setupLogger(logger:)")));
- (void)unloadModulesModules:(NSArray<DKSKoin_coreModule *> *)modules __attribute__((swift_name("unloadModules(modules:)")));
@property (readonly) DKSKoin_coreInstanceRegistry *instanceRegistry __attribute__((swift_name("instanceRegistry")));
@property (readonly) DKSKoin_coreLogger *logger __attribute__((swift_name("logger")));
@property (readonly) DKSKoin_corePropertyRegistry *propertyRegistry __attribute__((swift_name("propertyRegistry")));
@property (readonly) DKSKoin_coreScopeRegistry *scopeRegistry __attribute__((swift_name("scopeRegistry")));
@end;

@interface DKSKoin_coreKoin (Extensions)
- (id)getObjCClass:(Class)objCClass __attribute__((swift_name("get(objCClass:)")));
- (id)getObjCClass:(Class)objCClass parameter:(id)parameter __attribute__((swift_name("get(objCClass:parameter:)")));
- (id)getObjCClass:(Class)objCClass qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier __attribute__((swift_name("get(objCClass:qualifier:)")));
- (id)getObjCClass:(Class)objCClass qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameter:(id)parameter __attribute__((swift_name("get(objCClass:qualifier:parameter:)")));
@end;

@interface DKSResult (Extensions)
- (DKSResult<id> *)mapTransform:(id (^)(id))transform __attribute__((swift_name("map(transform:)")));
- (DKSResult<DKSKotlinUnit *> *)toEmptyResult __attribute__((swift_name("toEmptyResult()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("SwiftCoroutinesKt")))
@interface DKSSwiftCoroutinesKt : DKSBase
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCase>)receiver params:(id)params onSuccess:(void (^)(id))onSuccess onThrow:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:params:onSuccess:onThrow:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseFlow>)receiver params:(id)params onEach:(void (^)(id))onEach onComplete:(void (^)(void))onComplete onThrow:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:params:onEach:onComplete:onThrow:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseFlowNoParams>)receiver onEach:(void (^)(id))onEach onComplete:(void (^)(void))onComplete onThrow:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:onEach:onComplete:onThrow:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseFlowResult>)receiver params:(id)params onEach:(void (^)(DKSResult<id> *))onEach onComplete:(void (^)(void))onComplete onThrow_:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:params:onEach:onComplete:onThrow_:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseFlowResultNoParams>)receiver onEach:(void (^)(DKSResult<id> *))onEach onComplete:(void (^)(void))onComplete onThrow_:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:onEach:onComplete:onThrow_:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseNoParams>)receiver onSuccess:(void (^)(id))onSuccess onThrow:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:onSuccess:onThrow:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseResult>)receiver params:(id)params onSuccess:(void (^)(DKSResult<id> *))onSuccess onThrow_:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:params:onSuccess:onThrow_:)")));
+ (id<DKSKotlinx_coroutines_coreJob>)subscribe:(id<DKSUseCaseResultNoParams>)receiver onSuccess:(void (^)(DKSResult<id> *))onSuccess onThrow_:(void (^)(DKSKotlinThrowable *))onThrow __attribute__((swift_name("subscribe(_:onSuccess:onThrow_:)")));
@property (class, readonly) id<DKSKotlinx_coroutines_coreCoroutineScope> iosDefaultScope __attribute__((swift_name("iosDefaultScope")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KoinIOSKt")))
@interface DKSKoinIOSKt : DKSBase
+ (DKSKoin_coreKoinApplication *)doInitKoinIosDoOnStartup:(void (^)(void))doOnStartup __attribute__((swift_name("doInitKoinIos(doOnStartup:)")));
@property (class, readonly) DKSKoin_coreModule *platformModule __attribute__((swift_name("platformModule")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ModuleKt")))
@interface DKSModuleKt : DKSBase
+ (DKSKoin_coreKoinApplication *)doInitKoinAppDeclaration:(void (^)(DKSKoin_coreKoinApplication *))appDeclaration __attribute__((swift_name("doInitKoin(appDeclaration:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("MessagesKt")))
@interface DKSMessagesKt : DKSBase
+ (NSString *)getMessage:(id<DKSErrorMessageProvider>)receiver error:(DKSErrorResult *)error defMessage:(NSString * _Nullable)defMessage __attribute__((swift_name("getMessage(_:error:defMessage:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("ResultToKt")))
@interface DKSResultToKt : DKSBase
+ (DKSResult<id> *)resultsTo:(id)receiver result:(DKSResultType *)result __attribute__((swift_name("resultsTo(_:result:)")));
+ (DKSResult<id> *)resultsTo:(id _Nullable)receiver result_:(DKSErrorResult *)result __attribute__((swift_name("resultsTo(_:result_:)")));
@end;

__attribute__((swift_name("RuntimeTransactionCallbacks")))
@protocol DKSRuntimeTransactionCallbacks
@required
- (void)afterCommitFunction:(void (^)(void))function __attribute__((swift_name("afterCommit(function:)")));
- (void)afterRollbackFunction:(void (^)(void))function __attribute__((swift_name("afterRollback(function:)")));
@end;

__attribute__((swift_name("RuntimeTransactionWithoutReturn")))
@protocol DKSRuntimeTransactionWithoutReturn <DKSRuntimeTransactionCallbacks>
@required
- (void)rollback __attribute__((swift_name("rollback()")));
- (void)transactionBody:(void (^)(id<DKSRuntimeTransactionWithoutReturn>))body __attribute__((swift_name("transaction(body:)")));
@end;

__attribute__((swift_name("RuntimeTransactionWithReturn")))
@protocol DKSRuntimeTransactionWithReturn <DKSRuntimeTransactionCallbacks>
@required
- (void)rollbackReturnValue:(id _Nullable)returnValue __attribute__((swift_name("rollback(returnValue:)")));
- (id _Nullable)transactionBody_:(id _Nullable (^)(id<DKSRuntimeTransactionWithReturn>))body __attribute__((swift_name("transaction(body_:)")));
@end;

__attribute__((swift_name("RuntimeCloseable")))
@protocol DKSRuntimeCloseable
@required
- (void)close __attribute__((swift_name("close()")));
@end;

__attribute__((swift_name("RuntimeSqlDriver")))
@protocol DKSRuntimeSqlDriver <DKSRuntimeCloseable>
@required
- (DKSRuntimeTransacterTransaction * _Nullable)currentTransaction __attribute__((swift_name("currentTransaction()")));
- (void)executeIdentifier:(DKSInt * _Nullable)identifier sql:(NSString *)sql parameters:(int32_t)parameters binders:(void (^ _Nullable)(id<DKSRuntimeSqlPreparedStatement>))binders __attribute__((swift_name("execute(identifier:sql:parameters:binders:)")));
- (id<DKSRuntimeSqlCursor>)executeQueryIdentifier:(DKSInt * _Nullable)identifier sql:(NSString *)sql parameters:(int32_t)parameters binders:(void (^ _Nullable)(id<DKSRuntimeSqlPreparedStatement>))binders __attribute__((swift_name("executeQuery(identifier:sql:parameters:binders:)")));
- (DKSRuntimeTransacterTransaction *)doNewTransaction __attribute__((swift_name("doNewTransaction()")));
@end;

__attribute__((swift_name("RuntimeSqlDriverSchema")))
@protocol DKSRuntimeSqlDriverSchema
@required
- (void)createDriver:(id<DKSRuntimeSqlDriver>)driver __attribute__((swift_name("create(driver:)")));
- (void)migrateDriver:(id<DKSRuntimeSqlDriver>)driver oldVersion:(int32_t)oldVersion newVersion:(int32_t)newVersion __attribute__((swift_name("migrate(driver:oldVersion:newVersion:)")));
@property (readonly) int32_t version __attribute__((swift_name("version")));
@end;

__attribute__((swift_name("KotlinFunction")))
@protocol DKSKotlinFunction
@required
@end;

__attribute__((swift_name("KotlinSuspendFunction1")))
@protocol DKSKotlinSuspendFunction1 <DKSKotlinFunction>
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeP1:(id _Nullable)p1 completionHandler:(void (^)(id _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(p1:completionHandler:)")));
@end;

__attribute__((swift_name("KotlinCoroutineContext")))
@protocol DKSKotlinCoroutineContext
@required
- (id _Nullable)foldInitial:(id _Nullable)initial operation:(id _Nullable (^)(id _Nullable, id<DKSKotlinCoroutineContextElement>))operation __attribute__((swift_name("fold(initial:operation:)")));
- (id<DKSKotlinCoroutineContextElement> _Nullable)getKey:(id<DKSKotlinCoroutineContextKey>)key __attribute__((swift_name("get(key:)")));
- (id<DKSKotlinCoroutineContext>)minusKeyKey:(id<DKSKotlinCoroutineContextKey>)key __attribute__((swift_name("minusKey(key:)")));
- (id<DKSKotlinCoroutineContext>)plusContext:(id<DKSKotlinCoroutineContext>)context __attribute__((swift_name("plus(context:)")));
@end;

__attribute__((swift_name("KotlinCoroutineContextElement")))
@protocol DKSKotlinCoroutineContextElement <DKSKotlinCoroutineContext>
@required
@property (readonly) id<DKSKotlinCoroutineContextKey> key __attribute__((swift_name("key")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreJob")))
@protocol DKSKotlinx_coroutines_coreJob <DKSKotlinCoroutineContextElement>
@required
- (id<DKSKotlinx_coroutines_coreChildHandle>)attachChildChild:(id<DKSKotlinx_coroutines_coreChildJob>)child __attribute__((swift_name("attachChild(child:)")));
- (void)cancelCause:(DKSKotlinCancellationException * _Nullable)cause __attribute__((swift_name("cancel(cause:)")));
- (DKSKotlinCancellationException *)getCancellationException __attribute__((swift_name("getCancellationException()")));
- (id<DKSKotlinx_coroutines_coreDisposableHandle>)invokeOnCompletionOnCancelling:(BOOL)onCancelling invokeImmediately:(BOOL)invokeImmediately handler:(void (^)(DKSKotlinThrowable * _Nullable))handler __attribute__((swift_name("invokeOnCompletion(onCancelling:invokeImmediately:handler:)")));
- (id<DKSKotlinx_coroutines_coreDisposableHandle>)invokeOnCompletionHandler:(void (^)(DKSKotlinThrowable * _Nullable))handler __attribute__((swift_name("invokeOnCompletion(handler:)")));

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)joinWithCompletionHandler:(void (^)(DKSKotlinUnit * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("join(completionHandler:)")));
- (id<DKSKotlinx_coroutines_coreJob>)plusOther:(id<DKSKotlinx_coroutines_coreJob>)other __attribute__((swift_name("plus(other:)"))) __attribute__((unavailable("Operator '+' on two Job objects is meaningless. Job is a coroutine context element and `+` is a set-sum operator for coroutine contexts. The job to the right of `+` just replaces the job the left of `+`.")));
- (BOOL)start __attribute__((swift_name("start()")));
@property (readonly) id<DKSKotlinSequence> children __attribute__((swift_name("children")));
@property (readonly) BOOL isActive __attribute__((swift_name("isActive")));
@property (readonly) BOOL isCancelled __attribute__((swift_name("isCancelled")));
@property (readonly) BOOL isCompleted __attribute__((swift_name("isCompleted")));
@property (readonly) id<DKSKotlinx_coroutines_coreSelectClause0> onJoin __attribute__((swift_name("onJoin")));
@end;

__attribute__((swift_name("KotlinRuntimeException")))
@interface DKSKotlinRuntimeException : DKSKotlinException
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (instancetype)initWithMessage:(NSString * _Nullable)message __attribute__((swift_name("init(message:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message cause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(message:cause:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithCause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(cause:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((swift_name("KotlinIllegalStateException")))
@interface DKSKotlinIllegalStateException : DKSKotlinRuntimeException
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (instancetype)initWithMessage:(NSString * _Nullable)message __attribute__((swift_name("init(message:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message cause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(message:cause:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithCause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(cause:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((swift_name("KotlinCancellationException")))
@interface DKSKotlinCancellationException : DKSKotlinIllegalStateException
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (instancetype)initWithMessage:(NSString * _Nullable)message __attribute__((swift_name("init(message:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithMessage:(NSString * _Nullable)message cause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(message:cause:)"))) __attribute__((objc_designated_initializer));
- (instancetype)initWithCause:(DKSKotlinThrowable * _Nullable)cause __attribute__((swift_name("init(cause:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((swift_name("KotlinAbstractCoroutineContextElement")))
@interface DKSKotlinAbstractCoroutineContextElement : DKSBase <DKSKotlinCoroutineContextElement>
- (instancetype)initWithKey:(id<DKSKotlinCoroutineContextKey>)key __attribute__((swift_name("init(key:)"))) __attribute__((objc_designated_initializer));
@property (readonly) id<DKSKotlinCoroutineContextKey> key __attribute__((swift_name("key")));
@end;

__attribute__((swift_name("KotlinContinuationInterceptor")))
@protocol DKSKotlinContinuationInterceptor <DKSKotlinCoroutineContextElement>
@required
- (id<DKSKotlinContinuation>)interceptContinuationContinuation:(id<DKSKotlinContinuation>)continuation __attribute__((swift_name("interceptContinuation(continuation:)")));
- (void)releaseInterceptedContinuationContinuation:(id<DKSKotlinContinuation>)continuation __attribute__((swift_name("releaseInterceptedContinuation(continuation:)")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreCoroutineDispatcher")))
@interface DKSKotlinx_coroutines_coreCoroutineDispatcher : DKSKotlinAbstractCoroutineContextElement <DKSKotlinContinuationInterceptor>
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (instancetype)initWithKey:(id<DKSKotlinCoroutineContextKey>)key __attribute__((swift_name("init(key:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly, getter=companion) DKSKotlinx_coroutines_coreCoroutineDispatcherKey *companion __attribute__((swift_name("companion")));
- (void)dispatchContext:(id<DKSKotlinCoroutineContext>)context block:(id<DKSKotlinx_coroutines_coreRunnable>)block __attribute__((swift_name("dispatch(context:block:)")));
- (void)dispatchYieldContext:(id<DKSKotlinCoroutineContext>)context block:(id<DKSKotlinx_coroutines_coreRunnable>)block __attribute__((swift_name("dispatchYield(context:block:)")));
- (id<DKSKotlinContinuation>)interceptContinuationContinuation:(id<DKSKotlinContinuation>)continuation __attribute__((swift_name("interceptContinuation(continuation:)")));
- (BOOL)isDispatchNeededContext:(id<DKSKotlinCoroutineContext>)context __attribute__((swift_name("isDispatchNeeded(context:)")));
- (DKSKotlinx_coroutines_coreCoroutineDispatcher *)plusOther_:(DKSKotlinx_coroutines_coreCoroutineDispatcher *)other __attribute__((swift_name("plus(other_:)"))) __attribute__((unavailable("Operator '+' on two CoroutineDispatcher objects is meaningless. CoroutineDispatcher is a coroutine context element and `+` is a set-sum operator for coroutine contexts. The dispatcher to the right of `+` just replaces the dispatcher to the left.")));
- (void)releaseInterceptedContinuationContinuation:(id<DKSKotlinContinuation>)continuation __attribute__((swift_name("releaseInterceptedContinuation(continuation:)")));
- (NSString *)description __attribute__((swift_name("description()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinUnit")))
@interface DKSKotlinUnit : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)unit __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKotlinUnit *shared __attribute__((swift_name("shared")));
- (NSString *)description __attribute__((swift_name("description()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreFlow")))
@protocol DKSKotlinx_coroutines_coreFlow
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)collectCollector:(id<DKSKotlinx_coroutines_coreFlowCollector>)collector completionHandler:(void (^)(DKSKotlinUnit * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("collect(collector:completionHandler:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinArray")))
@interface DKSKotlinArray<T> : DKSBase
+ (instancetype)arrayWithSize:(int32_t)size init:(T _Nullable (^)(DKSInt *))init __attribute__((swift_name("init(size:init:)")));
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (T _Nullable)getIndex:(int32_t)index __attribute__((swift_name("get(index:)")));
- (id<DKSKotlinIterator>)iterator __attribute__((swift_name("iterator()")));
- (void)setIndex:(int32_t)index value:(T _Nullable)value __attribute__((swift_name("set(index:value:)")));
@property (readonly) int32_t size __attribute__((swift_name("size")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Ktor_httpUrl")))
@interface DKSKtor_httpUrl : DKSBase
- (instancetype)initWithProtocol:(DKSKtor_httpURLProtocol *)protocol host:(NSString *)host specifiedPort:(int32_t)specifiedPort encodedPath:(NSString *)encodedPath parameters:(id<DKSKtor_httpParameters>)parameters fragment:(NSString *)fragment user:(NSString * _Nullable)user password:(NSString * _Nullable)password trailingQuery:(BOOL)trailingQuery __attribute__((swift_name("init(protocol:host:specifiedPort:encodedPath:parameters:fragment:user:password:trailingQuery:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) DKSKtor_httpUrlCompanion *companion __attribute__((swift_name("companion")));
- (DKSKtor_httpURLProtocol *)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (int32_t)component3 __attribute__((swift_name("component3()")));
- (NSString *)component4 __attribute__((swift_name("component4()")));
- (id<DKSKtor_httpParameters>)component5 __attribute__((swift_name("component5()")));
- (NSString *)component6 __attribute__((swift_name("component6()")));
- (NSString * _Nullable)component7 __attribute__((swift_name("component7()")));
- (NSString * _Nullable)component8 __attribute__((swift_name("component8()")));
- (BOOL)component9 __attribute__((swift_name("component9()")));
- (DKSKtor_httpUrl *)doCopyProtocol:(DKSKtor_httpURLProtocol *)protocol host:(NSString *)host specifiedPort:(int32_t)specifiedPort encodedPath:(NSString *)encodedPath parameters:(id<DKSKtor_httpParameters>)parameters fragment:(NSString *)fragment user:(NSString * _Nullable)user password:(NSString * _Nullable)password trailingQuery:(BOOL)trailingQuery __attribute__((swift_name("doCopy(protocol:host:specifiedPort:encodedPath:parameters:fragment:user:password:trailingQuery:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *encodedPath __attribute__((swift_name("encodedPath")));
@property (readonly) NSString *fragment __attribute__((swift_name("fragment")));
@property (readonly) NSString *host __attribute__((swift_name("host")));
@property (readonly) id<DKSKtor_httpParameters> parameters __attribute__((swift_name("parameters")));
@property (readonly) NSString * _Nullable password __attribute__((swift_name("password")));
@property (readonly) int32_t port __attribute__((swift_name("port")));
@property (readonly) DKSKtor_httpURLProtocol *protocol __attribute__((swift_name("protocol")));
@property (readonly) int32_t specifiedPort __attribute__((swift_name("specifiedPort")));
@property (readonly) BOOL trailingQuery __attribute__((swift_name("trailingQuery")));
@property (readonly) NSString * _Nullable user __attribute__((swift_name("user")));
@end;

__attribute__((swift_name("RuntimeQuery")))
@interface DKSRuntimeQuery<__covariant RowType> : DKSBase
- (instancetype)initWithQueries:(NSMutableArray<DKSRuntimeQuery<id> *> *)queries mapper:(RowType (^)(id<DKSRuntimeSqlCursor>))mapper __attribute__((swift_name("init(queries:mapper:)"))) __attribute__((objc_designated_initializer));
- (void)addListenerListener:(id<DKSRuntimeQueryListener>)listener __attribute__((swift_name("addListener(listener:)")));
- (id<DKSRuntimeSqlCursor>)execute __attribute__((swift_name("execute()")));
- (NSArray<RowType> *)executeAsList __attribute__((swift_name("executeAsList()")));
- (RowType)executeAsOne __attribute__((swift_name("executeAsOne()")));
- (RowType _Nullable)executeAsOneOrNull __attribute__((swift_name("executeAsOneOrNull()")));
- (void)notifyDataChanged __attribute__((swift_name("notifyDataChanged()")));
- (void)removeListenerListener:(id<DKSRuntimeQueryListener>)listener __attribute__((swift_name("removeListener(listener:)")));
@property (readonly) RowType (^mapper)(id<DKSRuntimeSqlCursor>) __attribute__((swift_name("mapper")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreScope")))
@interface DKSKoin_coreScope : DKSBase
- (instancetype)initWithScopeQualifier:(id<DKSKoin_coreQualifier>)scopeQualifier id:(NSString *)id isRoot:(BOOL)isRoot _koin:(DKSKoin_coreKoin *)_koin __attribute__((swift_name("init(scopeQualifier:id:isRoot:_koin:)"))) __attribute__((objc_designated_initializer));
- (void)close __attribute__((swift_name("close()")));
- (id<DKSKoin_coreQualifier>)component1 __attribute__((swift_name("component1()")));
- (NSString *)component2 __attribute__((swift_name("component2()")));
- (BOOL)component3 __attribute__((swift_name("component3()")));
- (DKSKoin_coreScope *)doCopyScopeQualifier:(id<DKSKoin_coreQualifier>)scopeQualifier id:(NSString *)id isRoot:(BOOL)isRoot _koin:(DKSKoin_coreKoin *)_koin __attribute__((swift_name("doCopy(scopeQualifier:id:isRoot:_koin:)")));
- (void)declareInstance:(id _Nullable)instance qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier secondaryTypes:(NSArray<id<DKSKotlinKClass>> *)secondaryTypes allowOverride:(BOOL)allowOverride __attribute__((swift_name("declare(instance:qualifier:secondaryTypes:allowOverride:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (id _Nullable)getClazz:(id<DKSKotlinKClass>)clazz qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("get(clazz:qualifier:parameters:)")));
- (id)getQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("get(qualifier:parameters:)")));
- (NSArray<id> *)getAll __attribute__((swift_name("getAll()")));
- (NSArray<id> *)getAllClazz:(id<DKSKotlinKClass>)clazz __attribute__((swift_name("getAll(clazz:)")));
- (DKSKoin_coreKoin *)getKoin __attribute__((swift_name("getKoin()")));
- (id _Nullable)getOrNullClazz:(id<DKSKotlinKClass>)clazz qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("getOrNull(clazz:qualifier:parameters:)")));
- (id _Nullable)getOrNullQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("getOrNull(qualifier:parameters:)")));
- (id)getPropertyKey:(NSString *)key __attribute__((swift_name("getProperty(key:)")));
- (id)getPropertyKey:(NSString *)key defaultValue:(id)defaultValue __attribute__((swift_name("getProperty(key:defaultValue:)")));
- (id _Nullable)getPropertyOrNullKey:(NSString *)key __attribute__((swift_name("getPropertyOrNull(key:)")));
- (DKSKoin_coreScope *)getScopeScopeID:(NSString *)scopeID __attribute__((swift_name("getScope(scopeID:)")));
- (id _Nullable)getSource __attribute__((swift_name("getSource()"))) __attribute__((deprecated("No need to use getSource(). You can an use get() directly.")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (id<DKSKotlinLazy>)injectQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier mode:(DKSKotlinLazyThreadSafetyMode *)mode parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("inject(qualifier:mode:parameters:)")));
- (id<DKSKotlinLazy>)injectOrNullQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier mode:(DKSKotlinLazyThreadSafetyMode *)mode parameters:(DKSKoin_coreParametersHolder *(^ _Nullable)(void))parameters __attribute__((swift_name("injectOrNull(qualifier:mode:parameters:)")));
- (BOOL)isNotClosed __attribute__((swift_name("isNotClosed()")));
- (void)linkToScopes:(DKSKotlinArray<DKSKoin_coreScope *> *)scopes __attribute__((swift_name("linkTo(scopes:)")));
- (void)refreshScopeInstanceClazz:(id<DKSKotlinKClass>)clazz qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier instance:(id)instance __attribute__((swift_name("refreshScopeInstance(clazz:qualifier:instance:)")));
- (void)registerCallbackCallback:(id<DKSKoin_coreScopeCallback>)callback __attribute__((swift_name("registerCallback(callback:)")));
- (NSString *)description __attribute__((swift_name("description()")));
- (void)unlinkScopes:(DKSKotlinArray<DKSKoin_coreScope *> *)scopes __attribute__((swift_name("unlink(scopes:)")));
@property (readonly) NSMutableArray<DKSKoin_coreParametersHolder *> *_parameterStack __attribute__((swift_name("_parameterStack")));
@property id _Nullable _source __attribute__((swift_name("_source")));
@property (readonly) BOOL closed __attribute__((swift_name("closed")));
@property (readonly) NSString *id __attribute__((swift_name("id")));
@property (readonly) BOOL isRoot __attribute__((swift_name("isRoot")));
@property (readonly) DKSKoin_coreLogger *logger __attribute__((swift_name("logger")));
@property (readonly) id<DKSKoin_coreQualifier> scopeQualifier __attribute__((swift_name("scopeQualifier")));
@end;

__attribute__((swift_name("Koin_coreKoinComponent")))
@protocol DKSKoin_coreKoinComponent
@required
- (DKSKoin_coreKoin *)getKoin __attribute__((swift_name("getKoin()")));
@end;

__attribute__((swift_name("Koin_coreKoinScopeComponent")))
@protocol DKSKoin_coreKoinScopeComponent <DKSKoin_coreKoinComponent>
@required
- (void)closeScope __attribute__((swift_name("closeScope()")));
@property (readonly) DKSKoin_coreScope *scope __attribute__((swift_name("scope")));
@end;

__attribute__((swift_name("Koin_coreQualifier")))
@protocol DKSKoin_coreQualifier
@required
@property (readonly) NSString *value __attribute__((swift_name("value")));
@end;

__attribute__((swift_name("KotlinKDeclarationContainer")))
@protocol DKSKotlinKDeclarationContainer
@required
@end;

__attribute__((swift_name("KotlinKAnnotatedElement")))
@protocol DKSKotlinKAnnotatedElement
@required
@end;

__attribute__((swift_name("KotlinKClassifier")))
@protocol DKSKotlinKClassifier
@required
@end;

__attribute__((swift_name("KotlinKClass")))
@protocol DKSKotlinKClass <DKSKotlinKDeclarationContainer, DKSKotlinKAnnotatedElement, DKSKotlinKClassifier>
@required
- (BOOL)isInstanceValue:(id _Nullable)value __attribute__((swift_name("isInstance(value:)")));
@property (readonly) NSString * _Nullable qualifiedName __attribute__((swift_name("qualifiedName")));
@property (readonly) NSString * _Nullable simpleName __attribute__((swift_name("simpleName")));
@end;

__attribute__((swift_name("Koin_coreParametersHolder")))
@interface DKSKoin_coreParametersHolder : DKSBase
- (instancetype)initWith_values:(NSMutableArray<id> *)_values __attribute__((swift_name("init(_values:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) DKSKoin_coreParametersHolderCompanion *companion __attribute__((swift_name("companion")));
- (DKSKoin_coreParametersHolder *)addValue:(id)value __attribute__((swift_name("add(value:)")));
- (id _Nullable)component1 __attribute__((swift_name("component1()")));
- (id _Nullable)component2 __attribute__((swift_name("component2()")));
- (id _Nullable)component3 __attribute__((swift_name("component3()")));
- (id _Nullable)component4 __attribute__((swift_name("component4()")));
- (id _Nullable)component5 __attribute__((swift_name("component5()")));
- (id _Nullable)elementAtI:(int32_t)i clazz:(id<DKSKotlinKClass>)clazz __attribute__((swift_name("elementAt(i:clazz:)")));
- (id)get __attribute__((swift_name("get()")));
- (id _Nullable)getI:(int32_t)i __attribute__((swift_name("get(i:)")));
- (id _Nullable)getOrNull __attribute__((swift_name("getOrNull()")));
- (id _Nullable)getOrNullClazz:(id<DKSKotlinKClass>)clazz __attribute__((swift_name("getOrNull(clazz:)")));
- (DKSKoin_coreParametersHolder *)insertIndex:(int32_t)index value:(id)value __attribute__((swift_name("insert(index:value:)")));
- (BOOL)isEmpty __attribute__((swift_name("isEmpty()")));
- (BOOL)isNotEmpty __attribute__((swift_name("isNotEmpty()")));
- (void)setI:(int32_t)i t:(id _Nullable)t __attribute__((swift_name("set(i:t:)")));
- (int32_t)size __attribute__((swift_name("size()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSArray<id> *values __attribute__((swift_name("values")));
@end;

__attribute__((swift_name("KotlinLazy")))
@protocol DKSKotlinLazy
@required
- (BOOL)isInitialized __attribute__((swift_name("isInitialized()")));
@property (readonly) id _Nullable value __attribute__((swift_name("value")));
@end;

__attribute__((swift_name("KotlinComparable")))
@protocol DKSKotlinComparable
@required
- (int32_t)compareToOther:(id _Nullable)other __attribute__((swift_name("compareTo(other:)")));
@end;

__attribute__((swift_name("KotlinEnum")))
@interface DKSKotlinEnum<E> : DKSBase <DKSKotlinComparable>
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) DKSKotlinEnumCompanion *companion __attribute__((swift_name("companion")));
- (int32_t)compareToOther:(E)other __attribute__((swift_name("compareTo(other:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@property (readonly) int32_t ordinal __attribute__((swift_name("ordinal")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinLazyThreadSafetyMode")))
@interface DKSKotlinLazyThreadSafetyMode : DKSKotlinEnum<DKSKotlinLazyThreadSafetyMode *>
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly) DKSKotlinLazyThreadSafetyMode *synchronized __attribute__((swift_name("synchronized")));
@property (class, readonly) DKSKotlinLazyThreadSafetyMode *publication __attribute__((swift_name("publication")));
@property (class, readonly) DKSKotlinLazyThreadSafetyMode *none __attribute__((swift_name("none")));
+ (DKSKotlinArray<DKSKotlinLazyThreadSafetyMode *> *)values __attribute__((swift_name("values()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreModule")))
@interface DKSKoin_coreModule : DKSBase
- (instancetype)initWithCreatedAtStart:(BOOL)createdAtStart __attribute__((swift_name("init(createdAtStart:)"))) __attribute__((objc_designated_initializer));
- (DKSKotlinPair<DKSKoin_coreModule *, DKSKoin_coreInstanceFactory<id> *> *)factoryQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier definition:(id _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition __attribute__((swift_name("factory(qualifier:definition:)")));
- (NSArray<DKSKoin_coreModule *> *)plusModules:(NSArray<DKSKoin_coreModule *> *)modules __attribute__((swift_name("plus(modules:)")));
- (NSArray<DKSKoin_coreModule *> *)plusModule:(DKSKoin_coreModule *)module __attribute__((swift_name("plus(module:)")));
- (void)scopeQualifier:(id<DKSKoin_coreQualifier>)qualifier scopeSet:(void (^)(DKSKoin_coreScopeDSL *))scopeSet __attribute__((swift_name("scope(qualifier:scopeSet:)")));
- (void)scopeScopeSet:(void (^)(DKSKoin_coreScopeDSL *))scopeSet __attribute__((swift_name("scope(scopeSet:)")));
- (DKSKotlinPair<DKSKoin_coreModule *, DKSKoin_coreInstanceFactory<id> *> *)singleQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier createdAtStart:(BOOL)createdAtStart definition:(id _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition __attribute__((swift_name("single(qualifier:createdAtStart:definition:)")));
@property (readonly) BOOL createdAtStart __attribute__((swift_name("createdAtStart")));
@property (readonly) DKSMutableSet<DKSKoin_coreSingleInstanceFactory<id> *> *eagerInstances __attribute__((swift_name("eagerInstances")));
@property (readonly) BOOL isLoaded __attribute__((swift_name("isLoaded")));
@end;

__attribute__((swift_name("Koin_coreLogger")))
@interface DKSKoin_coreLogger : DKSBase
- (instancetype)initWithLevel:(DKSKoin_coreLevel *)level __attribute__((swift_name("init(level:)"))) __attribute__((objc_designated_initializer));
- (void)debugMsg:(NSString *)msg __attribute__((swift_name("debug(msg:)")));
- (void)errorMsg:(NSString *)msg __attribute__((swift_name("error(msg:)")));
- (void)infoMsg:(NSString *)msg __attribute__((swift_name("info(msg:)")));
- (BOOL)isAtLvl:(DKSKoin_coreLevel *)lvl __attribute__((swift_name("isAt(lvl:)")));
- (void)logLvl:(DKSKoin_coreLevel *)lvl msg:(NSString *(^)(void))msg __attribute__((swift_name("log(lvl:msg:)")));
- (void)logLevel:(DKSKoin_coreLevel *)level msg:(NSString *)msg __attribute__((swift_name("log(level:msg:)")));
@property DKSKoin_coreLevel *level __attribute__((swift_name("level")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreInstanceRegistry")))
@interface DKSKoin_coreInstanceRegistry : DKSBase
- (instancetype)initWith_koin:(DKSKoin_coreKoin *)_koin __attribute__((swift_name("init(_koin:)"))) __attribute__((objc_designated_initializer));
- (void)saveMappingAllowOverride:(BOOL)allowOverride mapping:(NSString *)mapping factory:(DKSKoin_coreInstanceFactory<id> *)factory logWarning:(BOOL)logWarning __attribute__((swift_name("saveMapping(allowOverride:mapping:factory:logWarning:)")));
- (int32_t)size __attribute__((swift_name("size()")));
@property (readonly) DKSKoin_coreKoin *_koin __attribute__((swift_name("_koin")));
@property (readonly) NSDictionary<NSString *, DKSKoin_coreInstanceFactory<id> *> *instances __attribute__((swift_name("instances")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_corePropertyRegistry")))
@interface DKSKoin_corePropertyRegistry : DKSBase
- (instancetype)initWith_koin:(DKSKoin_coreKoin *)_koin __attribute__((swift_name("init(_koin:)"))) __attribute__((objc_designated_initializer));
- (void)close __attribute__((swift_name("close()")));
- (void)deletePropertyKey:(NSString *)key __attribute__((swift_name("deleteProperty(key:)")));
- (id _Nullable)getPropertyKey:(NSString *)key __attribute__((swift_name("getProperty(key:)")));
- (void)savePropertiesProperties:(NSDictionary<NSString *, id> *)properties __attribute__((swift_name("saveProperties(properties:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreScopeRegistry")))
@interface DKSKoin_coreScopeRegistry : DKSBase
- (instancetype)initWith_koin:(DKSKoin_coreKoin *)_koin __attribute__((swift_name("init(_koin:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) DKSKoin_coreScopeRegistryCompanion *companion __attribute__((swift_name("companion")));
- (void)loadScopesModules:(NSArray<DKSKoin_coreModule *> *)modules __attribute__((swift_name("loadScopes(modules:)")));
@property (readonly) DKSKoin_coreScope *rootScope __attribute__((swift_name("rootScope")));
@property (readonly) NSSet<id<DKSKoin_coreQualifier>> *scopeDefinitions __attribute__((swift_name("scopeDefinitions")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreCoroutineScope")))
@protocol DKSKotlinx_coroutines_coreCoroutineScope
@required
@property (readonly) id<DKSKotlinCoroutineContext> coroutineContext __attribute__((swift_name("coroutineContext")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreKoinApplication")))
@interface DKSKoin_coreKoinApplication : DKSBase
@property (class, readonly, getter=companion) DKSKoin_coreKoinApplicationCompanion *companion __attribute__((swift_name("companion")));
- (void)allowOverrideOverride:(BOOL)override __attribute__((swift_name("allowOverride(override:)")));
- (void)close __attribute__((swift_name("close()")));
- (DKSKoin_coreKoinApplication *)loggerLogger:(DKSKoin_coreLogger *)logger __attribute__((swift_name("logger(logger:)")));
- (DKSKoin_coreKoinApplication *)modulesModules:(DKSKotlinArray<DKSKoin_coreModule *> *)modules __attribute__((swift_name("modules(modules:)")));
- (DKSKoin_coreKoinApplication *)modulesModules_:(NSArray<DKSKoin_coreModule *> *)modules __attribute__((swift_name("modules(modules_:)")));
- (DKSKoin_coreKoinApplication *)modulesModules__:(DKSKoin_coreModule *)modules __attribute__((swift_name("modules(modules__:)")));
- (DKSKoin_coreKoinApplication *)printLoggerLevel:(DKSKoin_coreLevel *)level __attribute__((swift_name("printLogger(level:)")));
- (DKSKoin_coreKoinApplication *)propertiesValues:(NSDictionary<NSString *, NSString *> *)values __attribute__((swift_name("properties(values:)")));
- (void)unloadModulesModules:(NSArray<DKSKoin_coreModule *> *)modules __attribute__((swift_name("unloadModules(modules:)")));
- (void)unloadModulesModule:(DKSKoin_coreModule *)module __attribute__((swift_name("unloadModules(module:)")));
@property (readonly) DKSKoin_coreKoin *koin __attribute__((swift_name("koin")));
@end;

__attribute__((swift_name("RuntimeTransacterTransaction")))
@interface DKSRuntimeTransacterTransaction : DKSBase <DKSRuntimeTransactionCallbacks>
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)afterCommitFunction:(void (^)(void))function __attribute__((swift_name("afterCommit(function:)")));
- (void)afterRollbackFunction:(void (^)(void))function __attribute__((swift_name("afterRollback(function:)")));
- (void)endTransactionSuccessful:(BOOL)successful __attribute__((swift_name("endTransaction(successful:)")));
@property (readonly) DKSRuntimeTransacterTransaction * _Nullable enclosingTransaction __attribute__((swift_name("enclosingTransaction")));
@end;

__attribute__((swift_name("RuntimeSqlPreparedStatement")))
@protocol DKSRuntimeSqlPreparedStatement
@required
- (void)bindBytesIndex:(int32_t)index bytes:(DKSKotlinByteArray * _Nullable)bytes __attribute__((swift_name("bindBytes(index:bytes:)")));
- (void)bindDoubleIndex:(int32_t)index double:(DKSDouble * _Nullable)double_ __attribute__((swift_name("bindDouble(index:double:)")));
- (void)bindLongIndex:(int32_t)index long:(DKSLong * _Nullable)long_ __attribute__((swift_name("bindLong(index:long:)")));
- (void)bindStringIndex:(int32_t)index string:(NSString * _Nullable)string __attribute__((swift_name("bindString(index:string:)")));
@end;

__attribute__((swift_name("RuntimeSqlCursor")))
@protocol DKSRuntimeSqlCursor <DKSRuntimeCloseable>
@required
- (DKSKotlinByteArray * _Nullable)getBytesIndex:(int32_t)index __attribute__((swift_name("getBytes(index:)")));
- (DKSDouble * _Nullable)getDoubleIndex:(int32_t)index __attribute__((swift_name("getDouble(index:)")));
- (DKSLong * _Nullable)getLongIndex:(int32_t)index __attribute__((swift_name("getLong(index:)")));
- (NSString * _Nullable)getStringIndex:(int32_t)index __attribute__((swift_name("getString(index:)")));
- (BOOL)next __attribute__((swift_name("next()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreDisposableHandle")))
@protocol DKSKotlinx_coroutines_coreDisposableHandle
@required
- (void)dispose __attribute__((swift_name("dispose()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreChildHandle")))
@protocol DKSKotlinx_coroutines_coreChildHandle <DKSKotlinx_coroutines_coreDisposableHandle>
@required
- (BOOL)childCancelledCause:(DKSKotlinThrowable *)cause __attribute__((swift_name("childCancelled(cause:)")));
@property (readonly) id<DKSKotlinx_coroutines_coreJob> _Nullable parent __attribute__((swift_name("parent")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreChildJob")))
@protocol DKSKotlinx_coroutines_coreChildJob <DKSKotlinx_coroutines_coreJob>
@required
- (void)parentCancelledParentJob:(id<DKSKotlinx_coroutines_coreParentJob>)parentJob __attribute__((swift_name("parentCancelled(parentJob:)")));
@end;

__attribute__((swift_name("KotlinSequence")))
@protocol DKSKotlinSequence
@required
- (id<DKSKotlinIterator>)iterator __attribute__((swift_name("iterator()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreSelectClause0")))
@protocol DKSKotlinx_coroutines_coreSelectClause0
@required
- (void)registerSelectClause0Select:(id<DKSKotlinx_coroutines_coreSelectInstance>)select block:(id<DKSKotlinSuspendFunction0>)block __attribute__((swift_name("registerSelectClause0(select:block:)")));
@end;

__attribute__((swift_name("KotlinCoroutineContextKey")))
@protocol DKSKotlinCoroutineContextKey
@required
@end;

__attribute__((swift_name("KotlinContinuation")))
@protocol DKSKotlinContinuation
@required
- (void)resumeWithResult:(id _Nullable)result __attribute__((swift_name("resumeWith(result:)")));
@property (readonly) id<DKSKotlinCoroutineContext> context __attribute__((swift_name("context")));
@end;

__attribute__((swift_name("KotlinAbstractCoroutineContextKey")))
@interface DKSKotlinAbstractCoroutineContextKey<B, E> : DKSBase <DKSKotlinCoroutineContextKey>
- (instancetype)initWithBaseKey:(id<DKSKotlinCoroutineContextKey>)baseKey safeCast:(E _Nullable (^)(id<DKSKotlinCoroutineContextElement>))safeCast __attribute__((swift_name("init(baseKey:safeCast:)"))) __attribute__((objc_designated_initializer));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Kotlinx_coroutines_coreCoroutineDispatcher.Key")))
@interface DKSKotlinx_coroutines_coreCoroutineDispatcherKey : DKSKotlinAbstractCoroutineContextKey<id<DKSKotlinContinuationInterceptor>, DKSKotlinx_coroutines_coreCoroutineDispatcher *>
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithBaseKey:(id<DKSKotlinCoroutineContextKey>)baseKey safeCast:(id<DKSKotlinCoroutineContextElement> _Nullable (^)(id<DKSKotlinCoroutineContextElement>))safeCast __attribute__((swift_name("init(baseKey:safeCast:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)key __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKotlinx_coroutines_coreCoroutineDispatcherKey *shared __attribute__((swift_name("shared")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreRunnable")))
@protocol DKSKotlinx_coroutines_coreRunnable
@required
- (void)run __attribute__((swift_name("run()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreFlowCollector")))
@protocol DKSKotlinx_coroutines_coreFlowCollector
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)emitValue:(id _Nullable)value completionHandler:(void (^)(DKSKotlinUnit * _Nullable, NSError * _Nullable))completionHandler __attribute__((swift_name("emit(value:completionHandler:)")));
@end;

__attribute__((swift_name("KotlinIterator")))
@protocol DKSKotlinIterator
@required
- (BOOL)hasNext __attribute__((swift_name("hasNext()")));
- (id _Nullable)next_ __attribute__((swift_name("next_()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Ktor_httpURLProtocol")))
@interface DKSKtor_httpURLProtocol : DKSBase
- (instancetype)initWithName:(NSString *)name defaultPort:(int32_t)defaultPort __attribute__((swift_name("init(name:defaultPort:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) DKSKtor_httpURLProtocolCompanion *companion __attribute__((swift_name("companion")));
- (NSString *)component1 __attribute__((swift_name("component1()")));
- (int32_t)component2 __attribute__((swift_name("component2()")));
- (DKSKtor_httpURLProtocol *)doCopyName:(NSString *)name defaultPort:(int32_t)defaultPort __attribute__((swift_name("doCopy(name:defaultPort:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) int32_t defaultPort __attribute__((swift_name("defaultPort")));
@property (readonly) NSString *name __attribute__((swift_name("name")));
@end;

__attribute__((swift_name("Ktor_utilsStringValues")))
@protocol DKSKtor_utilsStringValues
@required
- (BOOL)containsName:(NSString *)name __attribute__((swift_name("contains(name:)")));
- (BOOL)containsName:(NSString *)name value:(NSString *)value __attribute__((swift_name("contains(name:value:)")));
- (NSSet<id<DKSKotlinMapEntry>> *)entries __attribute__((swift_name("entries()")));
- (void)forEachBody:(void (^)(NSString *, NSArray<NSString *> *))body __attribute__((swift_name("forEach(body:)")));
- (NSString * _Nullable)getName:(NSString *)name __attribute__((swift_name("get(name:)")));
- (NSArray<NSString *> * _Nullable)getAllName:(NSString *)name __attribute__((swift_name("getAll(name:)")));
- (BOOL)isEmpty __attribute__((swift_name("isEmpty()")));
- (NSSet<NSString *> *)names __attribute__((swift_name("names()")));
@property (readonly) BOOL caseInsensitiveName __attribute__((swift_name("caseInsensitiveName")));
@end;

__attribute__((swift_name("Ktor_httpParameters")))
@protocol DKSKtor_httpParameters <DKSKtor_utilsStringValues>
@required
@property (readonly) DKSKtor_httpUrlEncodingOption *urlEncodingOption __attribute__((swift_name("urlEncodingOption")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Ktor_httpUrl.Companion")))
@interface DKSKtor_httpUrlCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKtor_httpUrlCompanion *shared __attribute__((swift_name("shared")));
@end;

__attribute__((swift_name("RuntimeQueryListener")))
@protocol DKSRuntimeQueryListener
@required
- (void)queryResultsChanged __attribute__((swift_name("queryResultsChanged()")));
@end;

__attribute__((swift_name("Koin_coreScopeCallback")))
@protocol DKSKoin_coreScopeCallback
@required
- (void)onScopeCloseScope:(DKSKoin_coreScope *)scope __attribute__((swift_name("onScopeClose(scope:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreParametersHolder.Companion")))
@interface DKSKoin_coreParametersHolderCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKoin_coreParametersHolderCompanion *shared __attribute__((swift_name("shared")));
@property (readonly) int32_t MAX_PARAMS __attribute__((swift_name("MAX_PARAMS")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinEnumCompanion")))
@interface DKSKotlinEnumCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKotlinEnumCompanion *shared __attribute__((swift_name("shared")));
@end;

__attribute__((swift_name("Koin_coreInstanceFactory")))
@interface DKSKoin_coreInstanceFactory<T> : DKSBase
- (instancetype)initWithBeanDefinition:(DKSKoin_coreBeanDefinition<T> *)beanDefinition __attribute__((swift_name("init(beanDefinition:)"))) __attribute__((objc_designated_initializer));
@property (class, readonly, getter=companion) DKSKoin_coreInstanceFactoryCompanion *companion __attribute__((swift_name("companion")));
- (T _Nullable)createContext:(DKSKoin_coreInstanceContext *)context __attribute__((swift_name("create(context:)")));
- (void)dropScope:(DKSKoin_coreScope * _Nullable)scope __attribute__((swift_name("drop(scope:)")));
- (void)dropAll __attribute__((swift_name("dropAll()")));
- (T _Nullable)getContext:(DKSKoin_coreInstanceContext *)context __attribute__((swift_name("get(context:)")));
- (BOOL)isCreatedContext:(DKSKoin_coreInstanceContext * _Nullable)context __attribute__((swift_name("isCreated(context:)")));
@property (readonly) DKSKoin_coreBeanDefinition<T> *beanDefinition __attribute__((swift_name("beanDefinition")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinPair")))
@interface DKSKotlinPair<__covariant A, __covariant B> : DKSBase
- (instancetype)initWithFirst:(A _Nullable)first second:(B _Nullable)second __attribute__((swift_name("init(first:second:)"))) __attribute__((objc_designated_initializer));
- (A _Nullable)component1 __attribute__((swift_name("component1()")));
- (B _Nullable)component2 __attribute__((swift_name("component2()")));
- (DKSKotlinPair<A, B> *)doCopyFirst:(A _Nullable)first second:(B _Nullable)second __attribute__((swift_name("doCopy(first:second:)")));
- (BOOL)equalsOther:(id _Nullable)other __attribute__((swift_name("equals(other:)")));
- (int32_t)hashCode __attribute__((swift_name("hashCode()")));
- (NSString *)toString __attribute__((swift_name("toString()")));
@property (readonly) A _Nullable first __attribute__((swift_name("first")));
@property (readonly) B _Nullable second __attribute__((swift_name("second")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreScopeDSL")))
@interface DKSKoin_coreScopeDSL : DKSBase
- (instancetype)initWithScopeQualifier:(id<DKSKoin_coreQualifier>)scopeQualifier module:(DKSKoin_coreModule *)module __attribute__((swift_name("init(scopeQualifier:module:)"))) __attribute__((objc_designated_initializer));
- (DKSKotlinPair<DKSKoin_coreModule *, DKSKoin_coreInstanceFactory<id> *> *)factoryQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier definition:(id _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition __attribute__((swift_name("factory(qualifier:definition:)")));
- (DKSKotlinPair<DKSKoin_coreModule *, DKSKoin_coreInstanceFactory<id> *> *)scopedQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier definition:(id _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition __attribute__((swift_name("scoped(qualifier:definition:)")));
- (DKSKotlinPair<DKSKoin_coreModule *, DKSKoin_coreInstanceFactory<id> *> *)singleQualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier definition:(id _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition __attribute__((swift_name("single(qualifier:definition:)"))) __attribute__((unavailable("Can't use Single in a scope. Use Scoped instead")));
@property (readonly) DKSKoin_coreModule *module __attribute__((swift_name("module")));
@property (readonly) id<DKSKoin_coreQualifier> scopeQualifier __attribute__((swift_name("scopeQualifier")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreSingleInstanceFactory")))
@interface DKSKoin_coreSingleInstanceFactory<T> : DKSKoin_coreInstanceFactory<T>
- (instancetype)initWithBeanDefinition:(DKSKoin_coreBeanDefinition<T> *)beanDefinition __attribute__((swift_name("init(beanDefinition:)"))) __attribute__((objc_designated_initializer));
- (T _Nullable)createContext:(DKSKoin_coreInstanceContext *)context __attribute__((swift_name("create(context:)")));
- (void)dropScope:(DKSKoin_coreScope * _Nullable)scope __attribute__((swift_name("drop(scope:)")));
- (void)dropAll __attribute__((swift_name("dropAll()")));
- (T _Nullable)getContext:(DKSKoin_coreInstanceContext *)context __attribute__((swift_name("get(context:)")));
- (BOOL)isCreatedContext:(DKSKoin_coreInstanceContext * _Nullable)context __attribute__((swift_name("isCreated(context:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreLevel")))
@interface DKSKoin_coreLevel : DKSKotlinEnum<DKSKoin_coreLevel *>
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly) DKSKoin_coreLevel *debug __attribute__((swift_name("debug")));
@property (class, readonly) DKSKoin_coreLevel *info __attribute__((swift_name("info")));
@property (class, readonly) DKSKoin_coreLevel *error __attribute__((swift_name("error")));
@property (class, readonly) DKSKoin_coreLevel *none __attribute__((swift_name("none")));
+ (DKSKotlinArray<DKSKoin_coreLevel *> *)values __attribute__((swift_name("values()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreScopeRegistry.Companion")))
@interface DKSKoin_coreScopeRegistryCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKoin_coreScopeRegistryCompanion *shared __attribute__((swift_name("shared")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreKoinApplication.Companion")))
@interface DKSKoin_coreKoinApplicationCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKoin_coreKoinApplicationCompanion *shared __attribute__((swift_name("shared")));
- (DKSKoin_coreKoinApplication *)doInit __attribute__((swift_name("doInit()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("KotlinByteArray")))
@interface DKSKotlinByteArray : DKSBase
+ (instancetype)arrayWithSize:(int32_t)size __attribute__((swift_name("init(size:)")));
+ (instancetype)arrayWithSize:(int32_t)size init:(DKSByte *(^)(DKSInt *))init __attribute__((swift_name("init(size:init:)")));
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (int8_t)getIndex:(int32_t)index __attribute__((swift_name("get(index:)")));
- (DKSKotlinByteIterator *)iterator __attribute__((swift_name("iterator()")));
- (void)setIndex:(int32_t)index value:(int8_t)value __attribute__((swift_name("set(index:value:)")));
@property (readonly) int32_t size __attribute__((swift_name("size")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreParentJob")))
@protocol DKSKotlinx_coroutines_coreParentJob <DKSKotlinx_coroutines_coreJob>
@required
- (DKSKotlinCancellationException *)getChildJobCancellationCause __attribute__((swift_name("getChildJobCancellationCause()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreSelectInstance")))
@protocol DKSKotlinx_coroutines_coreSelectInstance
@required
- (void)disposeOnSelectHandle:(id<DKSKotlinx_coroutines_coreDisposableHandle>)handle __attribute__((swift_name("disposeOnSelect(handle:)")));
- (id _Nullable)performAtomicTrySelectDesc:(DKSKotlinx_coroutines_coreAtomicDesc *)desc __attribute__((swift_name("performAtomicTrySelect(desc:)")));
- (void)resumeSelectWithExceptionException:(DKSKotlinThrowable *)exception __attribute__((swift_name("resumeSelectWithException(exception:)")));
- (BOOL)trySelect __attribute__((swift_name("trySelect()")));
- (id _Nullable)trySelectOtherOtherOp:(DKSKotlinx_coroutines_corePrepareOp * _Nullable)otherOp __attribute__((swift_name("trySelectOther(otherOp:)")));
@property (readonly) id<DKSKotlinContinuation> completion __attribute__((swift_name("completion")));
@property (readonly) BOOL isSelected __attribute__((swift_name("isSelected")));
@end;

__attribute__((swift_name("KotlinSuspendFunction0")))
@protocol DKSKotlinSuspendFunction0 <DKSKotlinFunction>
@required

/**
 @note This method converts instances of CancellationException to errors.
 Other uncaught Kotlin exceptions are fatal.
*/
- (void)invokeWithCompletionHandler:(void (^)(id _Nullable_result, NSError * _Nullable))completionHandler __attribute__((swift_name("invoke(completionHandler:)")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Ktor_httpURLProtocol.Companion")))
@interface DKSKtor_httpURLProtocolCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKtor_httpURLProtocolCompanion *shared __attribute__((swift_name("shared")));
- (DKSKtor_httpURLProtocol *)createOrDefaultName:(NSString *)name __attribute__((swift_name("createOrDefault(name:)")));
@property (readonly) DKSKtor_httpURLProtocol *HTTP __attribute__((swift_name("HTTP")));
@property (readonly) DKSKtor_httpURLProtocol *HTTPS __attribute__((swift_name("HTTPS")));
@property (readonly) DKSKtor_httpURLProtocol *SOCKS __attribute__((swift_name("SOCKS")));
@property (readonly) DKSKtor_httpURLProtocol *WS __attribute__((swift_name("WS")));
@property (readonly) DKSKtor_httpURLProtocol *WSS __attribute__((swift_name("WSS")));
@property (readonly) NSDictionary<NSString *, DKSKtor_httpURLProtocol *> *byName __attribute__((swift_name("byName")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Ktor_httpUrlEncodingOption")))
@interface DKSKtor_httpUrlEncodingOption : DKSKotlinEnum<DKSKtor_httpUrlEncodingOption *>
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly) DKSKtor_httpUrlEncodingOption *default_ __attribute__((swift_name("default_")));
@property (class, readonly) DKSKtor_httpUrlEncodingOption *keyOnly __attribute__((swift_name("keyOnly")));
@property (class, readonly) DKSKtor_httpUrlEncodingOption *valueOnly __attribute__((swift_name("valueOnly")));
@property (class, readonly) DKSKtor_httpUrlEncodingOption *noEncoding __attribute__((swift_name("noEncoding")));
+ (DKSKotlinArray<DKSKtor_httpUrlEncodingOption *> *)values __attribute__((swift_name("values()")));
@end;

__attribute__((swift_name("KotlinMapEntry")))
@protocol DKSKotlinMapEntry
@required
@property (readonly) id _Nullable key __attribute__((swift_name("key")));
@property (readonly) id _Nullable value __attribute__((swift_name("value")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreBeanDefinition")))
@interface DKSKoin_coreBeanDefinition<T> : DKSBase
- (instancetype)initWithScopeQualifier:(id<DKSKoin_coreQualifier>)scopeQualifier primaryType:(id<DKSKotlinKClass>)primaryType qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier definition:(T _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition kind:(DKSKoin_coreKind *)kind secondaryTypes:(NSArray<id<DKSKotlinKClass>> *)secondaryTypes __attribute__((swift_name("init(scopeQualifier:primaryType:qualifier:definition:kind:secondaryTypes:)"))) __attribute__((objc_designated_initializer));
- (id<DKSKoin_coreQualifier>)component1 __attribute__((swift_name("component1()")));
- (id<DKSKotlinKClass>)component2 __attribute__((swift_name("component2()")));
- (id<DKSKoin_coreQualifier> _Nullable)component3 __attribute__((swift_name("component3()")));
- (T _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))component4 __attribute__((swift_name("component4()")));
- (DKSKoin_coreKind *)component5 __attribute__((swift_name("component5()")));
- (NSArray<id<DKSKotlinKClass>> *)component6 __attribute__((swift_name("component6()")));
- (DKSKoin_coreBeanDefinition<T> *)doCopyScopeQualifier:(id<DKSKoin_coreQualifier>)scopeQualifier primaryType:(id<DKSKotlinKClass>)primaryType qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier definition:(T _Nullable (^)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *))definition kind:(DKSKoin_coreKind *)kind secondaryTypes:(NSArray<id<DKSKotlinKClass>> *)secondaryTypes __attribute__((swift_name("doCopy(scopeQualifier:primaryType:qualifier:definition:kind:secondaryTypes:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (BOOL)hasTypeClazz:(id<DKSKotlinKClass>)clazz __attribute__((swift_name("hasType(clazz:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (BOOL)isClazz:(id<DKSKotlinKClass>)clazz qualifier:(id<DKSKoin_coreQualifier> _Nullable)qualifier scopeDefinition:(id<DKSKoin_coreQualifier>)scopeDefinition __attribute__((swift_name("is(clazz:qualifier:scopeDefinition:)")));
- (NSString *)description __attribute__((swift_name("description()")));
@property DKSKoin_coreCallbacks<T> *callbacks __attribute__((swift_name("callbacks")));
@property (readonly) T _Nullable (^definition)(DKSKoin_coreScope *, DKSKoin_coreParametersHolder *) __attribute__((swift_name("definition")));
@property (readonly) DKSKoin_coreKind *kind __attribute__((swift_name("kind")));
@property (readonly) id<DKSKotlinKClass> primaryType __attribute__((swift_name("primaryType")));
@property (readonly) id<DKSKoin_coreQualifier> _Nullable qualifier __attribute__((swift_name("qualifier")));
@property (readonly) id<DKSKoin_coreQualifier> scopeQualifier __attribute__((swift_name("scopeQualifier")));
@property NSArray<id<DKSKotlinKClass>> *secondaryTypes __attribute__((swift_name("secondaryTypes")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreInstanceFactoryCompanion")))
@interface DKSKoin_coreInstanceFactoryCompanion : DKSBase
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
+ (instancetype)companion __attribute__((swift_name("init()")));
@property (class, readonly, getter=shared) DKSKoin_coreInstanceFactoryCompanion *shared __attribute__((swift_name("shared")));
@property (readonly) NSString *ERROR_SEPARATOR __attribute__((swift_name("ERROR_SEPARATOR")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreInstanceContext")))
@interface DKSKoin_coreInstanceContext : DKSBase
- (instancetype)initWithKoin:(DKSKoin_coreKoin *)koin scope:(DKSKoin_coreScope *)scope parameters:(DKSKoin_coreParametersHolder * _Nullable)parameters __attribute__((swift_name("init(koin:scope:parameters:)"))) __attribute__((objc_designated_initializer));
@property (readonly) DKSKoin_coreKoin *koin __attribute__((swift_name("koin")));
@property (readonly) DKSKoin_coreParametersHolder * _Nullable parameters __attribute__((swift_name("parameters")));
@property (readonly) DKSKoin_coreScope *scope __attribute__((swift_name("scope")));
@end;

__attribute__((swift_name("KotlinByteIterator")))
@interface DKSKotlinByteIterator : DKSBase <DKSKotlinIterator>
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (DKSByte *)next_ __attribute__((swift_name("next_()")));
- (int8_t)nextByte __attribute__((swift_name("nextByte()")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreAtomicDesc")))
@interface DKSKotlinx_coroutines_coreAtomicDesc : DKSBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)completeOp:(DKSKotlinx_coroutines_coreAtomicOp<id> *)op failure:(id _Nullable)failure __attribute__((swift_name("complete(op:failure:)")));
- (id _Nullable)prepareOp:(DKSKotlinx_coroutines_coreAtomicOp<id> *)op __attribute__((swift_name("prepare(op:)")));
@property DKSKotlinx_coroutines_coreAtomicOp<id> *atomicOp __attribute__((swift_name("atomicOp")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreOpDescriptor")))
@interface DKSKotlinx_coroutines_coreOpDescriptor : DKSBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (BOOL)isEarlierThanThat:(DKSKotlinx_coroutines_coreOpDescriptor *)that __attribute__((swift_name("isEarlierThan(that:)")));
- (id _Nullable)performAffected:(id _Nullable)affected __attribute__((swift_name("perform(affected:)")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) DKSKotlinx_coroutines_coreAtomicOp<id> * _Nullable atomicOp __attribute__((swift_name("atomicOp")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Kotlinx_coroutines_corePrepareOp")))
@interface DKSKotlinx_coroutines_corePrepareOp : DKSKotlinx_coroutines_coreOpDescriptor
- (instancetype)initWithAffected:(DKSKotlinx_coroutines_coreLinkedListNode *)affected desc:(DKSKotlinx_coroutines_coreAbstractAtomicDesc *)desc atomicOp:(DKSKotlinx_coroutines_coreAtomicOp<id> *)atomicOp __attribute__((swift_name("init(affected:desc:atomicOp:)"))) __attribute__((objc_designated_initializer));
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
+ (instancetype)new __attribute__((unavailable));
- (void)finishPrepare __attribute__((swift_name("finishPrepare()")));
- (id _Nullable)performAffected:(id _Nullable)affected __attribute__((swift_name("perform(affected:)")));
@property (readonly) DKSKotlinx_coroutines_coreLinkedListNode *affected __attribute__((swift_name("affected")));
@property (readonly) DKSKotlinx_coroutines_coreAtomicOp<id> *atomicOp __attribute__((swift_name("atomicOp")));
@property (readonly) DKSKotlinx_coroutines_coreAbstractAtomicDesc *desc __attribute__((swift_name("desc")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreKind")))
@interface DKSKoin_coreKind : DKSKotlinEnum<DKSKoin_coreKind *>
+ (instancetype)alloc __attribute__((unavailable));
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable));
- (instancetype)initWithName:(NSString *)name ordinal:(int32_t)ordinal __attribute__((swift_name("init(name:ordinal:)"))) __attribute__((objc_designated_initializer)) __attribute__((unavailable));
@property (class, readonly) DKSKoin_coreKind *singleton __attribute__((swift_name("singleton")));
@property (class, readonly) DKSKoin_coreKind *factory __attribute__((swift_name("factory")));
@property (class, readonly) DKSKoin_coreKind *scoped __attribute__((swift_name("scoped")));
+ (DKSKotlinArray<DKSKoin_coreKind *> *)values __attribute__((swift_name("values()")));
@end;

__attribute__((objc_subclassing_restricted))
__attribute__((swift_name("Koin_coreCallbacks")))
@interface DKSKoin_coreCallbacks<T> : DKSBase
- (instancetype)initWithOnClose:(void (^ _Nullable)(T _Nullable))onClose __attribute__((swift_name("init(onClose:)"))) __attribute__((objc_designated_initializer));
- (void (^ _Nullable)(T _Nullable))component1 __attribute__((swift_name("component1()")));
- (DKSKoin_coreCallbacks<T> *)doCopyOnClose:(void (^ _Nullable)(T _Nullable))onClose __attribute__((swift_name("doCopy(onClose:)")));
- (BOOL)isEqual:(id _Nullable)other __attribute__((swift_name("isEqual(_:)")));
- (NSUInteger)hash __attribute__((swift_name("hash()")));
- (NSString *)description __attribute__((swift_name("description()")));
@property (readonly) void (^ _Nullable onClose)(T _Nullable) __attribute__((swift_name("onClose")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreAtomicOp")))
@interface DKSKotlinx_coroutines_coreAtomicOp<__contravariant T> : DKSKotlinx_coroutines_coreOpDescriptor
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)completeAffected:(T _Nullable)affected failure:(id _Nullable)failure __attribute__((swift_name("complete(affected:failure:)")));
- (id _Nullable)decideDecision:(id _Nullable)decision __attribute__((swift_name("decide(decision:)")));
- (id _Nullable)performAffected:(id _Nullable)affected __attribute__((swift_name("perform(affected:)")));
- (id _Nullable)prepareAffected:(T _Nullable)affected __attribute__((swift_name("prepare(affected:)")));
@property (readonly) DKSKotlinx_coroutines_coreAtomicOp<id> *atomicOp __attribute__((swift_name("atomicOp")));
@property (readonly) id _Nullable consensus __attribute__((swift_name("consensus")));
@property (readonly) BOOL isDecided __attribute__((swift_name("isDecided")));
@property (readonly) int64_t opSequence __attribute__((swift_name("opSequence")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreLinkedListNode")))
@interface DKSKotlinx_coroutines_coreLinkedListNode : DKSBase
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)addLastNode:(DKSKotlinx_coroutines_coreLinkedListNode *)node __attribute__((swift_name("addLast(node:)")));
- (BOOL)addLastIfNode:(DKSKotlinx_coroutines_coreLinkedListNode *)node condition:(DKSBoolean *(^)(void))condition __attribute__((swift_name("addLastIf(node:condition:)")));
- (BOOL)addLastIfPrevNode:(DKSKotlinx_coroutines_coreLinkedListNode *)node predicate:(DKSBoolean *(^)(DKSKotlinx_coroutines_coreLinkedListNode *))predicate __attribute__((swift_name("addLastIfPrev(node:predicate:)")));
- (BOOL)addLastIfPrevAndIfNode:(DKSKotlinx_coroutines_coreLinkedListNode *)node predicate:(DKSBoolean *(^)(DKSKotlinx_coroutines_coreLinkedListNode *))predicate condition:(DKSBoolean *(^)(void))condition __attribute__((swift_name("addLastIfPrevAndIf(node:predicate:condition:)")));
- (BOOL)addOneIfEmptyNode:(DKSKotlinx_coroutines_coreLinkedListNode *)node __attribute__((swift_name("addOneIfEmpty(node:)")));
- (void)helpRemove __attribute__((swift_name("helpRemove()")));
- (BOOL)remove __attribute__((swift_name("remove()")));
- (id _Nullable)removeFirstIfIsInstanceOfOrPeekIfPredicate:(DKSBoolean *(^)(id _Nullable))predicate __attribute__((swift_name("removeFirstIfIsInstanceOfOrPeekIf(predicate:)")));
- (DKSKotlinx_coroutines_coreLinkedListNode * _Nullable)removeFirstOrNull __attribute__((swift_name("removeFirstOrNull()")));
@property (readonly) BOOL isRemoved __attribute__((swift_name("isRemoved")));
@property (readonly) DKSKotlinx_coroutines_coreLinkedListNode *nextNode __attribute__((swift_name("nextNode")));
@property (readonly) DKSKotlinx_coroutines_coreLinkedListNode *prevNode __attribute__((swift_name("prevNode")));
@end;

__attribute__((swift_name("Kotlinx_coroutines_coreAbstractAtomicDesc")))
@interface DKSKotlinx_coroutines_coreAbstractAtomicDesc : DKSKotlinx_coroutines_coreAtomicDesc
- (instancetype)init __attribute__((swift_name("init()"))) __attribute__((objc_designated_initializer));
+ (instancetype)new __attribute__((availability(swift, unavailable, message="use object initializers instead")));
- (void)completeOp:(DKSKotlinx_coroutines_coreAtomicOp<id> *)op failure:(id _Nullable)failure __attribute__((swift_name("complete(op:failure:)")));
- (id _Nullable)failureAffected:(DKSKotlinx_coroutines_coreLinkedListNode *)affected __attribute__((swift_name("failure(affected:)")));
- (void)finishOnSuccessAffected:(DKSKotlinx_coroutines_coreLinkedListNode *)affected next:(DKSKotlinx_coroutines_coreLinkedListNode *)next __attribute__((swift_name("finishOnSuccess(affected:next:)")));
- (void)finishPreparePrepareOp:(DKSKotlinx_coroutines_corePrepareOp *)prepareOp __attribute__((swift_name("finishPrepare(prepareOp:)")));
- (void)onComplete __attribute__((swift_name("onComplete()")));
- (id _Nullable)onPreparePrepareOp:(DKSKotlinx_coroutines_corePrepareOp *)prepareOp __attribute__((swift_name("onPrepare(prepareOp:)")));
- (void)onRemovedAffected:(DKSKotlinx_coroutines_coreLinkedListNode *)affected __attribute__((swift_name("onRemoved(affected:)")));
- (id _Nullable)prepareOp:(DKSKotlinx_coroutines_coreAtomicOp<id> *)op __attribute__((swift_name("prepare(op:)")));
- (BOOL)retryAffected:(DKSKotlinx_coroutines_coreLinkedListNode *)affected next:(id)next __attribute__((swift_name("retry(affected:next:)")));
@property (readonly) DKSKotlinx_coroutines_coreLinkedListNode *affectedNode __attribute__((swift_name("affectedNode")));
@end;

#pragma pop_macro("_Nullable_result")
#pragma clang diagnostic pop
NS_ASSUME_NONNULL_END
