//
//  SwipeWheel_ExampleAppDelegate.m
//  SwipeWheel Example
//
//  Created by Olivier on 25/09/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import "SwipeWheel_ExampleAppDelegate.h"

@implementation SwipeWheel_ExampleAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	colorWheel.texts = [NSArray arrayWithObjects:@"Noir",@"Rouge",@"Vert",@"Bleu",@"Orange",@"Violet",nil];
	colorWheel.selectionIndicatorLayer.hidden = YES;
	colorWheel.itemsTextColor = [UIColor blackColor];
	
	sizeWheel.texts = [NSArray arrayWithObjects:@"9",@"10",@"12",@"14",@"18",@"24",@"36",nil];
	sizeWheel.itemsFont = [UIFont systemFontOfSize:18];
	sizeWheel.itemsTextColor = [UIColor blueColor];
	sizeWheel.currentPage = 2; // 12pt
	sizeWheel.selectionIndicatorLayer.borderWidth = 2;
	sizeWheel.selectionIndicatorLayer.borderColor = [UIColor blueColor].CGColor;
	sizeWheel.fadingColor = [UIColor grayColor];
	
    [window makeKeyAndVisible];
    return YES;
}

-(IBAction)colorWheelChanged {
	UIColor* colors[] = {[UIColor blackColor],[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor orangeColor],[UIColor purpleColor]};
	UIColor* color = colors[colorWheel.currentPage];
	exampleLabel.textColor = color;
}
-(IBAction)sizeWheelChanged {
	CGFloat sizes[] = {9,10,12,14,18,24,36};
	CGFloat sz = sizes[sizeWheel.currentPage];
	exampleLabel.font = [UIFont systemFontOfSize:sz];
}



- (void)dealloc {
    [window release];
    [super dealloc];
}

@end
