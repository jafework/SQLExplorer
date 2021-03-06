//
//  SQLTableDetailViewController.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLTableDetailView.h"
#import "SQLTableProperty.h"
#import "SQLStoreSharedManager.h"

@interface SQLTableDetailView ()<NSTableViewDataSource,NSTableViewDelegate>
@property (nonatomic, weak) IBOutlet NSTableView *detailView;
@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSArray *rows;
@end

@implementation SQLTableDetailView

-(void)clearColumns
{
    // Remove All Columns
    for(NSTableColumn *column in self.detailView.tableColumns.copy)
    {
        [self.detailView removeTableColumn:column];
    }
}

-(void)awakeFromNib
{
    self.rows = [[NSMutableArray alloc] init];
    [self clearColumns];
    self.leftButton.target = self;
    self.leftButton.action = NSSelectorFromString(@"didPressLeftButton:");
    self.rightButton.target = self;
    self.rightButton.action = NSSelectorFromString(@"didPressRightButton:");
}

-(IBAction)didPressLeftButton:(id)sender
{
    self.offset = @(self.offset.intValue - 50);
    [self fetchRowForOffset];
}

-(IBAction)didPressRightButton:(id)sender
{
    self.offset = @(self.offset.intValue + 50);
    [self fetchRowForOffset];
}

-(void)setTable:(SQLTableDescription *)table
{
    _table = table;
    [self reloadUI];
}

-(void)reloadUI
{
    self.rows = @[];
    self.offset = @(0);
    self.leftButton.enabled = NO;
    self.rightButton.enabled = NO;
    
    [self clearColumns];
    
    for (SQLTableProperty *property in self.table.properties)
    {
        NSTableColumn* column = [[NSTableColumn alloc] init];
        
        NSString *identifier = @([self.table.properties indexOfObject:property]).stringValue; // Make a distinct one for each column
        NSString *header = property.name; // Or whatever you want to show the user
        
        column.headerCell.stringValue = header;
        column.identifier = identifier;
        [self.detailView addTableColumn:column];
    }
    
    [self.detailView reloadData];
    
    [self fetchRowForOffset];
}

-(void)fetchRowForOffset
{
    [[SQLStoreSharedManager sharedManager] getRowsWithOffset:self.offset withTableDescription:self.table completion:^(NSArray *rows) {
        self.rows = rows;
        
        if(self.rows.count + self.offset.intValue != self.table.rows.intValue)
        {
            self.rightButton.enabled = YES;
        }
        else
        {
            self.rightButton.enabled = NO;
        }
        
        if(self.offset.intValue == 0)
        {
            self.leftButton.enabled = NO;
        }
        else
        {
            self.leftButton.enabled = YES;
        }
        [self.detailView reloadData];
    }];
}

-(NSInteger)numberOfRowsInTableView:(nonnull NSTableView *)tableView
{
    return self.rows.count;
}

-(CGFloat)tableView:(nonnull NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 20.0f;
}

-(id)tableView:(nonnull NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSUInteger columnIndex = [tableColumn.identifier integerValue];
    NSUInteger rowIndex = row;
    
    NSArray *rowValues = self.rows[rowIndex];
    
    return [NSString stringWithFormat:@"%@",rowValues[columnIndex]];
    
}

@end
