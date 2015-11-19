//
//  main.m
//  BlockTest
//
//  Created by dongjl on 15/11/19.
//  Copyright © 2015年 djl. All rights reserved.
//在 ARC 开启的情况下，将只会有 NSConcreteGlobalBlock 和 NSConcreteMallocBlock 类型的 block。

//原本的 NSConcreteStackBlock 的 block 会被 NSConcreteMallocBlock 类型的 block 替代。证明方式是以下代码在 XCode 中，会输出 <__NSMallocBlock__: 0x100109960>。在苹果的 官方文档 中也提到，当把栈中的 block 返回时，不需要调用 copy 方法了。

#import <Foundation/Foundation.h>

typedef int (^blk_t) (int);
void t1() {
    int i = 1024;
    void (^block1)(void) = ^{
        printf("%d\n", i);
    };
    block1();
    NSLog(@"%@", block1);//2015-11-19 17:08:31.660 BlockTest[2723:211498] <__NSMallocBlock__: 0x100206390>
    
}

void t2() {
    for (int rate = 0; rate < 10; ++rate) {
        blk_t blk = ^(int count) {
            return count;
        };
        NSLog(@"%@", blk);//2015-11-19 18:07:22.669 BlockTest[3076:231923] <__NSGlobalBlock__: 0x100001090>
        //2015-11-19 18:07:29.213 BlockTest[3076:231923] <__NSGlobalBlock__: 0x100001090>
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //t1();
        t2();

    }
    return 0;
}


