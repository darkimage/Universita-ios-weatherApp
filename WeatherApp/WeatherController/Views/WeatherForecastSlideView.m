//
//  WeatherForecastSlideView.m
//  WeatherApp
//
//  Created by Luca Faggion on 15/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherForecastSlideView.h"
#import "WeatherForecastSlotView.h"
#import "UIView+WeatherViewCategory.h"

@interface WeatherForecastSlideView()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) NSArray<WeatherForecastSlotView*>* slots;
@property NSInteger count;
@end

@implementation WeatherForecastSlideView

-(void)initView{
    [self initViewFromNib:@"WeatherForecastSlideView"];
    self.count = 8;
    self.scrollView.delegate = self;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint* height = [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height];
    height.active = YES;
    height.priority = UILayoutPriorityDefaultHigh;
    NSLayoutConstraint* width = [self.widthAnchor constraintEqualToConstant:self.contentView.bounds.size.width];
    width.active = YES;
    width.priority = UILayoutPriorityDefaultHigh;
    WeatherForecastSlotView* viewslots[self.count];
    for (int i = 0; i<self.count; i++) {
        viewslots[i] = [[WeatherForecastSlotView alloc] initWithTimeIndex:i];
        [self.stackView addArrangedSubview:viewslots[i]];
    }
    self.slots = [NSArray arrayWithObjects:viewslots count:self.count];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void) onStartUpdate{
    for (WeatherForecastSlotView* slot in self.slots) {
        [slot onStartUpdate];
    }
}

-(void) updateView:(nonnull CityWeather*)weather{
    for (int i=0; i<self.count; i++) {
        [self.slots[i] updateView:weather];
    }
}

@end


