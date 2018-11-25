//
//  Test.h
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject
-(void) updateAfterGetCity:(NSData*)data;
-(void) updateAfterGetCityforecast:(NSData*)data;
@end

NS_ASSUME_NONNULL_END
