//
//  ESBannerView.h
//  Epom SDK
//
//  Created by Epom LTD on 5/29/12.
//  Copyright (c) 2012 Epom LTD. All rights reserved.
//
//	EpomSDK BannerView class (ESBannerView)

#import <UIKit/UIKit.h>

#import "ESEnumerations.h"
#import "ESBannerViewDelegate.h"

// UIView-based class for retrieving and visualising banner advertisements
@interface ESBannerView : UIView

// delegate accessor
@property (readwrite, assign) id<ESBannerViewDelegate> delegate;

// refresh time interval accessor. Default value is 15 seconds. Minimal - 5 seconds
@property (readwrite, assign) NSTimeInterval refreshTimeInterval;

// custom parameters for ad requests
@property (readwrite, retain) NSDictionary *customParameters;

// prefer external browser instead of in-app while opening landing pages, if possible. Default value is "NO
@property (readwrite, assign) BOOL preferExternalBrowser;

// Initializes a ESBannerView with specified id, size type, view controller for presenting
// modal views, optional force determining of user location and test mode enabled
-(id)initWithID:(NSString*)ID
	   sizeType:(ESBannerViewSizeType)size
modalViewController:(UIViewController *)modalViewController
	useLocation:(BOOL)doUseLocation
	   testMode:(BOOL)testMode;

@end
