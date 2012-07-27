//
//  GameView.h
//  baballe
//
//  Created by Renaud Pradenc on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property float distance;
@property BOOL isRising;
@property NSInteger elevation;
@property (strong, nonatomic) NSString* level;

@end
