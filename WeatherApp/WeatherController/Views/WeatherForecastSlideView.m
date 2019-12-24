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
@end

@implementation WeatherForecastSlideView

-(void)initView{
    [self initViewFromNib:@"WeatherForecastSlideView"];
    self.scrollView.delegate = self;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint* height = [self.heightAnchor constraintEqualToConstant:self.contentView.bounds.size.height];
    height.active = YES;
    height.priority = UILayoutPriorityDefaultHigh;
    NSLayoutConstraint* width = [self.widthAnchor constraintEqualToConstant:self.contentView.bounds.size.width];
    width.active = YES;
    width.priority = UILayoutPriorityDefaultHigh;
    WeatherForecastSlotView* viewslots[8];
    for (int i = 0; i<8; i++) {
        viewslots[i] = [[WeatherForecastSlotView alloc]init];
        [self.stackView addArrangedSubview:viewslots[i]];
    }
    self.slots = [NSArray arrayWithObjects:viewslots count:8];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


-(void) updateView:(nonnull CityWeather*)weather{
    
}

@end


