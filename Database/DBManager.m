//
//  DBManager.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

-(NSArray*) loadDataFromDB:(NSString *)query{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return [[NSArray alloc]init];
}

-(void) executeQuery:(NSString *)query{
    NSAssert(NO, @"Subclasses need to overwrite this method");
}

@end
