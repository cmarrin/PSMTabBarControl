//
//  PSMSafariTabStyle.h
//  PSMTabBarControl
//
//  Created by Chris Marrin on 9/9/11.
//  Copyright 2011 Marrintech. All rights reserved.
//

#import "PSMSafariTabStyle.h"
#import "PSMTabBarCell.h"
#import "PSMTabBarControl.h"

#define kPSMObjectCounterRadius 7.0
#define kPSMCounterMinWidth 20

@implementation PSMSafariTabStyle

#define StaticImage(name) \
static NSImage* _static##name##Image() \
{ \
    static NSImage* image = nil; \
    if (!image) \
        image = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@#name]]; \
    return image; \
}

StaticImage(TabClose_Front)
StaticImage(TabClose_Front_Pressed)
StaticImage(TabClose_Front_Rollover)
StaticImage(TabClose_Dirty)
StaticImage(TabClose_Dirty_Pressed)
StaticImage(TabClose_Dirty_Rollover)
StaticImage(TabNew)
StaticImage(TabNew_Pressed)
StaticImage(TabNew_Rollover)
StaticImage(SafariAWATFill)
StaticImage(SafariAWATLeftCap)
StaticImage(SafariAWATRightCap)
StaticImage(SafariAWBG)
StaticImage(SafariAWITLeftCap)
StaticImage(SafariAWITRightCap)
StaticImage(SafariIWATFill)
StaticImage(SafariIWATLeftCap)
StaticImage(SafariIWATRightCap)
StaticImage(SafariIWBG)
StaticImage(SafariIWITLeftCap)
StaticImage(SafariIWITRightCap)

- (NSString *)name {
	return @"Safari";
}

#pragma mark -
#pragma mark Creation/Destruction

- (id) init {
	if((self = [super init])) {
		_objectCountStringAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSFontManager sharedFontManager] convertFont:[NSFont fontWithName:@"Helvetica" size:11.0] toHaveTrait:NSBoldFontMask], NSFontAttributeName,
										[[NSColor whiteColor] colorWithAlphaComponent:0.85], NSForegroundColorAttributeName,
										nil, nil];
	}
	return self;
}

- (void)dealloc {
	[_objectCountStringAttributes release];

	[super dealloc];
}

#pragma mark -
#pragma mark Control Specific

- (CGFloat)leftMarginForTabBarControl {
	return 6.0f;
}

- (CGFloat)rightMarginForTabBarControl {
	return 24.0f;
}

- (CGFloat)topMarginForTabBarControl {
	return 10.0f;
}

- (void)setOrientation:(PSMTabBarOrientation)value {
	orientation = value;
}

#pragma mark -
#pragma mark Add Tab Button

- (NSImage *)addTabButtonImage {
	return _staticTabNewImage();
}

- (NSImage *)addTabButtonPressedImage {
	return _staticTabNew_PressedImage();
}

- (NSImage *)addTabButtonRolloverImage {
	return _staticTabNew_RolloverImage();
}

#pragma mark -
#pragma mark Cell Specific

- (NSRect)dragRectForTabCell:(PSMTabBarCell *)cell orientation:(PSMTabBarOrientation)tabOrientation {
	NSRect dragRect = [cell frame];
	dragRect.size.width++;

	if([cell tabState] & PSMTab_SelectedMask) {
		if(tabOrientation == PSMTabBarHorizontalOrientation) {
			dragRect.size.height -= 2.0;
		} else {
			dragRect.size.height += 1.0;
			dragRect.origin.y -= 1.0;
			dragRect.origin.x += 2.0;
			dragRect.size.width -= 3.0;
		}
	} else if(tabOrientation == PSMTabBarVerticalOrientation) {
		dragRect.origin.x--;
	}

	return dragRect;
}

- (NSRect)closeButtonRectForTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)cellFrame {
	if([cell hasCloseButton] == NO) {
		return NSZeroRect;
	}

	NSRect result;
	result.size = [_staticTabClose_FrontImage() size];
	result.origin.x = cellFrame.origin.x + MARGIN_X;
	result.origin.y = cellFrame.origin.y + MARGIN_Y + 2.0;

	if([cell state] == NSOnState) {
		result.origin.y -= 1;
	}

	return result;
}

- (NSRect)iconRectForTabCell:(PSMTabBarCell *)cell {
	NSRect cellFrame = [cell frame];

	if([cell hasIcon] == NO) {
		return NSZeroRect;
	}

	NSRect result;
	result.size = NSMakeSize(kPSMTabBarIconWidth, kPSMTabBarIconWidth);
	result.origin.x = cellFrame.origin.x + MARGIN_X;
	result.origin.y = cellFrame.origin.y + MARGIN_Y;

	if([cell hasCloseButton] && ![cell isCloseButtonSuppressed]) {
		result.origin.x += [_staticTabClose_FrontImage() size].width + kPSMTabBarCellPadding;
	}

	if([cell state] == NSOnState) {
		result.origin.y -= 1;
	}

	return result;
}

- (NSRect)indicatorRectForTabCell:(PSMTabBarCell *)cell {
	NSRect cellFrame = [cell frame];

	if([[cell indicator] isHidden]) {
		return NSZeroRect;
	}

	NSRect result;
	result.size = NSMakeSize(kPSMTabBarIndicatorWidth, kPSMTabBarIndicatorWidth);
	result.origin.x = cellFrame.origin.x + cellFrame.size.width - MARGIN_X - kPSMTabBarIndicatorWidth;
	result.origin.y = cellFrame.origin.y + MARGIN_Y;

	if([cell state] == NSOnState) {
		result.origin.y -= 1;
	}

	return result;
}

- (NSRect)objectCounterRectForTabCell:(PSMTabBarCell *)cell {
	NSRect cellFrame = [cell frame];

	if([cell count] == 0) {
		return NSZeroRect;
	}

	CGFloat countWidth = [[self attributedObjectCountValueForTabCell:cell] size].width;
	countWidth += (2 * kPSMObjectCounterRadius - 6.0);
	if(countWidth < kPSMCounterMinWidth) {
		countWidth = kPSMCounterMinWidth;
	}

	NSRect result;
	result.size = NSMakeSize(countWidth, 2 * kPSMObjectCounterRadius); // temp
	result.origin.x = cellFrame.origin.x + cellFrame.size.width - MARGIN_X - result.size.width;
	result.origin.y = cellFrame.origin.y + MARGIN_Y + 1.0;

	if(![[cell indicator] isHidden]) {
		result.origin.x -= kPSMTabBarIndicatorWidth + kPSMTabBarCellPadding;
	}

	return result;
}


- (CGFloat)minimumWidthOfTabCell:(PSMTabBarCell *)cell {
	CGFloat resultWidth = 0.0;

	// left margin
	resultWidth = MARGIN_X;

	// close button?
	if([cell hasCloseButton] && ![cell isCloseButtonSuppressed]) {
		resultWidth += [_staticTabClose_FrontImage() size].width + kPSMTabBarCellPadding;
	}

	// icon?
	if([cell hasIcon]) {
		resultWidth += kPSMTabBarIconWidth + kPSMTabBarCellPadding;
	}

	// the label
	resultWidth += kPSMMinimumTitleWidth;

	// object counter?
	if([cell count] > 0) {
		resultWidth += [self objectCounterRectForTabCell:cell].size.width + kPSMTabBarCellPadding;
	}

	// indicator?
	if([[cell indicator] isHidden] == NO) {
		resultWidth += kPSMTabBarCellPadding + kPSMTabBarIndicatorWidth;
	}

	// right margin
	resultWidth += MARGIN_X;

	return ceil(resultWidth);
}

- (CGFloat)desiredWidthOfTabCell:(PSMTabBarCell *)cell {
	CGFloat resultWidth = 0.0;

	// left margin
	resultWidth = MARGIN_X;

	// close button?
	if([cell hasCloseButton] && ![cell isCloseButtonSuppressed]) {
		resultWidth += [_staticTabClose_FrontImage() size].width + kPSMTabBarCellPadding;
	}

	// icon?
	if([cell hasIcon]) {
		resultWidth += kPSMTabBarIconWidth + kPSMTabBarCellPadding;
	}

	// the label
	resultWidth += [[cell attributedStringValue] size].width;

	// object counter?
	if([cell count] > 0) {
		resultWidth += [self objectCounterRectForTabCell:cell].size.width + kPSMTabBarCellPadding;
	}

	// indicator?
	if([[cell indicator] isHidden] == NO) {
		resultWidth += kPSMTabBarCellPadding + kPSMTabBarIndicatorWidth;
	}

	// right margin
	resultWidth += MARGIN_X;

	return ceil(resultWidth);
}

- (CGFloat)tabCellHeight {
	return kPSMTabBarControlHeight;
}

#pragma mark -
#pragma mark Cell Values

- (NSAttributedString *)attributedObjectCountValueForTabCell:(PSMTabBarCell *)cell {
	NSString *contents = [NSString stringWithFormat:@"%lu", (unsigned long)[cell count]];
	return [[[NSMutableAttributedString alloc] initWithString:contents attributes:_objectCountStringAttributes] autorelease];
}

- (NSAttributedString *)attributedStringValueForTabCell:(PSMTabBarCell *)cell {
	NSMutableAttributedString *attrStr;
	NSString *contents = [cell stringValue];
	attrStr = [[[NSMutableAttributedString alloc] initWithString:contents] autorelease];
	NSRange range = NSMakeRange(0, [contents length]);

	// Add font attribute
	[attrStr addAttribute:NSFontAttributeName value:[NSFont boldSystemFontOfSize:11.0] range:range];
	[attrStr addAttribute:NSForegroundColorAttributeName value:[[NSColor textColor] colorWithAlphaComponent:0.75] range:range];

	// Add shadow attribute
	CGFloat shadowAlpha;
	if(([cell state] == NSOnState) || [cell isHighlighted])
		shadowAlpha = 0.8;
	else
		shadowAlpha = 0.5;

    NSShadow* shadow = shadow = [[[NSShadow alloc] init] autorelease];
    [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:shadowAlpha]];
    [shadow setShadowOffset:NSMakeSize(0, -1)];
    [shadow setShadowBlurRadius:1.0];
    [attrStr addAttribute:NSShadowAttributeName value:shadow range:range];

	// Paragraph Style for Truncating Long Text
	static NSMutableParagraphStyle *TruncatingTailParagraphStyle = nil;
	if(!TruncatingTailParagraphStyle) {
		TruncatingTailParagraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] retain];
		[TruncatingTailParagraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
		[TruncatingTailParagraphStyle setAlignment:NSCenterTextAlignment];
	}
	[attrStr addAttribute:NSParagraphStyleAttributeName value:TruncatingTailParagraphStyle range:range];

	return attrStr;
}

#pragma mark -
#pragma mark ---- drawing ----

- (void)drawTabCell:(PSMTabBarCell *)cell {
    NSRect cellFrame = NSInsetRect([cell frame], -5, 0);
    
    
    if ([[cell controlView] frame].size.height < 2)
        return;
        
    NSImage* left = nil;
    NSImage* center = nil;
    NSImage* right = nil;
    
    if ([[[tabBar tabView] window] isKeyWindow]) {
        if ([cell state] == NSOnState) {
            left = _staticSafariAWATLeftCapImage();
            center = _staticSafariAWATFillImage();
            right = _staticSafariAWATRightCapImage();
        } else {
            if (![tabBar isFirstTab:cell]) {
                if ([tabBar isToRightOfSelectedTab:cell])
                    right = _staticSafariAWITRightCapImage();
                else
                    left = _staticSafariAWITLeftCapImage();
            }
        }
    } else {
        if ([cell state] == NSOnState) {
            left = _staticSafariIWATLeftCapImage();
            center = _staticSafariIWATFillImage();
            right = _staticSafariIWATRightCapImage();
        } else
            if (![tabBar isFirstTab:cell]) {
                if ([tabBar isToRightOfSelectedTab:cell])
                    right = _staticSafariIWITRightCapImage();
                else
                    left = _staticSafariIWITLeftCapImage();
            }
    }

    NSDrawThreePartImage(cellFrame, left, center, right, NO, NSCompositeSourceOver, 1, [tabBar isFlipped]);
    
    [self drawInteriorWithTabCell:cell inView:[cell controlView]];
}


- (void)drawInteriorWithTabCell:(PSMTabBarCell *)cell inView:(NSView*)controlView
{
    NSRect cellFrame = [cell frame];

    // close button
    if ([cell hasCloseButton] && ![cell isCloseButtonSuppressed] && ([cell isHighlighted] || ![tabBar onlyShowCloseOnHover])) {
        NSSize closeButtonSize = NSZeroSize;
        NSRect closeButtonRect = [cell closeButtonRectForFrame:cellFrame];
        NSImage *closeButton = nil;

        closeButton = [cell isEdited] ? _staticTabClose_DirtyImage() : _staticTabClose_FrontImage();
        if ([cell closeButtonOver]) closeButton = [cell isEdited] ? _staticTabClose_Dirty_RolloverImage() : _staticTabClose_Front_RolloverImage();
        if ([cell closeButtonPressed]) closeButton = [cell isEdited] ? _staticTabClose_Dirty_PressedImage() : _staticTabClose_Front_PressedImage();

        closeButtonSize = [closeButton size];
        if ([controlView isFlipped])
            closeButtonRect.origin.y += closeButtonRect.size.height;

        [closeButton compositeToPoint:closeButtonRect.origin operation:NSCompositeSourceOver fraction:1.0];
    }

    // icon
    if ([cell hasIcon]) {
        NSRect iconRect = [self iconRectForTabCell:cell];
        NSImage *icon = [[(NSTabViewItem*)[cell representedObject] identifier] icon];
          
        if ([controlView isFlipped])
            iconRect.origin.y += iconRect.size.height;
          
        // center in available space (in case icon image is smaller than kPSMTabBarIconWidth)
        if ([icon size].width < kPSMTabBarIconWidth)
            iconRect.origin.x += (kPSMTabBarIconWidth - [icon size].width)/2.0;

        if ([icon size].height < kPSMTabBarIconWidth)
            iconRect.origin.y -= (kPSMTabBarIconWidth - [icon size].height)/2.0;
          
        [icon compositeToPoint:iconRect.origin operation:NSCompositeSourceOver fraction:1.0];
    }

    // object counter
    if ([cell count] > 0)
    {
        [[cell countColor] ?: [NSColor colorWithCalibratedWhite:0.3 alpha:0.6] set];
        NSBezierPath *path = [NSBezierPath bezierPath];
        NSRect myRect = [self objectCounterRectForTabCell:cell];
        if ([cell state] == NSOnState)
            myRect.origin.y -= 1.0;
            
        [path moveToPoint:NSMakePoint(myRect.origin.x + kPSMObjectCounterRadius, myRect.origin.y)];
        [path lineToPoint:NSMakePoint(myRect.origin.x + myRect.size.width - kPSMObjectCounterRadius, myRect.origin.y)];
        [path appendBezierPathWithArcWithCenter:NSMakePoint(myRect.origin.x + myRect.size.width - kPSMObjectCounterRadius, myRect.origin.y + kPSMObjectCounterRadius) radius:kPSMObjectCounterRadius startAngle:270.0 endAngle:90.0];
        [path lineToPoint:NSMakePoint(myRect.origin.x + kPSMObjectCounterRadius, myRect.origin.y + myRect.size.height)];
        [path appendBezierPathWithArcWithCenter:NSMakePoint(myRect.origin.x + kPSMObjectCounterRadius, myRect.origin.y + kPSMObjectCounterRadius) radius:kPSMObjectCounterRadius startAngle:90.0 endAngle:270.0];
        [path fill];

        // draw attributed string centered in area
        NSRect counterStringRect;
        NSAttributedString *counterString = [self attributedObjectCountValueForTabCell:cell];
        counterStringRect.size = [counterString size];
        counterStringRect.origin.x = myRect.origin.x + ((myRect.size.width - counterStringRect.size.width) / 2.0) + 0.25;
        counterStringRect.origin.y = myRect.origin.y + ((myRect.size.height - counterStringRect.size.height) / 2.0) + 0.5;
        [counterString drawInRect:counterStringRect];
    }

    // draw label
    NSRect labelRect = cellFrame;
    NSAttributedString *string = [cell attributedStringValue];
    NSSize textSize = [string size];
    float textHeight = textSize.height;
    labelRect.size.height = textHeight;
    labelRect.size.width = textSize.width;
    labelRect.origin.x = cellFrame.origin.x + ((cellFrame.size.width - textSize.width) / 2);
    labelRect.origin.y = ((cellFrame.size.height - textHeight) / 2);

    [string drawInRect:labelRect];
}

- (void)drawBackgroundInRect:(NSRect)rect
{
	//Draw for our whole bounds; it'll be automatically clipped to fit the appropriate drawing area
	rect = [tabBar bounds];
	
	[NSGraphicsContext saveGraphicsState];

    // special case of hidden control; need line across top of cell
    if (rect.size.height < 2) {
        [[NSColor darkGrayColor] set];
        NSRectFillUsingOperation(rect, NSCompositeSourceOver);
    } else {
        NSImage* bg = [[[tabBar tabView] window] isKeyWindow] ? _staticSafariAWBGImage() : _staticSafariIWBGImage();
        NSDrawThreePartImage(rect, nil, bg, nil, NO, NSCompositeCopy, 1, [tabBar isFlipped]);
    }
    
	[NSGraphicsContext restoreGraphicsState];
}


- (void)drawTabBar:(PSMTabBarControl *)bar inRect:(NSRect)rect
{	
	if (tabBar != bar)
		tabBar = bar;
	
	[self drawBackgroundInRect:rect];
	
	// no tab view == not connected
    if (![bar tabView]) {
        NSRect labelRect = rect;
        labelRect.size.height -= 4.0;
        labelRect.origin.y += 4.0;
        NSMutableAttributedString *attrStr;
        NSString *contents = @"PSMTabBarControl";
        attrStr = [[[NSMutableAttributedString alloc] initWithString:contents] autorelease];
        NSRange range = NSMakeRange(0, [contents length]);
        [attrStr addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:11.0] range:range];
        NSMutableParagraphStyle *centeredParagraphStyle = nil;
        if (!centeredParagraphStyle) {
            centeredParagraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] retain];
            [centeredParagraphStyle setAlignment:NSCenterTextAlignment];
        }
        [attrStr addAttribute:NSParagraphStyleAttributeName value:centeredParagraphStyle range:range];
        [attrStr drawInRect:labelRect];
        return;
    }
    
    // draw cells
    NSEnumerator *e = [[bar cells] objectEnumerator];
    PSMTabBarCell *cell;
    
    while ((cell = [e nextObject])) {
        if ([bar isAnimating] || (![cell isInOverflowMenu] && NSIntersectsRect([cell frame], rect)))
            [cell drawWithFrame:[cell frame] inView:bar];
    }
}   	

@end
