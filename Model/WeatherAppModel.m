//
//  WeatherAppModel.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherAppModel.h"

@interface WeatherAppModel()

@property (nonatomic, strong) DBManager* DBData;
@property (nonatomic, strong) WeatherData* WeatherData;
@property (nonatomic, strong) WeatherBackgroundPresets* WeatherBackgroundData;
@property (nonatomic, strong) AnimatedBackground* background;
@end

@implementation WeatherAppModel

#pragma mark - SINGLETON INIT
+(instancetype) sharedModel{
    static WeatherAppModel* sharedAppModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            sharedAppModel = [[self alloc]init];
    });
    return sharedAppModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.DBData = [[SQLManager alloc] init];
        self.WeatherData = [[WeatherData alloc]init];
        self.WeatherBackgroundData = [[WeatherBackgroundPresets alloc] init];
    }
    return self;
}

#pragma mark - SINGLETON INSTANCE METHODS
-(DBManager*) getDatabase{
    return self.DBData;
}

-(WeatherData*) getWeatherData{
    return self.WeatherData;
}

- (nonnull WeatherBackgroundPresets *)getWeatherBackgroundPreset { 
    return self.WeatherBackgroundData;
}

- (nonnull AppDelegate *)getAppDelegate { 
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(void) setAnimatedBackground:(AnimatedBackground*)background{
    self.background = background;
}

-(AnimatedBackground*) getCurrentAnimatedBackground{
    return self.background;
}

#pragma mark STATIC METHODS
+(void) displayToastWithMessage:(NSString*)message andDuration:(CGFloat)duration from:(UIViewController*)view {
    UIAlertController* toast = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [toast dismissViewControllerAnimated:YES completion:nil];
    }];
    [toast addAction:defaultAction];
    [view presentViewController:toast animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toast dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
