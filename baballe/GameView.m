//
//  GameView.m
//  baballe
//
//  Created by Renaud Pradenc on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"

@implementation GameView
@synthesize distanceLabel;
@synthesize distance;
@synthesize elevation;
@synthesize isRising;
@synthesize level;

#define GROUND_HEIGHT 80.0
#define SCREEN_HEIGHT 320.0
#define SCREEN_WIDTH 480.0
#define BALL_SIZE 42.0
#define BALL_X_OFFSET 20.0
#define BALL_SPEED 3
#define OBSTACLE_HEIGHT 70.0
#define OBSTACLE_WIDTH 20.0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.level = @"|___________|________|______________________|___________________|________";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.level = @"|___________|________|______________________|___________________|________";
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(isRising && self.elevation<SCREEN_HEIGHT- GROUND_HEIGHT - BALL_SIZE)
    {
        self.elevation+=BALL_SPEED;
    }
    else if(self.elevation>0)
    {
        self.elevation-=BALL_SPEED;
    }
    CGRect ground = CGRectMake(0, SCREEN_HEIGHT - GROUND_HEIGHT, SCREEN_WIDTH, GROUND_HEIGHT);
    [[UIColor greenColor] set];
    UIRectFill(ground);
    
    CGRect sky = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - GROUND_HEIGHT);
    [[UIColor blueColor] set];
    UIRectFill(sky);
    
    CGRect ball = CGRectMake(BALL_X_OFFSET, SCREEN_HEIGHT - GROUND_HEIGHT - BALL_SIZE - self.elevation, BALL_SIZE, BALL_SIZE);
    [[UIColor redColor] set];
    UIBezierPath *ballPath = [UIBezierPath bezierPathWithOvalInRect:ball];
    [ballPath fill];
    
    BOOL boom = NO;
    for (int i = 0; i <24; i++) {
        int iDistance = (int)distance;
        float offset = distance-iDistance;
        
        int iPosition = (iDistance + i)%[self.level length];
        if([self.level characterAtIndex:iPosition] == '|')
        {
            CGRect obstacle = CGRectMake((i-offset)*OBSTACLE_WIDTH, SCREEN_HEIGHT - GROUND_HEIGHT - OBSTACLE_HEIGHT, OBSTACLE_WIDTH, OBSTACLE_HEIGHT);
            [[UIColor purpleColor] set];
            UIRectFill(obstacle);
            
            if(CGRectIntersectsRect(ball, obstacle))
               boom = YES;
        }
    }
    
    if(!boom)
        self.distance += 0.05;
    self.distanceLabel.text = [NSString stringWithFormat:@"%f", distance];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.elevation == 0) {
        self.isRising = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isRising = NO;
}

@end
