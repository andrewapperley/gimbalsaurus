//
//  GblSaurusType.m
//  gimbalsaurus
//
//  Created by Andrew Apperley on 2023-06-17.
//

#import "GblSaurusType.h"

@interface GblSaurusType ()

- (instancetype)initWithName:(NSString *)name
                    baseType:(GblType)baseType
                    typeInfo:(GblTypeInfo *)info
                   typeFlags:(GblFlags)flags;

@property(nonatomic)GblType _type;
@end

@implementation GblSaurusType

static const NSMutableDictionary *_registeredTypes;

+ (void)load {
    [super load];
    _registeredTypes = [[NSMutableDictionary alloc] init];
}

#pragma mark - Initialization

- (instancetype)initWithName:(NSString *)name
                    baseType:(GblType)baseType
                    typeInfo:(GblTypeInfo *)info
                   typeFlags:(GblFlags)flags {
    self = [super init];
    if (self) {
        __type = GblType_registerStatic(
                                        [name cStringUsingEncoding:NSUnicodeStringEncoding],
                                        baseType,
                                        info,
                                        flags);
        _registeredTypes[name] = self;
    }
    return self;
}

+ (instancetype)fromType:(GblType)type {
    GblSaurusType *sType = [[GblSaurusType alloc] init];
    sType._type = type;
    return sType;
}

+ (instancetype)registerStaticWithName:(NSString *)name
                          baseType:(GblSaurusType *)baseType
                          typeInfo:(GblTypeInfo *)info
                        typeFlags:(GblFlags)flags {
    return [[GblSaurusType alloc] initWithName:name
                                      baseType:baseType._type
                                      typeInfo:info
                                     typeFlags:flags];
}

#pragma mark - Class Methods

+ (instancetype)nextRegisteredFromPrevious:(GblSaurusType *)previousType {
    return [GblSaurusType fromType:GblType_nextRegistered(previousType._type)];
}

+ (instancetype)typeFromName:(NSString *)name {
    return _registeredTypes[name];
}

+ (instancetype)typeFromNameQuark:(GblQuark)quark {
    NSString *stringFromQuark = [NSString stringWithUTF8String:GblQuark_toString(quark)];
    return _registeredTypes[stringFromQuark];
}

+ (instancetype)typeFromBuiltinIndex:(size_t)index {
    return [GblSaurusType fromType:GblType_fromBuiltinIndex(index)];
}

+ (GBL_RESULT)unregisterType:(GblSaurusType *)type {
    return GblType_unregister(type._type);
}

+ (GBL_RESULT)addExtensionType:(GblSaurusType *)type toInterface:(GblInterface *)interface {
    return GBL_RESULT_UNKNOWN;//GblType_addExtension(type._type,  interface);
}

+ (GBL_RESULT)removeExtensionType:(GblSaurusType *)type fromInterface:(GblSaurusType *)interface {
    return GBL_RESULT_UNKNOWN;//GblType_removeExtension(type._type, interface._type);
}

// These two could also use the cached count inside _registeredTypes
+ (size_t)registeredCount {
    return GblType_registeredCount();
}

+ (size_t)builtinCount {
    return GblType_builtinCount();
}

#pragma mark - Instance Methods

- (instancetype)baseTypeWithDepth:(size_t)depth {
    return [GblSaurusType fromType:GblType_base(self._type, depth)];
}

- (instancetype)ancestorTypeWithLevel:(size_t)level {
    return [GblSaurusType fromType:GblType_ancestor(self._type, level)];
}

- (BOOL)flagsCheckWithMask:(GblFlags)mask {
    return GblType_flagsCheck(self._type, mask);
}

- (BOOL)dependsOnType:(GblSaurusType *)dependency {
    return GblType_derives(self._type, dependency._type);
}

- (BOOL)derivesFromType:(GblSaurusType *)superType {
    return GblType_derives(self._type, superType._type);
}

- (BOOL)implementsType:(GblSaurusType *)superType {
    return GblType_implements(self._type, superType._type);
}

- (BOOL)commonTypeBetweenOtherType:(GblSaurusType *)otherType {
    return GblType_common(self._type, otherType._type);
}

- (BOOL)mapsToType:(GblSaurusType *)interface {
    return GblType_maps(self._type, interface._type);
}

- (BOOL)conformsToType:(GblSaurusType *)dependent {
    return GblType_conforms(self._type, dependent._type);
}

- (GblInterface *)extensionWithInterface:(GblSaurusType *)interface {
    return nil;//GblType_extension(self._type, interface._type);
}

- (BOOL)isEqualTo:(GblSaurusType *)otherType {
    return GblType_check(self._type, otherType._type);
}

@end
