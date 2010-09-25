//
//  SwipeWheel_ExampleAppDelegate.h
//  SwipeWheel Example
//
//  Created by Olivier on 25/09/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeWheel.h"

@interface SwipeWheel_ExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow* window;
	
	IBOutlet SwipeWheel* colorWheel;
	IBOutlet SwipeWheel* sizeWheel;
	IBOutlet UILabel* exampleLabel;
}
@property (nonatomic, retain) IBOutlet UIWindow* window;
-(IBAction)colorWheelChanged;
-(IBAction)sizeWheelChanged;
@end

