//
//  NSSet+Sequenced.h
//  Sequenced
//
//  Created by Ondrej Stocek on 23/11/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet<__covariant ObjectType> (Sequenced)

typedef void (^SequencedSetForEachBlock)(ObjectType _Nonnull object);
typedef id _Nonnull (^SequencedSetTransformBlock)(ObjectType _Nonnull object);
typedef BOOL(^SequencedSetTestBlock)(ObjectType _Nonnull object);
typedef id _Nullable (^SequencedSetCombineBlock)(id _Nullable memo, ObjectType _Nonnull object);

@property (readonly, nonnull) void (^forEach)(_Nonnull SequencedSetForEachBlock body);

@property (readonly, nonnull) NSSet * _Nonnull (^map)(_Nonnull SequencedSetTransformBlock transform);

@property (readonly, nonnull) NSSet/*<ObjectType>*/ * _Nonnull (^filter)(_Nonnull SequencedSetTestBlock include);

@property (readonly, nonnull) id _Nullable (^reduce)(id _Nullable initial, _Nonnull SequencedSetCombineBlock combine);


@end
