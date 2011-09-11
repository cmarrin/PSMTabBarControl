//
//  WindowController.h
//  PSMTabBarControl
//
//  Created by John Pannell on 4/6/06.
//  Copyright 2006 Positive Spin Media. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PSMTabBarControl;

#define CONTENT_IMAGE_COUNT 9
#define CONTENT_IMAGE_PREFIX @"space_"

@interface WindowController : NSWindowController <NSToolbarDelegate> {
	IBOutlet NSTabView					*tabView;
	IBOutlet NSTextField					*tabField;
	IBOutlet NSDrawer						*drawer;

	IBOutlet PSMTabBarControl			*tabBar;

	IBOutlet NSButton						*isProcessingButton;
	IBOutlet NSButton						*isEditedButton;
	IBOutlet NSTextField					*objectCounterField;
	IBOutlet NSPopUpButton				*iconButton;

	IBOutlet NSPopUpButton				*popUp_style;
	IBOutlet NSPopUpButton				*popUp_orientation;
	IBOutlet NSPopUpButton				*popUp_tearOff;
	IBOutlet NSButton						*button_onlyShowCloseOnHover;
	IBOutlet NSButton						*button_canCloseOnlyTab;
	IBOutlet NSButton						*button_disableTabClosing;
	IBOutlet NSButton						*button_hideForSingleTab;
	IBOutlet NSButton						*button_showAddTab;
	IBOutlet NSButton						*button_useOverflow;
	IBOutlet NSButton						*button_automaticallyAnimate;
	IBOutlet NSButton						*button_allowScrubbing;
	IBOutlet NSButton						*button_sizeToFit;
	IBOutlet NSTextField					*textField_minWidth;
	IBOutlet NSTextField					*textField_maxWidth;
	IBOutlet NSTextField					*textField_optimumWidth;
    
    int contentImageIndex;
}

- (void)addDefaultTabs;

// UI
- (IBAction)addNewTab:(id)sender;
- (IBAction)closeTab:(id)sender;
- (IBAction)stopProcessing:(id)sender;
- (IBAction)setIconNamed:(id)sender;
- (IBAction)setObjectCount:(id)sender;
- (IBAction)setTabLabel:(id)sender;

// Actions
- (IBAction)isProcessingAction:(id)sender;
- (IBAction)isEditedAction:(id)sender;

- (PSMTabBarControl *)tabBar;

// tab bar config
- (IBAction)configStyle:(id)sender;
- (IBAction)configOrientation:(id)sender;
- (IBAction)configCanCloseOnlyTab:(id)sender;
- (IBAction)configOnlyShowCloseOnHover:(id)sender;
- (IBAction)configDisableTabClose:(id)sender;
- (IBAction)configHideForSingleTab:(id)sender;
- (IBAction)configAddTabButton:(id)sender;
- (IBAction)configTabMinWidth:(id)sender;
- (IBAction)configTabMaxWidth:(id)sender;
- (IBAction)configTabOptimumWidth:(id)sender;
- (IBAction)configTabSizeToFit:(id)sender;
- (IBAction)configTearOffStyle:(id)sender;
- (IBAction)configUseOverflowMenu:(id)sender;
- (IBAction)configAutomaticallyAnimates:(id)sender;
- (IBAction)configAllowsScrubbing:(id)sender;

// delegate
- (void)tabView:(NSTabView *)aTabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (BOOL)tabView:(NSTabView *)aTabView shouldCloseTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabView:(NSTabView *)aTabView didCloseTabViewItem:(NSTabViewItem *)tabViewItem;

// toolbar
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar;
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar;
- (IBAction)toggleToolbar:(id)sender;
- (BOOL)validateToolbarItem:(NSToolbarItem *)theItem;

@end
