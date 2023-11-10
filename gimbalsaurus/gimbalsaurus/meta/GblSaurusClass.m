//
//  GblSaurusClass.m
//  gimbalsaurus
//
//  Created by Andrew Apperley on 2023-07-04.
//

#import "GblSaurusClass.h"
#import "gimbalsaurus_meta_private.h"

GBL_SAURUS_TYPE_PRIVATE
GBL_SAURUS_CLASS_PRIVATE

@implementation GblSaurusClass

#pragma mark - Class Methods

+ (instancetype)reference:(GblSaurusType *)fromType {
    GblClass *_class = GblClass_refDefault(fromType._type);
    GblSaurusClass *class = [[GblSaurusClass alloc] init];
    class._class = _class;

    return class;
}

+ (instancetype)weakReference:(GblSaurusType *)fromType {
    __weak GblSaurusClass *class = [GblSaurusClass reference:fromType];
    return class;
}

+ (instancetype)floating:(GblSaurusType *)fromType {
    GblSaurusClass *class = [GblSaurusClass reference:fromType];
    return class;
}

#pragma mark - Instance Methods

- (GblRefCount)unreference {
    return GblClass_unrefDefault(self._class);
}

- (GBL_RESULT)destroyFloating {
    return GblClass_destructFloating(self._class);
}

//- (GBL_RESULT)constructFloatingFromType:(GblSaurusType *)type {
//
//}

- (GBL_RESULT)destructFloating {
    return GblClass_destructFloating(self._class);
}

- (BOOL)check:(GblSaurusType *)otherType {
    return GblClass_check(self._class, otherType._type);
}

- (BOOL)isEqualTo:(GblSaurusType *)object {
    return [self check:object];
}

//- (instancetype)castToType:(GblSaurusType *)type {
//
//}
//
//- (instancetype)tryCastToType:(GblSaurusType *)type {
//
//}

- (void)dealloc {
    self._default = nil;
    self._super = nil;
    self._class = nil;
}

#pragma mark - Properties

- (size_t)size {
    return GblClass_size(self._class);
}

- (size_t)privateSize {
    return GblClass_privateSize(self._class);
}

- (size_t)totalSize {
    return GblClass_totalSize(self._class);
}

- (GblSaurusClass *)superClass {
    if (self._super) {
        return self._super;
    }
    self._super = [[GblSaurusClass alloc] init];
    self._super._class = GblClass_super(self._class);
    return self._super;
}

- (GblSaurusClass *)defaultClass {
    if (self._default) {
        return self._default;
    }
    self._default = [[GblSaurusClass alloc] init];
    self._default._class = GblClass_default(self._class);
    return self._default;
}

- (BOOL)isDefault {
    return GblClass_isDefault(self._class);
}

- (BOOL)isOverridden {
    return GblClass_isOverridden(self._class);
}

- (BOOL)isFloating {
    return GblClass_isFloating(self._class);
}

- (BOOL)isInterface {
    return GblClass_isInterface(self._class);
}

- (BOOL)isInterfaceImpl {
    return GblClass_isInterfaceImpl(self._class);
}

- (BOOL)isOwned {
    return GblClass_isOwned(self._class);
}

- (BOOL)isInPlace {
    return GblClass_isInPlace(self._class);
}

@end
