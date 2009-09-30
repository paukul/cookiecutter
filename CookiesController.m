//
//  CookiesController.m
//  cookiecutter
//
//  Created by Pascal Friederich on 30.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CookiesController.h"


@implementation CookiesController
@synthesize cookiesTable;

-(void) initCookiesDataSource {
	cookiesFileLocation = [[NSString stringWithString:cookiesFileLocation] stringByExpandingTildeInPath];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:cookiesFileLocation]){
		NSLog(@"Reading plist file");
		originalCookiesData = [NSMutableArray arrayWithContentsOfFile:cookiesFileLocation];
		filteredCookiesData = originalCookiesData;
	}else{
		NSAlert *alert = [NSAlert alertWithMessageText:@"No Cookies file found!" 
										 defaultButton:@"Exit" 
									   alternateButton:nil 
										   otherButton:nil 
							 informativeTextWithFormat:@"Was looking for a cookies file at \n%@", cookiesFileLocation];
		[alert setAlertStyle:NSCriticalAlertStyle];
		[alert runModal];
		[[NSApplication sharedApplication] terminate:self];
	}
}

-(void) awakeFromNib {
	cookiesFileLocation = @"~/Library/Cookies/Cookies.plist";
	[self initCookiesDataSource];
}

#pragma mark -
#pragma mark Table View data source stuff
- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex
{
    return [[filteredCookiesData objectAtIndex:rowIndex] objectForKey:[[aTableColumn headerCell] title]];
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return filteredCookiesData.count;
}

#pragma mark -
#pragma mark IBActions
-(IBAction) saveCookies:(id)sender {
	[originalCookiesData writeToFile:cookiesFileLocation atomically:YES];
}

-(IBAction) reloadCookies:(id)sender {
	[self initCookiesDataSource];
	[self.cookiesTable reloadData];
}

-(IBAction) applySearchFilter:(id)sender{
	NSString *searchString = [sender stringValue];
	
	if (![searchString length] == 0) {
		NSLog(@"search with %@", searchString);
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Domain contains[c] %@", searchString];
		NSArray *filteredArray = [originalCookiesData filteredArrayUsingPredicate:predicate];
		[filteredArray count];
		NSLog(@"Found %i matching", [filteredArray count]);
		filteredCookiesData = [NSMutableArray arrayWithArray:filteredArray];
	}else {
		NSLog(@"Reset to all cookies");
		filteredCookiesData = originalCookiesData;
	}
	[self.cookiesTable reloadData];

}
@end
