//
//  WeatherHeaderView.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/12/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherHeaderView.h"

@interface WeatherHeaderView()
@property (strong, nonatomic) IBOutlet UIView *content;
-(void) internalInit;
@end

@implementation WeatherHeaderView

-(id)init{
    self = [super init];
    if(self){
        [self internalInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self internalInit];
    }
    return self;
}

+ (nonnull WeatherHeaderView *)createView:(NSObject*)owner {
    return (WeatherHeaderView*)[[NSBundle mainBundle] loadNibNamed:@"WeatherHeaderView" owner:owner options:nil].firstObject;
}

- (void)internalInit {
    [[NSBundle mainBundle] loadNibNamed: @"WeatherHeaderView" owner:self options:nil];
    [self addSubview:self.content];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.content.bounds.size.height].active = true;
}

@end
