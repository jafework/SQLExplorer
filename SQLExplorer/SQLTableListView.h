//
//  SQLTableListViewController.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SQLDatabaseDescription.h"
#import "SQLTableListProtocol.h"

@interface SQLTableListView : NSView
@property (nonatomic, weak) id<SQLTableListDelegate> delegate;
@property (nonatomic, strong) SQLDatabaseDescription *database;
@end
