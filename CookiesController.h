//
//  CookiesController.h
//  cookiecutter
//
//  Created by Pascal Friederich on 30.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CookiesController : NSObject {
	NSTableView *cookiesTable;
	NSMutableArray *cookiesData;
}

@property(assign) IBOutlet NSTableView *cookiesTable;
@property(assign) NSMutableArray *cookiesData;

@end
