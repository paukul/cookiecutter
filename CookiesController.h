//
//  CookiesController.h
//  cookiecutter
//
//  Created by Pascal Friederich on 30.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CookiesController : NSObject {
	NSString *cookiesFileLocation;
	NSTableView *cookiesTable;
	NSMutableArray *filteredCookiesData;
	NSMutableArray *originalCookiesData;
}

@property(assign) IBOutlet NSTableView *cookiesTable;

-(IBAction) saveCookies:(id)sender;
-(IBAction) reloadCookies:(id)sender;
-(IBAction) applySearchFilter:(id)sender;
@end
