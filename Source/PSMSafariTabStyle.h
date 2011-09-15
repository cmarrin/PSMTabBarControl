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
	NSDictionary* _objectCountStringAttributes;

	PSMTabBarOrientation orientation;
	PSMTabBarControl* tabBar;
}

- (void)drawInteriorWithTabCell:(PSMTabBarCell *)cell inView:(NSView*)controlView;

@end
