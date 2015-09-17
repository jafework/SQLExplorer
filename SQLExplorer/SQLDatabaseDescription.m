//
//  SQLDatabaseDescription.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/13/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLDatabaseDescription.h"

@implementation SQLDatabaseDescription

-(NSInteger)outlineView:(nonnull NSOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item
{
    if(item == nil)
    {
        return 1;
    }
    return self.tables.count;
}

-(BOOL)outlineView:(nonnull NSOutlineView *)outlineView isItemExpandable:(nonnull id)item
{
    return YES;
}

-(id)outlineView:(nonnull NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item
{
    if(item == nil)
    {
        return self;
    }
    return self.tables[index];
}

/*
-(id)outlineView:(nonnull NSOutlineView *)outlineView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn byItem:(nullable id)item
{
    return self.name;
}
 */

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"MyView" owner:self];
    cell.textField.stringValue = self.name;
    return cell;
}

@end
