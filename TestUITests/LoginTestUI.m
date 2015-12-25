//
//  LoginTestUI.m
//  TEST11
//
//  Created by dongjl on 15/12/25.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "LoginTestUI.h"

@implementation LoginTestUI
- (void)testAlterView {
    [self.app.staticTexts[@"alterview"] tap];
    [self.app.buttons[@"Button11"] tap];
    XCTAssert(self.app.staticTexts[@"电话语音验证码"].exists);
   
}


- (void)testTextField {
    [self.app.staticTexts[@"UITEXTFILED"] tap];
     XCTAssert(self.app.navigationBars[@"主页"].exists);
    [[self.app.textFields elementBoundByIndex:0] tap];
     [[self.app.textFields elementBoundByIndex:1] tap];
    id textFiled = [self.app.textFields elementBoundByIndex:2];
     [[self.app.textFields elementBoundByIndex:2] tap];
    
    [textFiled typeText:@"asfdsdfg"];
    
    
}

- (void)testTableViewCell {
     [self.app.staticTexts[@"UITABLEVIEW"] tap];
    //id firstCell = [self.app.cells elementBoundByIndex:0];register nib
    id firstCell = self.app.staticTexts[@"register nib"];
   id start = [firstCell coordinateWithNormalizedOffset:(CGVectorMake(0, 0))];
    id finish = [firstCell coordinateWithNormalizedOffset:(CGVectorMake(0, 6))];
    [start pressForDuration:3 thenDragToCoordinate:finish];

}


- (void)testPushAndPop {
    //push
    [self.app.staticTexts[@"GTView"] tap];
    XCTAssert(self.app.navigationBars[@"主页"].exists);
    
    //pop
    
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
    XCTAssert(self.app.navigationBars[@"主页"].exists);
}

- (void)testSegmentControl {
    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    XCUIElement *secondButton = [app.segmentedControls containingType:XCUIElementTypeButton identifier:@"ffff"].buttons[@"Second"];
//    [secondButton tap];
//    
//    XCUIElement *button = app.buttons[@"2"];
//    [button tap];
//    
//    XCUIElement *ffffButton = app.buttons[@"ffff"];
//    [ffffButton tap];
//    [secondButton tap];
//    [button tap];
//    [secondButton tap];
//    [button tap];
//    [ffffButton tap];
//    [secondButton tap];
//    [button tap];
    
   [self.app.staticTexts[@"UISegmentControl"] tap];
    [self.app.buttons[@"ffff"] tap];
    [self.app.buttons[@"2"] tap];
    [self.app.buttons[@"qqq"] tap];
}

@end
