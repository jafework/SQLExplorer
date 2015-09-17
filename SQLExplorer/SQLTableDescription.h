//
//  SQLTableDescription.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import "SQLTableProperty.h"

@interface SQLTableDescription : NSObject <NSOutlineViewDataSource>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<SQLTableProperty *> *properties;
@property (nonatomic, strong) NSNumber *rows;
@property (nonatomic, strong) NSArray<SQLTableDescription*> *childern;

@end
