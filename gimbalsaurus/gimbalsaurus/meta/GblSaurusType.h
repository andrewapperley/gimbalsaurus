//
//  GblSaurusType.h
//  gimbalsaurus
//
//  Created by Andrew Apperley on 2023-06-17.
//

#import <Foundation/Foundation.h>
#import <gimbal_builtin_types.h>
#import <gimbal_type.h>

NS_ASSUME_NONNULL_BEGIN

@interface GblSaurusType : NSObject

#pragma mark - Class Methods

+ (instancetype)registerStaticWithName:(NSString *)name
                          baseType:(GblSaurusType *)baseType
                          typeInfo:(nullable GblTypeInfo *)info
                          typeFlags:(GblFlags)flags;

+ (instancetype)nextRegisteredFromPrevious:(GblSaurusType *)previousType;

+ (instancetype)typeFromName:(NSString *)name;

+ (instancetype)typeFromNameQuark:(GblQuark)quark;

+ (instancetype)typeFromBuiltinIndex:(size_t)index;

+ (GBL_RESULT)unregisterType:(GblSaurusType *)type;

+ (GBL_RESULT)addExtensionType:(GblSaurusType *)type toInterface:(GblInterface *)interface;

+ (GBL_RESULT)removeExtensionType:(GblSaurusType *)type fromInterface:(GblSaurusType *)interface;

+ (size_t)registeredCount;

+ (size_t)builtinCount;

#pragma mark - Instance Methods

- (instancetype)baseTypeWithDepth:(size_t)depth;

- (instancetype)ancestorTypeWithLevel:(size_t)level;

- (BOOL)flagsCheckWithMask:(GblFlags)mask;

- (BOOL)dependsOnType:(GblSaurusType *)dependency;

- (BOOL)derivesFromType:(GblSaurusType *)superType;

- (BOOL)implementsType:(GblSaurusType *)superType;

- (BOOL)commonTypeBetweenOtherType:(GblSaurusType *)otherType;

- (BOOL)mapsToType:(GblSaurusType *)interface;

- (BOOL)conformsToType:(GblSaurusType *)dependent;

- (GblInterface *)extensionWithInterface:(GblSaurusType *)interface;

// this will be an override of isEqualTo:
//GBL_EXPORT GblBool            GblType_check            (GBL_VSELF, GblType other)      GBL_NOEXCEPT;

#pragma mark - Properties

@property(nonatomic, nonnull, readonly)NSString *name;
@property(nonatomic, readonly)GblQuark nameQuark;
@property(nonatomic, nullable, readonly)GblSaurusType *parent;
@property(nonatomic, nonnull, readonly)GblSaurusType *root;
@property(nonatomic, readonly)size_t depth;
@property(nonatomic, readonly)BOOL valid;
@property(nonatomic, nonnull, readonly)const GblTypeInfo *info;
@property(nonatomic, nonnull, readonly)GblIPlugin *plugin;
@property(nonatomic, readonly)GblRefCount classRefCount;
@property(nonatomic, readonly)GblRefCount instanceRefCount;

@end

NS_ASSUME_NONNULL_END
