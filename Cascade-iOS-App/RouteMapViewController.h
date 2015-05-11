//
//  RouteMapViewController.h
//  Cascade-iOS-App
//
//  Created by iGuest on 4/28/15.
//  Copyright (c) 2015 Cascade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "DescriptionsViewController.h"

@interface RouteMapViewController : UIViewController<UIWebViewDelegate> {
    CGFloat selfViewWidth;
    CGFloat selfViewHeight;
    BOOL allowLoad;
}

@property (strong, nonatomic) DataManager *dm;
@property (strong) NSManagedObject *routedb;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIButton *resetButton;

@end
