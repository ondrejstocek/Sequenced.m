//
//  NSDictionary+Sequenced.m
//  Sequenced
//
//  Created by Ondrej Stocek on 23/11/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

#import "NSDictionary+Sequenced.h"

@implementation NSDictionary (Sequenced)

- (void (^)(SequencedDictionaryForEachBlock))forEach {
    return ^(void (^body)(id key, id object)) {
        for (id key in self) {
            body(key, self[key]);
        }
    };
}

- (NSArray *(^)(SequencedDictionaryTransformBlock))map {
    return ^(id (^transform)(id key, id object)) {
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
        for (id key in self) {
            [result addObject:transform(key, self[key])];
        }
        return [result copy];
    };
}

- (NSDictionary *(^)(SequencedDictionaryTestBlock))filter {
    return ^(BOOL (^include)(id key, id object)) {
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
        for (id key in self) {
            id obj = self[key];
            if (include(key, obj)) {
                result[key] = obj;
            }
        }
        return [result copy];
    };
    return nil;
}

- (id (^)(id, SequencedDictionaryCombineBlock))reduce {
    return ^id(id initial, id (^combine)(id memo, id key, id object)) {
        id memo = initial;
        for (id key in self) {
            memo = combine(memo, key, self[key]);
        }
        return memo;
    };
}

@end
