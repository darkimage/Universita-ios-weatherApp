//
//  WeatherHistoryEntry.m
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import "WeatherHistoryEntry.h"

@implementation WeatherHistoryEntry
-(instancetype) initFromData:(NSArray*)historyEntry{
    self = [super init];
    if(self){
        if(historyEntry.count != 7){
            return nil;
        }
        _ID = [NSNumber numberWithInteger:[historyEntry[0] integerValue]];
        _time = [NSDate dateWithTimeIntervalSince1970:[historyEntry[1] doubleValue]];
        _temperature = [NSNumber numberWithInteger:[historyEntry[2] integerValue]];
        _minTemperature = [NSNumber numberWithInteger:[historyEntry[3] floatValue]];
        _maxTemperature = [NSNumber numberWithInteger:[historyEntry[4] floatValue]];
        _weatherDescription = historyEntry[5];
        _icon = historyEntry[6];
    }
    return self;
}
@end
