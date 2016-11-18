//
//  Target_Detail.h
//  CTMediator
//
//  Created by yehot on 16/5/28.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  1、给已有的 A_VC 添加一个 action：
 *         Target_A_VC 内部依赖  A_VC
 *
 *  2、给 CTMediator 加一个 category+A_VC_Action
 *      内部需要 hardCode  A_VC 的 名字字符串 和 Target_A_VC 的 api 接口
 *
 *  3、这两步虽然麻烦，但是，完全不用改造原有 的 A_VC  ！！！！
 *
 */
@interface Target_Detail : NSObject

//  如果这里的 方法名变了。 category+A_VC_Action 中的字符串也必须得变
- (UIViewController *)Action_NativeToDetailViewController:(NSDictionary *)params;

@end

