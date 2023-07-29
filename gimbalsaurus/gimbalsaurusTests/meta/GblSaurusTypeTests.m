//
//  GblSaurusTypeTests.m
//  gimbalsaurusTests
//
//  Created by Andrew Apperley on 2023-07-02.
//

#import <XCTest/XCTest.h>
#import <gimbalsaurus/GblSaurusType.h>

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
    XCTAssert([[GblSaurusType typeFromName:@"TestType"].name isEqualToString:@"TestType"]);
}

@end
