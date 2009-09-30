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

-(void) initCookiesDataSource:(NSString *) cookiesFileLocation {
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
	[self initCookiesDataSource:@"~/Library/Cookies/Cookies.plist"];
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

@end
