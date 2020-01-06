//
//  WeatherHistoryEntry.m
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import "WeatherHistoryEntry.h"

@implementation WeatherHistoryEntry
-(id) initFromData:(NSArray*)historyEntry{
    self = [super init];
    if(self){
        if(historyEntry.count != 7){
            return nil;
        }
        self.ID = [NSNumber numberWithInteger:[historyEntry[0] integerValue]];
        self.time = [NSDate dateWithTimeIntervalSince1970:[historyEntry[1] floatValue]];
        self.temperature = [NSNumber numberWithInteger:[historyEntry[2] integerValue]];
        self.minTemperature = [NSNumber numberWithInteger:[historyEntry[3] floatValue]];
        self.maxTemperature = [NSNumber numberWithInteger:[historyEntry[4] floatValue]];
        self.weatherDescription = historyEntry[5];
        self.icon = historyEntry[6];
    }
    return self;
}
@end
