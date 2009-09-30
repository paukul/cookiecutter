//
//  CookiesController.m
//  cookiecutter
//
//  Created by Pascal Friederich on 30.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CookiesController.h"


@implementation CookiesController
@synthesize cookiesTable, cookiesData;

-(void) initCookiesDataSource {
	cookiesFileLocation = [[NSString stringWithString:cookiesFileLocation] stringByExpandingTildeInPath];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:cookiesFileLocation]){
		NSLog(@"Reading plist file");
		self.cookiesData = [NSMutableArray arrayWithContentsOfFile:cookiesFileLocation];
		//NSLog(@"%@", cookiesData);
	}else{
		NSLog(@"File doesn't exist at %@", cookiesFileLocation);
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
    return [[cookiesData objectAtIndex:rowIndex] objectForKey:[[aTableColumn headerCell] title]];
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return cookiesData.count;
}

#pragma mark -
#pragma mark IBActions
-(IBAction) saveCookies:(id)sender {
	[cookiesData writeToFile:cookiesFileLocation atomically:YES];
}

-(IBAction) reloadCookies:(id)sender {
	[self initCookiesDataSource];
	[self.cookiesTable reloadData];
}

-(IBAction) applySearchFilter:(id)sender{
	NSString *searchString = [sender stringValue];
	NSLog(@"search with %@", searchString);
	if (![searchString length] == 0) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"'Domain' like %@", searchString];
		NSArray *filteredArray = [cookiesData filteredArrayUsingPredicate:predicate];
		NSLog(@"Found %@ matching", [filteredArray count]);
	}
}
@end
