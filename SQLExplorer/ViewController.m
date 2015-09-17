//
//  ViewController.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/8/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDB.h>
#import "SQLTableDescription.h"
#import "SQLTableNameView.h"

@interface ViewController ()<NSTableViewDataSource,NSTableViewDelegate>
@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, weak) IBOutlet NSTextField *openTextField;

@property (nonatomic, strong) NSArray<SQLTableDescription *> *tables;
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tables = [[NSArray alloc] init];
}

-(IBAction)didPressOpen:(id)sender
{
    ///Users/Joseph/Downloads/ChinookDatabase1.3_Sqlite/Chinook_Sqlite_AutoIncrementPKs.sqlite
    
    self.databaseQueue = [[FMDatabaseQueue alloc] initWithPath:self.openTextField.stringValue];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSMutableArray *tables = [[NSMutableArray alloc] init];
        FMResultSet *result = [db executeQuery:@"SELECT name FROM sqlite_master WHERE type='table'"];
        while([result next])
        {
            SQLTableDescription *table = [[SQLTableDescription alloc] init];
            table.name = result.resultDictionary[@"name"];
            FMResultSet *count = [db executeQuery:[NSString stringWithFormat:@"SELECT Count(*) FROM %@", table.name]];
            while([count next])
            {
                table.rows = count.resultDictionary[@"Count(*)"];
            }
            [tables addObject:table];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tables = tables;
            [self.tableView reloadData];
        });
    }];
}

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
    NSView *newView = [[NSView alloc] init];
    newView.translatesAutoresizingMaskIntoConstraints = NO;
    [newView setWantsLayer:YES];

    newView.layer.backgroundColor = [NSColor orangeColor].CGColor;
    
    [[self.tableView.superview animator] replaceSubview:self.tableView with:newView];
    
    [newView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|" options:0 metrics:nil views:@{@"newView":newView}]];
    
    [newView.superview addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newView]|" options:0 metrics:nil views:@{@"newView":newView}]];
    
    [newView setNeedsUpdateConstraints:YES];
}

@end
