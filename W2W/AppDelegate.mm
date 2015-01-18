//
//  AppDelegate.m
//  W2W
//
//  Created by Kyle Koser on 1/17/15.
//  Copyright (c) 2015 Kyle Koser. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainViewController.h"
#import "Analyzer.h"
#import <WebKit/WebKit.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
//@property (nonatomic, strong) MainViewController *vc;
@property (weak) IBOutlet WebView *webView;
@property (strong) NSString *htmlStr;

@end

@implementation AppDelegate
- (IBAction)saveFile:(id)sender {
    if (![self.htmlStr isEqualToString:@""]) {
        NSSavePanel *panel = [NSSavePanel savePanel];
        [panel setMessage:@"Please select a path where to save checkboard as an image."];
        
        NSInteger clicked = [panel runModal];
        
        if (clicked == NSFileHandlingPanelOKButton) {
            NSURL *file = [panel URL];
            NSError *err;
            bool success = [self.htmlStr writeToFile:[file path] atomically:NO encoding:NSUTF8StringEncoding error:&err];
            if (err || !success) {
                NSLog(@"Had an error");
                [NSApp presentError:err];
            }
        }
        
        
    }
}
- (IBAction)openFile:(id)sender {
    NSLog(@"Im opening a file from the menu!");
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.allowsMultipleSelection = NO;
    panel.canChooseDirectories = NO;
    panel.canChooseFiles = YES;
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        NSURL *file = [[panel URLs] firstObject];
        Analyzer *an = new Analyzer(std::string(file.fileSystemRepresentation));
        Page p = an->createPage();
        std::string html = p.generateHTML();
        self.webView.hidden = NO;
        self.htmlStr = @(html.c_str());
        [[self.webView mainFrame] loadHTMLString:self.htmlStr baseURL:nil];
        [self.window setContentView:self.webView];
        
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    self.vc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    self.window.contentView = self.vc.view;
//    self.vc.view.frame = ((NSView*)self.window.contentView).bounds;

    //[vc becomeFirstResponder];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
