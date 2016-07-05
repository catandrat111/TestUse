//
//  User.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "User.h"
static int32_t const primes[] = {
    2, 101, 233, 383, 3, 103, 239, 389, 5, 107, 241, 397, 7, 109,
    251, 401, 11, 113, 257, 409, 13, 127, 263, 419, 17, 131, 269,
    421, 19, 137, 271, 431, 23, 139, 277, 433, 29, 149, 281, 439,
    31, 151, 283, 443, 37, 157, 293, 449, 41, 163, 307, 457, 43,
    167, 311, 461, 47, 173, 313, 463, 53, 179, 317, 467, 59, 181,
    331, 479, 61, 191, 337, 487, 67, 193, 347, 491, 71, 197, 349,
    499, 73, 199, 353, 503, 79, 211, 359, 509, 83, 223, 367, 521,
    89, 227, 373, 523, 97, 229, 379, 541, 547, 701, 877, 1049,
    557, 709, 881, 1051, 563, 719, 883, 1061, 569, 727, 887,
    1063, 571, 733, 907, 1069, 577, 739, 911, 1087, 587, 743,
    919, 1091, 593, 751, 929, 1093, 599, 757, 937, 1097, 601,
    761, 941, 1103, 607, 769, 947, 1109, 613, 773, 953, 1117,
    617, 787, 967, 1123, 619, 797, 971, 1129, 631, 809, 977,
    1151, 641, 811, 983, 1153, 643, 821, 991, 1163, 647, 823,
    997, 1171, 653, 827, 1009, 1181, 659, 829, 1013, 1187, 661,
    839, 1019, 1193, 673, 853, 1021, 1201, 677, 857, 1031,
    1213, 683, 859, 1033, 1217, 691, 863, 1039, 1223, 1229,
};

@interface User()
@property (readwrite, nonatomic, strong) NSArray *arraTest;
@end

@implementation User{
    NSMutableSet *_friends;
}

- (NSComparisonResult)compare:(User *)otherUser {
    
    return [self.age compare:otherUser.age];
}


-(instancetype)init {
    if(self = [super init]){
        self.arraTest = @[@"1",@"3"];
    }
    return self;
}

-(void)dealloc {
    
}

- (id)copyWithZone:(NSZone *)zone
{
    User *user = [[[self class] allocWithZone:zone] init];
    user.name = self.name;
    user.age = self.age;
    user -> _friends = [_friends mutableCopy];
    return user;
}


- (void)userTest {
    NSLog(@"user:test");
}

//解释NSInvocation
- (NSString *)appendMyString:(NSString *)string age:(NSInteger)age
{
    NSString *mString = [NSString stringWithFormat:@"%@ after append method", string];
    return mString;
}

- (NSString *)appendTestMyString:(NSString *)string {
    NSString *mString = [NSString stringWithFormat:@"%@ after append method", string];
    return mString;
    
}


//[object setValue:nil forKey:@"height"]
//当标量和 struct 的值被传入 nil 的时候尤其需要注意
//这会抛出一个 exception。要正确的处理 nil，我们要像这样 override -setNilValueForKey:
- (void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"height"]) {
        [self setValue:@0 forKey:key];
    } else
        [super setNilValueForKey:key];
}


//- (id)valueForUndefinedKey:(NSString *)key;
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
//这也许看起来很怪，但这可以让一个类动态的支持一些键的访问。但是这两个方法会在性能上拖后腿。

//Foundation 框架支持直接访问实例变量。请小心的使用这个特性。你可以去查看 +accessInstanceVariablesDirectly 的文档。这个值默认是 YES 的时候，Foundation 会按照 _<key>, _is<Key>(BOOL), <key> 和 is<Key> 的顺序查找实例变量。最后调用- (id)valueForUndefinedKey:(NSString *)key;




- (NSUInteger)countOfPrimes;
{
    return (sizeof(primes) / sizeof(*primes));
}

- (id)objectInPrimesAtIndex:(NSUInteger)idx;
{
    NSParameterAssert(idx < sizeof(primes) / sizeof(*primes));
    return @(primes[idx]);
}

-(NSUInteger)countOfArraTest {
    return 2;
}

-(id)objectInArraTestAtIndex:(NSUInteger)index{
    return @"5";
}


@end

@implementation Father



@end

@implementation Son

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end


