//
//  GblSaurusType.m
//  gimbalsaurus
//
//  Created by Andrew Apperley on 2023-06-17.
//

#import "GblSaurusType.h"
#import "gimbalsaurus_meta_private.h"

GBL_SAURUS_TYPE_PRIVATE

@implementation InvalidType

- (GblType)_type {
    return GBL_INVALID_TYPE;
}

@end

@interface GblSaurusType ()

- (instancetype)initWithName:(NSString *)name
                    baseType:(GblType)baseType
                    typeInfo:(GblTypeInfo *)info
                   typeFlags:(GblFlags)flags;
@end

@implementation GblSaurusType

static const NSMutableDictionary *_registeredTypes;

+ (void)load {
    [super load];
//    TODO: Might be useful to use NSCache and setup a listener for the registered types internal list changing so this doesn't become stale
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
                                        [name cStringUsingEncoding:NSUTF8StringEncoding],
                                        baseType,
                                        info,
                                        flags);
        _registeredTypes[name] = self;
    }
    return self;
}

+ (instancetype)fromType:(GblType)type {
    GblSaurusType *sType = [[GblSaurusType alloc] init];
    sType._type = type ?: GBL_INVALID_TYPE;
    return sType;
}

+ (instancetype)registerStaticBaseWithName:(NSString *)name {
    return [GblSaurusType registerStaticWithName:name
                                        baseType:[[InvalidType alloc] init]
                                        typeInfo:nil
                                       typeFlags:GBL_TYPE_FLAGS_NONE];
}

+ (instancetype)registerStaticWithName:(NSString *)name
                          baseType:(GblSaurusType *)baseType
                          typeInfo:(nullable GblTypeInfo *)info
                        typeFlags:(GblFlags)flags {
    NSAssert(name.length > 0, @"Name is required to register a type.");
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

- (BOOL)check:(GblSaurusType *)otherType {
    return GblType_check(self._type, otherType._type);
}

- (BOOL)isEqualTo:(GblSaurusType *)otherType {
    return [self check:otherType];
}

#pragma mark - Getters

- (NSString *)name {
    return [NSString stringWithCString:GblType_name(self._type) encoding:NSUTF8StringEncoding];
}

- (GblQuark)nameQuark {
    return GblType_nameQuark(self._type);
}

- (GblSaurusType *)parent {
    return [GblSaurusType fromType:GblType_parent(self._type)];
}

- (GblSaurusType *)root {
    return [GblSaurusType fromType:GblType_root(self._type)];
}

- (size_t)depth {
    return GblType_depth(self._type);
}

- (BOOL)valid {
    return GblType_verify(self._type);
}

- (const GblTypeInfo *)info {
    return GblType_info(self._type);
}

- (GblIPlugin *)plugin {
    return GblType_plugin(self._type);
}

- (GblRefCount)classRefCount {
    return GblType_classRefCount(self._type);
}

- (GblRefCount)instanceRefCount {
    return GblType_instanceRefCount(self._type);
}

@end
