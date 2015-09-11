//
//  UserList.m
//  TEST11
//
//  Created by dongjl on 15-9-11.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "UserList.h"
#import <vector>
#import <algorithm>

@interface UserList()
@end

@implementation UserList
    {
        std::vector<__strong User *> _contacts;
       
    }


-(instancetype)init {
    if(self = [super init]){
        [self insertRandomContacts];
    }
    return self;
}


- (void)insertRandomContacts;
{
    for (int i = 0; i < 5; ++i) {
        User *user = [User new];
        [self.contacts addObject:user];
    }
}


- (NSMutableOrderedSet *)contacts
{
    return [self mutableOrderedSetValueForKey:@"backingContacts"];
}


- (NSUInteger)countOfBackingContacts;
{
    return _contacts.size();
}

- (NSUInteger)indexInBackingContactsOfObject:(id)object;
{
    auto i = std::find(_contacts.cbegin(), _contacts.cend(), object);
    return (i == _contacts.cend()) ? NSNotFound : (i - _contacts.cbegin());
}

- (NSArray *)backingContactsAtIndexes:(NSIndexSet *)indexes;
{
    std::vector<User *> objects([indexes count], nil);
    __block auto it = objects.begin();
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        *(it++) = _contacts[idx];
    }];
    return [NSArray arrayWithObjects:objects.data() count:objects.size()];
}

- (void)getBackingContacts:(id __unsafe_unretained [])buffer range:(NSRange)range;
{
    std::vector<User *> objects(range.length, nil);
    auto it1 = objects.begin();
    std::for_each(_contacts.cbegin() + range.location, _contacts.cbegin() + range.location + range.length, [&](User * const c){
        *(it1++) = c;
    });
}

- (void)insertBackingContacts:(NSArray *)array atIndexes:(NSIndexSet *)indexes;
{
    __block NSUInteger idx1 = 0;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx2, BOOL *stop) {
        id object = array[idx1++];
        _contacts.insert(_contacts.begin() + idx2, object);
    }];
}

- (void)removeBackingContactsAtIndexes:(NSIndexSet *)indexes;
{
    [indexes enumerateRangesWithOptions:NSEnumerationReverse usingBlock:^(NSRange range, BOOL *stop) {
        _contacts.erase(_contacts.begin() + range.location, _contacts.begin() + range.location + range.length);
    }];
}

@end
