//
//  EpomAdsPlugin.h
//  http://www.cahri.com
//
//  Created by jef on 06/06/13.
//
//

#import <Cordova/CDV.h>
#import "ESBannerViewDelegate.h"
#import "ESInterstitialViewDelegate.h"

@class ESBannerView;
@class ESInterstitialView;

@interface EpomAdsPlugin : CDVPlugin <ESBannerViewDelegate, ESInterstitialViewDelegate>;

@property(nonatomic, retain) ESBannerView *bannerView;
@property(nonatomic, retain) ESInterstitialView *interView;

- (void)createBanner:(CDVInvokedUrlCommand *)command;
- (void)createInterstitial:(CDVInvokedUrlCommand *)command;

@end
