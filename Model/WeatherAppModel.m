//
//  WeatherAppModel.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherAppModel.h"

@implementation WeatherAppModel

//Singleton Pattern
+(id) sharedModel{
    static WeatherAppModel* sharedAppModel;
    @synchronized (self) {
        if(sharedAppModel == nil){
            sharedAppModel = [[self alloc]init];
        }
        return sharedAppModel;
    }
}

@end
