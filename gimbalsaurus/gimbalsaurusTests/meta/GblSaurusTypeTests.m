//
//  GblSaurusTypeTests.m
//  gimbalsaurusTests
//
//  Created by Andrew Apperley on 2023-07-02.
//

#import <XCTest/XCTest.h>
#import <gimbalsaurus/GblSaurusType.h>

@interface InvalidType: GblSaurusType
@property(nonatomic, readonly)GblType *_type;
@end

@implementation InvalidType

- (GblType *)_type {
    return 0; // GBL_INVALID_TYPE
}

@end

@interface GblSaurusTypeTests : XCTestCase
@property(nullable, nonatomic)GblSaurusType *invalid;
@property(nullable, nonatomic)GblSaurusType *type;
@end

@implementation GblSaurusTypeTests

- (void)setUp {
    self.invalid = [[InvalidType alloc] init];
    self.type = [GblSaurusType
                           registerStaticWithName:@"TestType"
                           baseType:self.invalid
                           typeInfo:NULL
                           typeFlags:GBL_TYPE_FLAGS_NONE];
}

- (void)tearDown {
    [GblSaurusType unregisterType:self.type];
    self.type = nil;
    self.invalid = nil;
}

- (void)testStaticRegistration {
    XCTAssert([self.type.name isEqual:@"TestType"]);
    XCTAssert(GblSaurusType.registeredCount == GblSaurusType.builtinCount + 1);
    XCTAssertNotNil(self.type.parent);
    XCTAssertNotNil(self.type.root);
    XCTAssert([self.type.parent isEqualTo: self.invalid]);
    XCTAssert([self.type.root isEqualTo:self.type]);
}

- (void)testGetTypeByName {
    XCTAssertNotNil([GblSaurusType typeFromName:@"TestType"]);
}

@end
