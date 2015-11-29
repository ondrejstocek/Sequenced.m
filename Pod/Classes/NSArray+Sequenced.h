//
//  NSArray+Sequenced.h
//  Sequenced
//
//  Created by Ondrej Stocek on 21/11/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (Sequenced)

typedef void (^SequencedArrayForEachBlock)(ObjectType _Nonnull object);
typedef id _Nonnull (^SequencedArrayTransformBlock)(ObjectType _Nonnull object);
typedef BOOL(^SequencedArrayTestBlock)(ObjectType _Nonnull object);
typedef id _Nullable (^SequencedArrayCombineBlock)(id _Nullable memo, ObjectType _Nonnull object);
typedef BOOL(^SequencedArrayCompareBlock)(ObjectType _Nonnull object1, ObjectType _Nonnull object2);

@property (readonly, nonnull) void (^forEach)(_Nonnull SequencedArrayForEachBlock body);

@property (readonly, nonnull) NSArray * _Nonnull (^map)(_Nonnull SequencedArrayTransformBlock transform);

@property (readonly, nonnull) NSArray/*<ObjectType>*/ * _Nonnull (^filter)(_Nonnull SequencedArrayTestBlock includeElement);

@property (readonly, nonnull) id _Nullable (^reduce)(id _Nullable initial, _Nonnull SequencedArrayCombineBlock combine);

@property (readonly, nonnull) NSArray/*<ObjectType>*/ * _Nonnull (^sort)(_Nonnull SequencedArrayCompareBlock isOrderedBefore);

@property (readonly, nonnull) NSUInteger (^indexOf)(_Nonnull SequencedArrayTestBlock predicate);

@property (readonly, nonnull) BOOL (^contains)(_Nonnull SequencedArrayTestBlock predicate);

@property (readonly, nonnull) ObjectType _Nullable (^maxElement)(_Nonnull SequencedArrayCompareBlock);

@property (readonly, nonnull) ObjectType _Nullable (^minElement)(_Nonnull SequencedArrayCompareBlock);

@end
