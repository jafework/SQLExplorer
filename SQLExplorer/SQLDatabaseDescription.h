//
//  SQLDatabaseDescription.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/13/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "SQLDatabaseDescription.h"
#import "SQLTableDescription.h"

@interface SQLDatabaseDescription : NSObject<NSOutlineViewDataSource>
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<SQLTableDescription *> *tables;
@end
