//
//  EpomAdsPlugin.m
//  http://www.cahri.com
//
//  Created by jef on 06/06/13.
//
//

#import "EpomAdsPlugin.h"
#import "ESBannerView.h"
#import "ESInterstitialView.h"
#import "ESUtils.h"

#import <Cordova/CDV.h>

@implementation EpomAdsPlugin

@synthesize bannerView = bannerView_;
@synthesize interView = interView_;

#pragma mark ESInterstitialView
- (void)createInterstitial:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *callbackId = command.callbackId;
    
    NSString* key = [command.arguments objectAtIndex:0];
    
    // [ESUtils setLogLevel:ESVerboseAll];
    
    self.interView = [[ESInterstitialView alloc] initWithID:key
                                                useLocation:NO testMode:NO];
    
    self.interView.delegate = self;
    
    // Call the success callback that was passed in through the javascript.
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark ESInterstitialViewDelegate
-(void)esInterstitialViewDidFailLoadAd:(ESInterstitialView *)esInterstitial {
    [super writeJavascript:@"window.plugins.epomAds._didFailInter();"];
    // just release object
    [self.interView release];
}

-(void)esInterstitialViewDidLoadAd:(ESInterstitialView *)esInterstitial {
    // present esInterstitial with current view controller
    [self.interView presentWithViewController:self.viewController];

    [super writeJavascript:@"window.plugins.epomAds._willShowInter();"];
    
    // fix cross overlaping statusbar
    for (UIView* subview in self.viewController.presentedViewController.view.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y+15, subview.frame.size.width , subview.frame.size.height)];
        }
    }
    [self performSelector:@selector(hideIntersitial) withObject:Nil afterDelay:5];
}

-(void) hideIntersitial {
    [self.viewController dismissViewControllerAnimated:YES completion:^{}];
}

-(void)esInterstitialViewDidLeaveModalMode:(ESInterstitialView *)esInterstitial {
    [super writeJavascript:@"window.plugins.epomAds._didLeaveInter();"];
    // Interstitial is done. Release it
    [self.interView release];
}

#pragma mark ESBannerView
- (void)createBanner:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *callbackId = command.callbackId;

    NSString* key = [command.arguments objectAtIndex:0];
    NSString* interval = [command.arguments objectAtIndex:1];
    NSString* top = [command.arguments objectAtIndex:2];

    self.bannerView = [[ESBannerView alloc] initWithID:key sizeType:ESBannerViewSize320x50
                                    modalViewController:self.viewController useLocation:NO
                                               testMode:NO];
    
    self.bannerView.refreshTimeInterval = [interval floatValue];
    [self.bannerView setFrame:CGRectMake(0, [top intValue], 320, 50)];
    self.bannerView.delegate = self;
    
    [self.viewController.view addSubview:self.bannerView];
    
    // Call the success callback that was passed in through the javascript.
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

#pragma mark ESBannerViewDelegate
- (void) esBannerViewWillShowAd:(ESBannerView *)esBannerView
{
    [super writeJavascript:@"window.plugins.epomAds._willShowAd();"];
}

#pragma mark DestroyBanner
- (void) destroyBanner:(CDVInvokedUrlCommand *)command {
    for (UIView* subview in self.viewController.view.subviews)
    {
        if ([subview isKindOfClass:[ESBannerView class]])
        {
            [subview setHidden:YES];
            [subview removeFromSuperview];
            subview = nil;
        }
    }
    
}


@end
