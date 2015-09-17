//
//  SQLTableDetailViewController.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SQLTableDescription.h"

@interface SQLTableDetailView : NSView
@property (nonatomic, strong) SQLTableDescription *table;
@property (nonatomic, weak) NSButton *leftButton;
@property (nonatomic, weak) NSButton *rightButton;
@end
