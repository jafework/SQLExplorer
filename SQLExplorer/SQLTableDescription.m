//
//  SQLTableDescription.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLTableDescription.h"

@implementation SQLTableDescription
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item
{
    return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item
{
    return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    return NO;
}


- (nullable id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn byItem:(nullable id)item
{
    return [NSString stringWithFormat:@"%@ (%@)",self.name, self.rows];
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"MyView" owner:self];
    cell.textField.stringValue = self.name;
    return cell;
}


@end
