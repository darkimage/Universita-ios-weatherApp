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
//@property (strong, nonatomic) IBOutlet UIView *stackContentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
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
    for (int i = 0; i<10; i++) {
        [self.stackView addArrangedSubview:[[WeatherForecastSlotView alloc]init]];
    }
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


-(void) updateView:(nonnull CityWeather*)weather{
    
}

@end


