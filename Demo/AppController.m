#import "AppController.h"
#import "WindowController.h"


@implementation AppController

- (void)applicationDidFinishLaunching:(NSNotification *)pNotification {
	[self newWindow:self];
	[self newWindow:self];
	NSRect frontFrame = [[NSApp keyWindow] frame];
	frontFrame.origin.x += 400;
	[[NSApp keyWindow] setFrame:frontFrame display:YES];
}
- (IBAction)newWindow:(id)sender {
	// put up a window
	WindowController *newWindow = [[WindowController alloc] initWithWindowNibName:@"Window"];
	[newWindow showWindow:self];
	[newWindow addDefaultTabs];
}

@end
