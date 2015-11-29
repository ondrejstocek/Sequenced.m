//
//  NSDictionary+Sequenced.h
//  Sequenced
//
//  Created by Ondrej Stocek on 23/11/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (Sequenced)

typedef void (^SequencedDictionaryForEachBlock)(KeyType _Nonnull key, ObjectType _Nonnull object);
typedef id _Nonnull (^SequencedDictionaryTransformBlock)(KeyType _Nonnull key, ObjectType _Nonnull object);
typedef BOOL(^SequencedDictionaryTestBlock)(KeyType _Nonnull key, ObjectType _Nonnull object);
typedef id _Nullable (^SequencedDictionaryCombineBlock)(id _Nullable memo, KeyType _Nonnull key, ObjectType _Nonnull object);


@property (readonly, nonnull) void (^forEach)(_Nonnull SequencedDictionaryForEachBlock body);

@property (readonly, nonnull) NSArray * _Nonnull (^map)(_Nonnull SequencedDictionaryTransformBlock transform);

@property (readonly, nonnull) NSDictionary/*<KeyType, ObjectType>*/ * _Nonnull (^filter)(_Nonnull SequencedDictionaryTestBlock include);

@property (readonly, nonnull) id _Nullable (^reduce)(id _Nullable initial, _Nonnull SequencedDictionaryCombineBlock combine);

@end
