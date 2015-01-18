//
//  MainViewController.h
//  W2W
//
//  Created by Kyle Koser on 1/17/15.
//  Copyright (c) 2015 Kyle Koser. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MainViewController : NSViewController
- (IBAction)open:(id)sender;
@property (weak) IBOutlet WebView *webView;

@end
