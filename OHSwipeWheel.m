//
//  OHSwipeWheel.m
//  Test-SandBox
//
//  Created by Olivier on 24/09/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import "OHSwipeWheel.h"

@interface OHSwipeWheel()
-(void)configureView;
@end


@implementation OHSwipeWheel

-(void)configureView {
	// ScrollView
	_scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
	_scrollView.pagingEnabled = YES;
	_scrollView.showsVerticalScrollIndicator = NO;
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.bounces = YES;
	_scrollView.alwaysBounceHorizontal = YES;
	_scrollView.clipsToBounds = NO;
	_scrollView.delegate = self;
	self.clipsToBounds = YES;
	[self addSubview:_scrollView];
	
	
	// Margin Gradients & Layers
	NSArray* colors = [NSArray arrayWithObjects:(id)self.fadingColor.CGColor, (id)[UIColor clearColor].CGColor, nil];
	_leftGradient = [[CAGradientLayer layer] retain];
	_leftGradient.colors = colors;
	_leftGradient.startPoint = CGPointMake(0.f, 0.5f);
	_leftGradient.endPoint = CGPointMake(1.f, 0.5f);
	[self.layer addSublayer:_leftGradient];
	
	_rightGradient = [[CAGradientLayer layer] retain];
	_rightGradient.colors = colors;
	_rightGradient.startPoint = CGPointMake(1.f, 0.5f);
	_rightGradient.endPoint = CGPointMake(0.f, 0.5f);
	[self.layer addSublayer:_rightGradient];
	
	self.selectionIndicatorLayer = [CALayer layer];
	[self.layer addSublayer:self.selectionIndicatorLayer];
	
	// Default values
	self.currentPage = 0;
	self.margins = 20;
	self.selectionIndicatorLayer.borderColor = [UIColor grayColor].CGColor;
	self.selectionIndicatorLayer.borderWidth = 1.f;
	self.selectionIndicatorLayer.backgroundColor = [UIColor colorWithRed:0.7f green:0.7f blue:1.f alpha:0.3f].CGColor;
	self.fadingColor = [UIColor blackColor];
	self.layer.borderColor = [UIColor blackColor].CGColor;
	self.layer.borderWidth = 1.f;
	self.itemsFont = [UIFont systemFontOfSize:14];
	self.itemsTextColor = [UIColor whiteColor];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	if (nil != (self = [super initWithCoder:aDecoder])) {
		[self configureView];
	}
	return self;
}
-(id)initWithFrame:(CGRect)frame {
	if (nil != (self = [super initWithFrame:frame])) {
		[self configureView];
	}
	return self;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	CGRect newFrame = CGRectInset(self.bounds, self.margins, 0.f);
	if (!CGRectEqualToRect(newFrame, _scrollView.frame)) {
		// must do this check for bouncing to still work
		_scrollView.frame = newFrame;
		_scrollView.contentOffset = CGPointMake(self.currentPage*_scrollView.bounds.size.width, 0);
	}
	
	CGSize sz = _scrollView.bounds.size;
	NSInteger idx = 0;
	for(UIView* v in [_scrollView subviews]) {
		v.frame = CGRectInset( CGRectMake(sz.width*idx, 0, sz.width, sz.height) , 3,3);
		++idx;
	}
	_scrollView.contentSize = CGSizeMake(sz.width*[[_scrollView subviews] count], sz.height);
	
	_leftGradient.frame = CGRectMake(0, 0, self.margins, self.bounds.size.height);
	_rightGradient.frame = CGRectMake(self.bounds.size.width-self.margins, 0, self.margins, self.bounds.size.height);
	self.selectionIndicatorLayer.frame = _scrollView.frame;
}

-(void)dealloc {
	[_scrollView release];
	[_leftGradient release];
	[_rightGradient release];
	
	self.texts = nil;
	self.itemsFont = nil;
	self.itemsTextColor = nil;
	self.itemsBorderColor = nil;
	self.fadingColor = nil;
	self.selectionIndicatorLayer = nil;
	
	[super dealloc];
}



/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Accessors
/////////////////////////////////////////////////////////////////////////////

@synthesize itemsFont = _itemsFont;
-(void)setItemsFont:(UIFont *)newFont {
	if (_itemsFont == newFont) return;
	[_itemsFont release];
	_itemsFont = [newFont retain];
	for(UILabel* lbl in [_scrollView subviews]) {
		lbl.font = newFont;
	}
}
@synthesize itemsTextColor = _itemsTextColor;
-(void)setItemsTextColor:(UIColor *)newColor {
	if (_itemsTextColor == newColor) return;
	[_itemsTextColor release];
	_itemsTextColor = [newColor retain];
	for(UILabel* lbl in [_scrollView subviews]) {
		lbl.textColor = newColor;
	}
}


@synthesize texts = _texts;
-(void)setTexts:(NSArray *)newTexts {
	if (_texts == newTexts) return;
	
	[self willChangeValueForKey:@"texts"];
	[_texts release];
	_texts = [newTexts retain];
	
	while ([[_scrollView subviews] count]>0)
		[[[_scrollView subviews] objectAtIndex:0] removeFromSuperview];
	
	int nbPages = [newTexts count];
	for(int i=0;i<nbPages;i++) {
		UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectZero];
		lbl.text = [_texts objectAtIndex:i];
		lbl.font = self.itemsFont;
		lbl.textColor = self.itemsTextColor;
		lbl.numberOfLines = 10;
		lbl.textAlignment = UITextAlignmentCenter;
		lbl.backgroundColor = [UIColor clearColor];
		lbl.layer.borderColor = self.itemsBorderColor.CGColor;
		lbl.layer.borderWidth = self.itemsBorderWidth;
		
		[_scrollView addSubview:lbl];
		
		[lbl release];
	}
	CGSize sz = _scrollView.bounds.size;
	_scrollView.contentSize = CGSizeMake(sz.width*[_texts count], sz.height);
	[self didChangeValueForKey:@"texts"];
}

/////////////////////////////////////////////////////////////////////////////

@synthesize currentPage = _currentPage;
-(void)setCurrentPage:(NSInteger)newPage {
	if (newPage>=[_texts count]) newPage = ([_texts count]>0)?[_texts count]-1:0;
	if (newPage<0) newPage = 0;
	
	if (newPage == _currentPage) return;
	
	[self willChangeValueForKey:@"currentPage"];
	_currentPage = newPage;
	[_scrollView setContentOffset:CGPointMake(newPage*_scrollView.bounds.size.width, 0) animated:YES];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	[self didChangeValueForKey:@"currentPage"];
}
-(IBAction)previousPage {
	if (self.currentPage>0)
		[self setCurrentPage:self.currentPage-1];
}
-(IBAction)nextPage {
	[self setCurrentPage:self.currentPage+1];
}

/////////////////////////////////////////////////////////////////////////////

@synthesize margins = _margins;
-(void)setMargins:(CGFloat)newMargins {
	_margins = newMargins;
	[self setNeedsLayout];
}

/////////////////////////////////////////////////////////////////////////////

@synthesize selectionIndicatorLayer;

@synthesize itemsBorderColor = _itemsBorderColor;
-(void)setItemsBorderColor:(UIColor *)clr {
	if (_itemsBorderColor == clr) return;
	[_itemsBorderColor release];
	_itemsBorderColor = [clr retain];
	for(UIView* v in [_scrollView subviews]) {
		v.layer.borderColor = clr.CGColor;
	}
}
@synthesize itemsBorderWidth = _itemsBorderWidth;
-(void)setItemsBorderWidth:(CGFloat)w {
	_itemsBorderWidth = w;
	for(UIView* v in [_scrollView subviews]) {
		v.layer.borderWidth = w;
	}
}

@synthesize fadingColor = _fadingColor;
-(void)setFadingColor:(UIColor *)clr {
	if (_fadingColor == clr) return;
	[_fadingColor release];
	_fadingColor = [clr retain];
	_leftGradient.colors = [NSArray arrayWithObjects:(id)clr.CGColor,(id)[UIColor clearColor].CGColor,nil];
	_rightGradient.colors = [NSArray arrayWithObjects:(id)clr.CGColor,(id)[UIColor clearColor].CGColor,nil];
	[self setNeedsDisplay];
}



/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Touches to change page
/////////////////////////////////////////////////////////////////////////////


- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
	CGFloat w = _scrollView.bounds.size.width;
	[self willChangeValueForKey:@"currentPage"];	
	_currentPage = roundf(_scrollView.contentOffset.x / w);
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	[self didChangeValueForKey:@"currentPage"];
}

@synthesize activeMargins;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.activeMargins) return;
	UITouch* touch = [touches anyObject];
	CGPoint loc = [touch locationInView:self];
	if (loc.x<self.bounds.size.width/2) {
		[self previousPage];
	} else if (loc.x>self.bounds.size.height-_margins) {
		[self nextPage];
	}
}

@end
