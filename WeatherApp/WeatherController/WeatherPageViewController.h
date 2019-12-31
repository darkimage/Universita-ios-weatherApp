//
//  WheaterPageViewController.h
//  WeatherApp
//
//  Created by Luca Faggion on 06/09/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"
#import "WeatherManageDelegate.h"

NS_ASSUME_NONNULL_BEGIN

//Questo controller si assicura di presentare in forma scrollabile orizzontale
//i WeatherViewController ed e'anche responsabile di tenerli aggiornati
@interface WeatherPageViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, WeatherManageDelegate>
- (NSArray<WeatherViewController*>*) getControllers;
- (WeatherViewController*) getCurrentController;

@end

NS_ASSUME_NONNULL_END
