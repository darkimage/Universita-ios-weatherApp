//
//  AnimatedBackground.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//
// Classe usata per realizzare l effetto del cielo animato nel background della
// applicazione con un effetto di parallax (layers)

#import "AnimatedBackground.h"
#import <RZViewActions/UIView+RZViewActions.h>

@interface AnimatedBackground()
//PRIVATE PROPRIETIES
@property (nonatomic,strong) NSMutableArray* bgArray;
@property (nonatomic,weak)   UIView*view;
@property CGPoint image1Start;
@property CGPoint image2Start;
@property CGPoint lastScrollPoint;
@property (nonatomic,strong) UIView* maingradient;
@property (nonatomic,strong) UIView* topgradient;
@property BOOL hasGradient;

//HELPER FUNCTIONS
-(BGSlot*) createSlotandAddtoView:(struct  animBackgroundData) bgData;

//MATH FUNCTIONS
-(float) maxf:(float) a b:(float) b;
-(float) remapto01f:(float) low1 high1:(float) high1 value:(float) value;
-(CGPoint) subtractPoint:(CGPoint) p1 toPoint:(CGPoint) p2;
@end

@implementation AnimatedBackground

-(instancetype) initWithStructData:(struct animBackgroundData)bgData withColor:(UIColor *)backgroundColor addTo:(UIView *)view{
    self = [super init];
    if (self) {
        self.view = view;
        view.backgroundColor = backgroundColor;
        self.parallaxMaxOffset = [NSNumber numberWithFloat:200.0];
        self.parallaxMultiplier = [NSNumber numberWithFloat:1.0];
        //self.lastScrollPoint = CGPointZero;
        self.bgArray = [[NSMutableArray alloc]init];
        [self addBackgroundToFront:bgData];

    }
    return self;
}

-(instancetype) initWithStructData:(struct animBackgroundData)bgData withGradient:(CAGradientLayer*)gradient addTo:(UIView*)view{
    self = [super init];
    if (self) {
        self.hasGradient = YES;
        self.view = view;
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(0, 0);
        self.view.backgroundColor = [UIColor colorWithCGColor:CFBridgingRetain(gradient.colors[0])];
        self.maingradient = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.topgradient = [[UIView alloc]initWithFrame:CGRectMake(0, -self.view.bounds.size.height-500, self.view.bounds.size.width, view.bounds.size.height+500)];
        self.topgradient.backgroundColor = [UIColor colorWithCGColor:CFBridgingRetain(gradient.colors[1])];
        [self.maingradient.layer insertSublayer:gradient atIndex:0];
        [self.view addSubview:self.maingradient];
        [self.view addSubview:self.topgradient];
        
        self.parallaxMaxOffset = [NSNumber numberWithFloat:200.0];
        self.parallaxMultiplier = [NSNumber numberWithFloat:1.0];
        //self.lastScrollPoint = CGPointZero;
        self.bgArray = [[NSMutableArray alloc]init];
        [self addBackgroundToFront:bgData];
        
    }
    return self;
}

- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView {
    
    //CGPoint deltascroll = [self subtractPoint:scrollView.contentOffset toPoint:self.lastScrollPoint];
    //self.lastScrollPoint = scrollView.contentOffset;
    
    NSInteger index = 0;
    for (BGSlot* slot in self.bgArray) {
        float parallaxlayer = (float)[self.bgArray count] - (float)index; //Layer attuale nell array (inverso rispetto ad ordine nell'array)
        float percent = parallaxlayer*1./[self.bgArray count];            //percentuale dell'attuale layer
        float offset = [self remapto01f:0.0 high1:200.0 value:[self maxf:scrollView.contentOffset.y b:200.0]]*percent; //offset del parallax
        //- scrollView.contentOffset.y
        slot.image1.center = CGPointMake(slot.image1.center.x,slot.image1Start.y - scrollView.contentOffset.y - self.parallaxMaxOffset.floatValue*offset*self.parallaxMultiplier.floatValue);
        slot.image2.center = CGPointMake(slot.image2.center.x,slot.image2Start.y - scrollView.contentOffset.y - self.parallaxMaxOffset.floatValue*offset*self.parallaxMultiplier.floatValue);
        index++;
    }
    if(self.hasGradient){
    self.maingradient.center = CGPointMake(self.maingradient.center.x,self.view.bounds.size.height/2-scrollView.contentOffset.y);
    self.topgradient.center = CGPointMake(self.topgradient.center.x,self.view.bounds.size.height/2-self.maingradient.bounds.size.height - scrollView.contentOffset.y);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    for (BGSlot* slot in self.bgArray) {
    RZViewAction* moveimage1 = [RZViewAction action:^{
        slot.image1.center = CGPointMake(slot.image1.bounds.size.width+self.view.bounds.size.width/2, slot.image1.center.y);
    } withOptions:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear duration:slot.bgData.duration];
    
    RZViewAction* movecimage2 = [RZViewAction action:^{
        slot.image2.center =CGPointMake(self.view.bounds.size.width/2, slot.image2.center.y);
    } withOptions:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear duration:slot.bgData.duration];
    
    RZViewAction *group = [RZViewAction group:@[moveimage1, movecimage2]];
    [UIView rz_runAction:group];
    }
}
-(void) addBackgroundToFront:(struct  animBackgroundData) bgData{
    BGSlot* nslot = [self createSlotandAddtoView:bgData];
    [self.bgArray insertObject:nslot atIndex:0];
    [self sortsubViews];
}

-(void) addBackgroundToBack:(struct  animBackgroundData) bgData{
    BGSlot* nslot = [self createSlotandAddtoView:bgData];
    [self.bgArray addObject:nslot];
    [self sortsubViews];
}


-(void) addBackground:(struct  animBackgroundData) bgData atPosition:(NSInteger)index{
    BGSlot* nslot = [self createSlotandAddtoView:bgData];
    [self.bgArray insertObject:nslot atIndex:index];
    [self sortsubViews];
}

-(void) sortsubViews{
    for (BGSlot* slot in self.bgArray) {
        [self.view sendSubviewToBack:slot.image1];
        [self.view sendSubviewToBack:slot.image2];
    }
    if(self.hasGradient){
        [self.view sendSubviewToBack:self.maingradient];
        [self.view sendSubviewToBack:self.topgradient];
    }
}

-(BGSlot*) createSlotandAddtoView:(struct  animBackgroundData) bgData{
    
    BGSlot* slot = [[BGSlot alloc]init];
    slot.bgData = bgData;
    slot.image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bgData.imagename]];
    slot.image1.frame = bgData.frame;
    slot.image1.center = CGPointMake(self.view.bounds.size.width/2,self.view.bounds.size.height/2+bgData.offset_y);
    slot.image1Start = slot.image1.center;
    slot.image1.backgroundColor = [UIColor clearColor];
    slot.image1.contentMode = UIViewContentModeScaleAspectFit;
    slot.image1.alpha = bgData.alpha;
    
    slot.image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bgData.imagename]];
    slot.image2.frame = bgData.frame;
    slot.image2.center = CGPointMake(self.view.bounds.size.width/2-slot.image2.bounds.size.width,self.view.bounds.size.height/2+bgData.offset_y);
    slot.image2Start = slot.image2.center;
    slot.image2.backgroundColor = [UIColor clearColor];
    slot.image2.contentMode = UIViewContentModeScaleAspectFit;
    slot.image2.alpha = bgData.alpha;
    
    [self.view addSubview:slot.image1];
    [self.view addSubview:slot.image2];
    return slot;
    //[self.bgArray addObject:slot];

}

-(float) maxf:(float) a b:(float) b{
    return ( ((a) < (b)) ? (a) : (b) );
}

-(float) remapto01f:(float) low1 high1:(float) high1 value:(float) value{
    return 0.0 + (value - low1) * (1.0 - 0.0) / (high1 - low1);
}

- (CGPoint) subtractPoint:(CGPoint) p1 toPoint:(CGPoint) p2{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

@end

