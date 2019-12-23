//
//  WeatherForecastSlotView.m
//  WeatherApp
//
//  Created by Luca Faggion on 15/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherForecastSlotView.h"

@interface WeatherForecastSlotView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end

@implementation WeatherForecastSlotView

-(id) init{
    self = [super init];
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    return self;
}

-(void)internalInit{
    [[NSBundle mainBundle] loadNibNamed:@"WeatherForecastSlotView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height].active = true;
    [self.widthAnchor constraintEqualToConstant:self.contentView.bounds.size.width].active = true;
}


@end
