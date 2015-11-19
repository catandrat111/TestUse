//
//  BlockModel.m
//  TEST11
//
//  Created by dongjl on 15/11/18.
//  Copyright © 2015年 djl. All rights reserved.
//http://blog.csdn.net/fightper/article/details/12915729


//在MRC中__block variable在block中使用是不會retain的
//但是ARC中__block則是會Retain的。
//取而代之的是用__weak或是__unsafe_unretained來更精確的描述weak reference的目的
//其中前者只能在iOS5之後可以使用，但是比較好 (該物件release之後，此pointer會自動設成nil)
//而後者是ARC的環境下為了相容4.x的解決方案。
//所以上面的範例中
//
//__block MyClass* temp = …;    // MRC環境下使用
//__weak MyClass* temp = …;    // ARC但只支援iOS5.0以上的版本
//__unsafe_retained MyClass* temp = …;  //ARC且可以相容4.x以後的版本

//1 //例如：（无ARC）
//2 __block id safeSelf = self;
//3 self.block = ^(NSString *aString)
//4 {
//    5     safeSelf.aLabel.text = aString;
//    6 });
//7
//8 //（有ARC）
//9 __weak id safeSelf = self;        //ios 5
//10 // __unsafe_unretained id safeSelf = self; //ios 4
//11 self.block = ^(NSString *aString)
//12 {
//    13     safeSelf.aLabel.text = aString;
//    14 });
#import "BlockModel.h"

@implementation BlockModel
- (instancetype)init {
    self = [super init];
    __block id tmp = self;
    blk_ = ^ {
        NSLog(@"self = %@", tmp);
        tmp = nil;
    };
    return self;
}
//如果不执行 会出现泄漏
- (void)execBlock {
    blk_();
}

- (void)dealloc {
    
    NSLog(@"%@ deallloc",self);
}
@end
