//
//  WeatherHistoryCell.m
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import "WeatherHistoryCell.h"

@interface WeatherHistoryCell()
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *minMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *mainTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIcon;
@end


@implementation WeatherHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void) setCellData:(WeatherHistoryEntry*)entry{
    if(entry){
        NSDateFormatter* format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMM d, yyyy"];
        self.timeLabel.text = [format stringFromDate:entry.time];
        self.minMaxLabel.text = [NSString stringWithFormat:@"%.01f°/%.01f°", [entry.minTemperature floatValue], [entry.maxTemperature floatValue]];
        self.mainTempLabel.text = [NSString stringWithFormat:@"%.00f°", [entry.minTemperature floatValue]];
        self.descriptionLabel.text = entry.weatherDescription;
        self.weatherIcon.image = [UIImage imageNamed:entry.icon];
    }
}

@end
