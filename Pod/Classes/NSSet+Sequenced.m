//
//  NSSet+Sequenced.m
//  Sequenced
//
//  Created by Ondrej Stocek on 23/11/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

#import "NSSet+Sequenced.h"

@implementation NSSet (Sequenced)

- (void (^)(SequencedSetForEachBlock))forEach {
    return ^(void (^body)(id object)) {
        for (id obj in self) {
            body(obj);
        }
    };
}

- (NSSet *(^)(SequencedSetTransformBlock))map {
    return ^(id (^transform)(id object)) {
        NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
        for (id obj in self) {
            [result addObject:transform(obj)];
        }
        return [result copy];
    };
}

- (NSSet *(^)(SequencedSetTestBlock))filter {
    return ^(BOOL (^include)(id object)) {
        NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
        for (id obj in self) {
            if (include(obj)) {
                [result addObject:obj];
            }
        }
        return [result copy];
    };
}

- (id (^)(id, SequencedSetCombineBlock))reduce {
    return ^id(id initial, id (^combine)(id memo, id object)) {
        id memo = initial;
        for (id obj in self) {
            memo = combine(memo, obj);
        }
        return memo;
    };
}

@end
