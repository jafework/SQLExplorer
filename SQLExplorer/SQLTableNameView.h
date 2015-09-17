//
//  SQLTableNameView.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/10/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SQLTableDescription.h"

@interface SQLTableNameView : NSView
@property (nonatomic, strong) SQLTableDescription *table;

+(CGFloat)height;
+(NSString*)reuseIdentifier;
@end
