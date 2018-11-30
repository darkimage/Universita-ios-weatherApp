//
//  AnimatedBackground.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "AnimatedBackground.h"
#import <RZViewActions/UIView+RZViewActions.h>

@interface AnimatedBackground()
@property (nonatomic,strong) NSMutableArray* bgArray;
@property (nonatomic,strong) UIImageView* image1;
@property (nonatomic,strong) UIImageView* image2;
@property (nonatomic,weak)   UIView*view;
@property CGPoint image1Start;
@property CGPoint image2Start;
@end

struct BGSlot{
    struct animBackgroundData bgData;
    UIImageView* image1;
    UIImageView* image2;
    CGPoint image1Start;
    CGPoint image2Start;
};

@implementation AnimatedBackground

-(instancetype) initWithStructData:(struct animBackgroundData)bgData addto:(UIView *)view{
    self = [super init];
    if (self) {
        self.backgroundData = bgData;
        self.view = view;
        view.backgroundColor = bgData.backgroundColor;
        
        self.image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bgData.imagename]];
        self.image1.frame = bgData.frame;
        self.image1.center = [self sumPoint:CGPointMake(view.bounds.size.width/2,view.bounds.size.height/2) toPoint:bgData.offset];
        self.image1Start = self.image1.center;
        self.image1.contentMode = UIViewContentModeScaleAspectFit;
        
        self.image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bgData.imagename]];
        self.image2.frame = bgData.frame;
        self.image2.center = [self sumPoint:CGPointMake(view.bounds.size.width/2-self.image2.bounds.size.width,view.bounds.size.height/2) toPoint:bgData.offset];
        self.image2Start = self.image2.center;
        self.image2.contentMode = UIViewContentModeScaleAspectFit;
        
        [view addSubview:self.image1];
        [view addSubview:self.image2];
    }
    return self;
}
- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView {
    self.image1.center = CGPointMake(self.image1.center.x,self.image1Start.y - scrollView.contentOffset.y );
    self.image2.center = CGPointMake(self.image2.center.x,self.image2Start.y - scrollView.contentOffset.y );
}

- (void)viewDidAppear:(BOOL)animated {
    RZViewAction* moveimage1 = [RZViewAction action:^{
        self.image1.center = CGPointMake(self.image1.bounds.size.width+self.view.bounds.size.width/2, self.image1.center.y);
    } withOptions:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear duration:[self.backgroundData.duration floatValue]];
    
    RZViewAction* movecimage2 = [RZViewAction action:^{
        self.image2.center =CGPointMake(self.view.bounds.size.width/2, self.image2.center.y);
    } withOptions:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear duration:[self.backgroundData.duration floatValue]];
    
    RZViewAction *group = [RZViewAction group:@[moveimage1, movecimage2]];
    [UIView rz_runAction:group];
}

- (CGPoint) sumPoint:(CGPoint) p1 toPoint:(CGPoint) p2{
    return CGPointMake(p1.x + p2.x, p1.y+p2.y);
}

-(BOOL) addBackground:(struct  animBackgroundData) data{
    
    ///[self.bgArray addObject:];
}

@end
