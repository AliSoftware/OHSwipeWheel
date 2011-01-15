//
//  SwipeWheel_ExampleAppDelegate.h
//  SwipeWheel Example
//
//  Created by Olivier on 25/09/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHSwipeWheel.h"

@interface SwipeWheel_ExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
	
	IBOutlet OHSwipeWheel* colorWheel;
	IBOutlet OHSwipeWheel* sizeWheel;
	IBOutlet UILabel* exampleLabel;
}
@property (nonatomic, retain) IBOutlet UIWindow* window;
-(IBAction)colorWheelChanged;
-(IBAction)sizeWheelChanged;
@end

