//
//  GblSaurusTypeTests.m
//  gimbalsaurusTests
//
//  Created by Andrew Apperley on 2023-07-02.
//

#import <XCTest/XCTest.h>
#import <gimbalsaurus/GblSaurusType.h>

@interface GblSaurusTypeTests : XCTestCase

@end

@implementation GblSaurusTypeTests

- (void)testStaticRegistration {
    struct GblTypeInfo info;
    GblSaurusType *type = [GblSaurusType
                           registerStaticWithName:@"TestType"
                           baseType:nil
                           typeInfo:&info
                           typeFlags:0];
    XCTAssert([type.name isEqual:@"TestType"]);
    XCTAssert(GblSaurusType.registeredCount == GblSaurusType.builtinCount + 1);
    XCTAssertNil(type.parent);
    XCTAssertNotNil(type.root);
    XCTAssert([type.root isEqualTo:type]);
}

@end
