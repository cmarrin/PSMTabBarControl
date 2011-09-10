//
//  PSMSafariTabStyle.h
//  PSMTabBarControl
//
//  Created by Chris Marrin on 9/9/11.
//  Copyright 2011 Marrintech. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSMTabStyle.h"

@interface PSMSafariTabStyle : NSObject <PSMTabStyle> {
	NSImage* _closeButton;
	NSImage* _closeButtonDown;
	NSImage* _closeButtonOver;
	NSImage* _closeDirtyButton;
	NSImage* _closeDirtyButtonDown;
	NSImage* _closeDirtyButtonOver;
	NSImage* _addTabButtonImage;
	NSImage* _addTabButtonPressedImage;
	NSImage* _addTabButtonRolloverImage;

	NSDictionary* _objectCountStringAttributes;

	PSMTabBarOrientation orientation;
	PSMTabBarControl* tabBar;
}

- (void)drawInteriorWithTabCell:(PSMTabBarCell *)cell inView:(NSView*)controlView;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
