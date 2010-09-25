//
//  SwipeWheel.h
//  Test-SandBox
//
//  Created by Olivier on 24/09/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SwipeWheel : UIControl<UIScrollViewDelegate> {
	UIScrollView* _scrollView;
	CAGradientLayer* _leftGradient;
	CAGradientLayer* _rightGradient;
}

@property(nonatomic, retain) NSArray* texts;
@property(nonatomic, retain) UIFont*  itemsFont;
@property(nonatomic, retain) UIColor* itemsTextColor;
@property(nonatomic, retain) UIColor* itemsBorderColor;
@property(nonatomic, assign) CGFloat  itemsBorderWidth;

@property(nonatomic, assign) CGFloat margins;
@property(nonatomic, assign) BOOL activeMargins; //!< If true, tapping in the margins change the current page
@property(nonatomic, retain) UIColor* fadingColor; //!< For the gradient in the margins to fade previous and next items
@property(nonatomic, retain) CALayer* selectionIndicatorLayer; //!< For customisation, or showing/hiding it, etc.

@property(nonatomic, assign) NSInteger currentPage; //!< The index of the active page
-(IBAction)previousPage;
-(IBAction)nextPage;
@end

