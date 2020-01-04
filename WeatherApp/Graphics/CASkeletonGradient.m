//
//  CASkeletonGradient.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//
#import "CASkeletonGradient.h"

typedef struct {
    CGFloat start;
    CGFloat end;
} CASkeletonPosition;

static CASkeletonPosition createPosition(CGFloat offset){
    CASkeletonPosition position;
    position.start = 0 + offset;
    position.end = 1 + offset;
    return position;
}

NSString *kSkeletonAnimationKey = @"CASkeleton.SlidingAnimation";

@implementation CASkeletonGradient

- (void) setUpLayer{
    CASkeletonPosition startPointTransition = createPosition(0);
    CASkeletonPosition endPointTransition = createPosition(1);
    CASkeletonPosition seamPointTransition = createPosition(0.5);
    CASkeletonPosition backSeamPointTransition = createPosition(-0.5);
    CASkeletonPosition backStartPointTransition = createPosition(-1);
    self.locations =[NSArray arrayWithObjects:
                    [NSNumber numberWithFloat:backStartPointTransition.start],
                    [NSNumber numberWithFloat:backSeamPointTransition.start],
                    [NSNumber numberWithFloat:startPointTransition.start],
                    [NSNumber numberWithFloat:seamPointTransition.start],
                    [NSNumber numberWithFloat:endPointTransition.start],nil];
    self.startPoint = CGPointMake(0, 0.5);
    self.endPoint = CGPointMake(1, 0.5);
}

- (void) animateSkeleton
{
    CASkeletonPosition startPointTransition = createPosition(0);
    CASkeletonPosition endPointTransition = createPosition(1);
    CASkeletonPosition seamPointTransition = createPosition(0.5);
    CASkeletonPosition backSeamPointTransition = createPosition(-0.5);
    CASkeletonPosition backStartPointTransition = createPosition(-1);

    CABasicAnimation *startPointAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    startPointAnim.fromValue = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:backStartPointTransition.start],
                                [NSNumber numberWithFloat:backSeamPointTransition.start],
                                [NSNumber numberWithFloat:startPointTransition.start],
                                [NSNumber numberWithFloat:seamPointTransition.start],
                                [NSNumber numberWithFloat:endPointTransition.start],nil];
    startPointAnim.toValue = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:backStartPointTransition.end],
                              [NSNumber numberWithFloat:backSeamPointTransition.end],
                              [NSNumber numberWithFloat:startPointTransition.end],
                              [NSNumber numberWithFloat:seamPointTransition.end],
                              [NSNumber numberWithFloat:endPointTransition.end],nil];

    CAAnimationGroup *animGroup = [[CAAnimationGroup alloc] init];
    animGroup.animations = @[startPointAnim];
    animGroup.duration = 1;
    animGroup.repeatCount = HUGE_VALF;
    animGroup.removedOnCompletion = false;

    [self addAnimation:animGroup forKey:kSkeletonAnimationKey];
}

- (void)stopSkeleton
{
    [self removeAnimationForKey:kSkeletonAnimationKey];
}

@end
