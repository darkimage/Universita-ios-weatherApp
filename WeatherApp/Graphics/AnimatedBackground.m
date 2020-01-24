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
#import "NSValue+AnimBackgroundData.h"

@interface AnimatedBackground()
//PRIVATE PROPRIETIES
@property (nonatomic,strong) NSMutableArray* bgArray;
@property (nonatomic, strong) NSArray<NSValue*>* layers;
@property (nonatomic,weak) UIView*view;
@property UIColor* color;
@property BOOL hasGradient;
@property CAGradientLayer* gradientLayer;
@property UIView* gradientView;
@property CGFloat lastScrolledPos;

//HELPER FUNCTIONS
-(BackgroundLayer*) createSlotAndAddtoView:(NSValue*)bgData;
-(void) initInternal:(UIView*)view;
-(void) initWithColor:(UIColor*)color;
-(void) initWithGradient:(CAGradientLayer*)gradient;

//MATH FUNCTIONS
-(float) minF:(float) a b:(float) b;
-(float) remapto01f:(float) low1 high1:(float) high1 value:(float) value;
-(CGPoint) subtractPoint:(CGPoint) p1 toPoint:(CGPoint) p2;
@end

@implementation AnimatedBackground


#pragma mark - INIT METHODS
- (void)initInternal:(UIView*)view{
    self.view = view;
    self.parallaxMaxOffset = [NSNumber numberWithFloat:200.0];
    self.parallaxMultiplier = [NSNumber numberWithFloat:1.0];
    self.bgArray = [[NSMutableArray alloc]init];
}

-(void) initWithGradient:(CAGradientLayer*)gradient{
    self.hasGradient = YES;
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    self.gradientLayer.colors = gradient.colors;
    self.gradientLayer.frame = self.view.bounds;
    self.gradientView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.gradientView.layer insertSublayer:self.gradientLayer atIndex:0];
    self.gradientView.center = CGPointMake(self.view.bounds.size.width/2,self.view.bounds.size.height/2);
    [self.view addSubview: self.gradientView];
}

- (void)initWithColor:(UIColor *)color {
    self.color = color;
    self.view.backgroundColor = self.color;
}

- (instancetype)initWithStructDataArray:(NSArray<NSValue*>*)bgDataArray withColor:(nonnull UIColor *)backgroundColor addTo:(nullable UIView *)view {
    self = [super init];
    if (self) {
        [self initInternal:view];
        [self initWithColor:backgroundColor];
        self.layers = bgDataArray;
        [self applyToView:self.view];
    }
    return self;
}

- (instancetype)initWithStructDataArray:(NSArray<NSValue*>*)bgDataArray withGradient:(CAGradientLayer*)gradient addTo:(nullable UIView *)view {
    self = [super init];
    if (self) {
        [self initInternal:view];
        [self initWithGradient:gradient];
        self.layers = bgDataArray;
        [self applyToView:self.view];
    }
    return self;
}

-(instancetype) initWithStructData:(NSValue*)bgData withColor:(UIColor *)backgroundColor addTo:(nullable UIView *)view{
    self = [super init];
    if (self) {
        [self initInternal:view];
        [self initWithColor:backgroundColor];
        self.layers = [[NSArray<NSValue*> alloc] initWithObjects:bgData, nil];
        [self applyToView:self.view];
    }
    return self;
}

-(instancetype) initWithStructData:(nullable NSValue*)bgData withGradient:(CAGradientLayer*)gradient addTo:(nullable UIView*)view{
    self = [super init];
    if (self) {
        [self initInternal:view];
        [self initWithGradient:gradient];
        self.layers = [[NSArray<NSValue*> alloc] initWithObjects:bgData, nil];
        [self applyToView:self.view];
    }
    return self;
}

#pragma mark - WeatherViewDelegate
- (void)onScrollViewDidScroll:(nonnull UIScrollView *)scrollView {
    NSInteger index = 0;
    CGFloat deltaScroll = self.lastScrolledPos - scrollView.contentOffset.y;
    for (BackgroundLayer* slot in self.bgArray) {
        if([slot.bgData animDataValue].allowScroll){
            float parallaxlayer = (float)[self.bgArray count] - (float)index; //Layer attuale nell array (inverso rispetto ad ordine nell'array)
            float percent = parallaxlayer*1./[self.bgArray count];            //percentuale dell'attuale layer
            float offset = [self remapto01f:0.0 high1:200.0 value:[self minF:scrollView.contentOffset.y b:200.0]]*percent; //offset del parallax
            //- scrollView.contentOffset.y
            slot.image1.center = CGPointMake(slot.image1.center.x,slot.image1Start.y - scrollView.contentOffset.y - self.parallaxMaxOffset.floatValue*offset*self.parallaxMultiplier.floatValue);
            slot.image2.center = CGPointMake(slot.image2.center.x,slot.image2Start.y - scrollView.contentOffset.y - self.parallaxMaxOffset.floatValue*offset*self.parallaxMultiplier.floatValue);
        }
        index++;
    }
    if(self.hasGradient){
        for (int i=0; i<2; i++) {
            self.gradientLayer.startPoint = CGPointMake(0, [self remapto01f:0.0 high1:1 value:self.gradientLayer.startPoint.y + deltaScroll*0.001]);
            self.gradientLayer.endPoint = CGPointMake(0, [self remapto01f:0.0 high1:1 value:self.gradientLayer.endPoint.y + deltaScroll*0.001]);
        }
    }
    self.lastScrolledPos = scrollView.contentOffset.y;
}

- (void)animate {
    int i = 0;
    for (BackgroundLayer* slot in self.bgArray) {
        [UIView animateWithDuration:[slot.bgData animDataValue].duration delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
            if([slot.bgData animDataValue].animation != NULL){
                [slot.bgData animDataValue].animation(slot.image1,slot.image2);
            }
        } completion:nil];
        i++;
    }
}



#pragma mark - StateBoundDelegate
- (void)restoreState{
    [UIView setAnimationsEnabled:YES];
    for (BackgroundLayer* slot in self.bgArray) {
        [slot restoreState];
    }
    [self animate];
}

- (void)saveState{
    for (BackgroundLayer* slot in self.bgArray) {
        [slot saveState];
    }
}

#pragma mark - PUBLIC METHODS
-(void) addBackgroundToFront:(NSValue*)bgData{
    BackgroundLayer* nslot = [self createSlotAndAddtoView:bgData];
    [self.bgArray insertObject:nslot atIndex:0];
    [self sortSubViews];
}

-(void) addBackgroundToBack:(NSValue*)bgData{
    BackgroundLayer* nslot = [self createSlotAndAddtoView:bgData];
    [self.bgArray addObject:nslot];
    [self sortSubViews];
}

- (void)applyToView:(nullable UIView *)view {
    if(self.view){
        for (NSValue* layer in self.layers) {
            [self addBackgroundToBack:layer];
        }
        if(self.hasGradient){
            [self.view sendSubviewToBack:self.gradientView];
        }
    }
}

-(void) transitionTo:(AnimatedBackground*)newBackground{
    [UIView animateWithDuration:3.0f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        for (BackgroundLayer* slot in self.bgArray) {
            slot.viewLayer.alpha = 1.0f;
        }
    } completion:^(BOOL complete){
        for (BackgroundLayer* slot in self.bgArray) {
            [slot.viewLayer performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
        }
        self.layers = [newBackground getLayerData];
        self.bgArray = [[NSMutableArray alloc]init];
        [self applyToView:self.view];
        for (BackgroundLayer* slot in self.bgArray) {
            slot.viewLayer.alpha = 0.0f;
        }
     [self animate];
        [UIView animateWithDuration:3.0f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.gradientLayer.colors = [newBackground getGradient].colors;
            for (BackgroundLayer* slot in self.bgArray) {
                slot.viewLayer.alpha = 1.0f;
            }
        } completion:NULL];
    }];
}

-(CAGradientLayer*) getGradient{
    return self.gradientLayer;
}

-(NSArray<NSValue*>*) getLayerData{
    return self.layers;
}

#pragma mark - PRIVATE METHODS
-(void) addBackground:(NSValue*)bgData atPosition:(NSInteger)index{
    BackgroundLayer* nslot = [self createSlotAndAddtoView:bgData];
    [self.bgArray insertObject:nslot atIndex:index];
    [self sortSubViews];
}

-(void) sortSubViews{
    for (BackgroundLayer* slot in self.bgArray) {
        [self.view sendSubviewToBack:slot.viewLayer];
    }
}

-(BackgroundLayer*) createSlotAndAddtoView:(NSValue*)bgData{
    BackgroundLayer* slot = [[BackgroundLayer alloc]initWithData:bgData andSize:self.view.bounds];
    [self.view addSubview:slot.viewLayer];
    return slot;
}

-(float) minF:(float) a b:(float) b{
    return ( ((a) < (b)) ? (a) : (b) );
}

-(float) remapto01f:(float) low1 high1:(float) high1 value:(float) value{
    return 0.0 + (value - low1) * (1.0 - 0.0) / (high1 - low1);
}

- (CGPoint) subtractPoint:(CGPoint) p1 toPoint:(CGPoint) p2{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

@end

