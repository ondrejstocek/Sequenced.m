//
//  NSArray+Sequenced.m
//  Sequenced
//
//  Created by Ondrej Stocek on 21/11/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

#import "NSArray+Sequenced.h"

@implementation NSArray (Sequenced)

- (void (^)(SequencedArrayForEachBlock))forEach {
    return ^(void (^body)(id object)) {
        for (id obj in self) {
            body(obj);
        }
    };
}

- (NSArray *(^)(SequencedArrayTransformBlock))map {
    return ^(id (^transform)(id object)) {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
        for (id obj in self) {
            [result addObject:transform(obj)];
        }
        return [result copy];
    };
}

- (NSArray *(^)(SequencedArrayTestBlock))filter {
    return ^(BOOL (^include)(id object)) {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
        for (id obj in self) {
            if (include(obj)) {
                [result addObject:obj];
            }
        }
        return [result copy];
    };
}

- (id (^)(id, SequencedArrayCombineBlock))reduce {
    return ^id(id initial, id (^combine)(id memo, id object)) {
        id memo = initial;
        for (id obj in self) {
            memo = combine(memo, obj);
        }
        return memo;
    };
}

- (NSArray *(^)(SequencedArrayCompareBlock))sort {
    return ^(BOOL (^isOrderedBefore)(id object1, id object2)) {
        return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return isOrderedBefore(obj1, obj2) ? NSOrderedAscending : NSOrderedDescending;
        }];
    };
}

- (NSUInteger (^)(SequencedArrayTestBlock))indexOf {
    return ^NSUInteger(BOOL (^predicate)(id object)) {
        for (NSUInteger i = 0; i < self.count; ++i) {
            if (predicate(self[i])) {
                return i;
            }
        }
        return NSNotFound;
    };
}

- (BOOL (^)(SequencedArrayTestBlock))contains {
    return ^BOOL(BOOL (^predicate)(id object)) {
        return self.indexOf(predicate) != NSNotFound;
    };
}

- (id (^)(SequencedArrayCompareBlock))maxElement {
    return ^(BOOL (^isOrderedBefore)(id object1, id object2)) {
        return self.reduce(nil, ^id(id max, id obj) {
            return max && isOrderedBefore(obj, max) ? max : obj;
        });
    };
}

- (id (^)(SequencedArrayCompareBlock))minElement {
    return ^(BOOL (^isOrderedBefore)(id object1, id object2)) {
        return self.reduce(nil, ^id(id min, id obj) {
            return min && isOrderedBefore(min, obj) ? min : obj;
        });
    };
}

@end
