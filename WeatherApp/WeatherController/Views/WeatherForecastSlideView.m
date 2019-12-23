//
//  WeatherForecastSlideView.m
//  WeatherApp
//
//  Created by Luca Faggion on 15/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherForecastSlideView.h"
#import "WeatherForecastSlotView.h"

@interface WeatherForecastSlideView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
//@property (strong, nonatomic) IBOutlet UIView *stackContentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@end

@implementation WeatherForecastSlideView

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
    [[NSBundle mainBundle] loadNibNamed:@"WeatherForecastSlideView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.scrollView.delegate = self;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint* height = [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height];
    height.active = YES;
    height.priority = UILayoutPriorityDefaultHigh;
    NSLayoutConstraint* width = [self.widthAnchor constraintEqualToConstant:self.contentView.bounds.size.width];
    width.active = YES;
    width.priority = UILayoutPriorityDefaultHigh;
    for (int i = 0; i<10; i++) {
        [self.stackView addArrangedSubview:[[WeatherForecastSlotView alloc]init]];
    }
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


-(void) updateView:(nonnull CityWeather*)weather{
    
}
@end


