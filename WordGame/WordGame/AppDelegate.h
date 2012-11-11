//
//  AppDelegate.h
//  WordGame
//
//  Created by Adam Jacaruso on 3/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer;

@end
