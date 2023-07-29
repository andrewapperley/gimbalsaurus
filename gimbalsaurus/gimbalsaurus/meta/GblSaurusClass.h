//
//  GblSaurusClass.h
//  gimbalsaurus
//
//  Created by Andrew Apperley on 2023-07-04.
//

#import <Foundation/Foundation.h>
#import <gimbalsaurus/GblSaurusType.h>
#import <gimbal_builtin_types.h>
#import <gimbal_class.h>

NS_ASSUME_NONNULL_BEGIN

@interface GblSaurusClass : NSObject

#pragma mark - Class Methods

+ (instancetype)reference:(GblSaurusType *)fromType;

+ (instancetype)weakReference:(GblSaurusType *)fromType;

+ (instancetype)floating:(GblSaurusType *)fromType;

#pragma mark - Instance Methods
- (GblRefCount)unreference;

- (GBL_RESULT)destroyFloating;

- (GBL_RESULT)constructFloatingFromType:(GblSaurusType *)type;

- (GBL_RESULT)destructFloating;

- (BOOL)check:(GblSaurusType *)object;

- (instancetype)castToType:(GblSaurusType *)type;

- (instancetype)tryCastToType:(GblSaurusType *)type;
//GBL_EXPORT void*       GblClass_private            (GBL_CSELF, GblType type)   GBL_NOEXCEPT;
//GBL_EXPORT GblClass*   GblClass_public             (const void* pPrivate, GblType     base)          GBL_NOEXCEPT;
#pragma mark - Properties
@property(nonatomic, readonly)size_t size;

@property(nonatomic, readonly)size_t privateSize;

@property(nonatomic, readonly)size_t totalSize;

@property(nonatomic, nonnull, readonly)GblSaurusClass *superClass;

@property(nonatomic, nonnull, readonly)GblSaurusClass *defaultClass;

@property(nonatomic, readonly)BOOL isDefault;

@property(nonatomic, readonly)BOOL isOverridden;

@property(nonatomic, readonly)BOOL isFloating;

@property(nonatomic, readonly)BOOL isInterface;

@property(nonatomic, readonly)BOOL isInterfaceImpl;

@property(nonatomic, readonly)BOOL isOwned;

@property(nonatomic, readonly)BOOL isInPlace;

@end

NS_ASSUME_NONNULL_END
