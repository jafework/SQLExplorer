//
//  SQLTableListViewController.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLTableListView.h"
#import "SQLTableNameView.h"

@interface SQLTableListView ()<NSTableViewDataSource,NSTableViewDelegate,NSOutlineViewDataSource,NSOutlineViewDelegate>
@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, weak) IBOutlet NSOutlineView *outlineView;
@end

@implementation SQLTableListView

-(NSInteger)outlineView:(nonnull NSOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item
{
    if(!item)
        return [self.database outlineView:outlineView numberOfChildrenOfItem:item];
    else
        return [item outlineView:outlineView numberOfChildrenOfItem:item];
}

-(BOOL)outlineView:(nonnull NSOutlineView *)outlineView isItemExpandable:(nonnull id)item
{
    return [item outlineView:outlineView isItemExpandable:item];
}

-(id)outlineView:(nonnull NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item
{
    if(!item)
        return [self.database outlineView:outlineView child:index ofItem:item];
    else
        return [item outlineView:outlineView child:index ofItem:item];
}

/*
-(id)outlineView:(nonnull NSOutlineView *)outlineView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn byItem:(nullable id)item
{
    return [item outlineView:outlineView objectValueForTableColumn:tableColumn byItem:item];
}
 */

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {

    return [item outlineView:outlineView viewForTableColumn:tableColumn item:item];
}

-(void)awakeFromNib
{
    self.outlineView.delegate = self;
    self.outlineView.dataSource = self;
}

-(void)setDatabase:(SQLDatabaseDescription *)database
{
    _database = database;
    [self.outlineView reloadData];
}

-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification
{
    NSTableView *tableView = notification.object;
    SQLTableDescription *table = self.database.tables[tableView.selectedRow];
    [self.delegate didSelectTable:table];
}

-(void)outlineViewSelectionDidChange:(nonnull NSNotification *)notification
{
    NSOutlineView *outlineView = notification.object;
    id selectedItem = [outlineView itemAtRow:outlineView.selectedRow];
    
    if([selectedItem isKindOfClass:[SQLTableDescription class]])
    {
        SQLTableDescription *table = selectedItem;
        [self.delegate didSelectTable:table];
    }
}
/*
-(NSInteger)numberOfRowsInTableView:(nonnull NSTableView *)tableView
{
    return self.tables.count;
}

-(CGFloat)tableView:(nonnull NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return SQLTableNameView.height;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    SQLTableDescription *table = self.tables[row];
    
    SQLTableNameView *cell = [tableView makeViewWithIdentifier:SQLTableNameView.reuseIdentifier owner:self];
    cell.table = table;
    
    return cell;
}

-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification
{
    NSTableView *tableView = notification.object;
    SQLTableDescription *table = self.tables[tableView.selectedRow];
    [self.delegate didSelectTable:table];
}
 
*/

@end
