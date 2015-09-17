//
//  SQLMainViewController.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLMainViewController.h"
#import "SQLTableListView.h"
#import "SQLTableDetailView.h"
#import "SQLStoreSharedManager.h"
#import "SQLTableListProtocol.h"
#import "SQLDatabaseDescription.h"

@interface SQLMainViewController ()<SQLTableListDelegate>
@property (nonatomic, strong) IBOutlet SQLTableListView *tableListView;
@property (nonatomic, strong) IBOutlet SQLTableDetailView *tableDetailView;

// Menu Buttons
@property (nonatomic, strong) IBOutlet NSButton *leftButton;
@property (nonatomic, strong) IBOutlet NSButton *rightButton;
@property (nonatomic, strong) IBOutlet NSButton *closeButton;
@property (nonatomic, strong) IBOutlet NSImageView *seperatorView;
@end

@implementation SQLMainViewController

#pragma mark - NSViewController Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableListView.delegate = self;
    self.tableDetailView.leftButton = self.leftButton;
    self.tableDetailView.rightButton = self.rightButton;
    // Do view setup here.
    
    ///Users/Joseph/Downloads/ChinookDatabase1.3_Sqlite/Chinook_Sqlite_AutoIncrementPKs.sqlite
}

-(void)awakeFromNib
{
    self.seperatorView.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    [self menuHidden:YES];
}

#pragma mark - Actions

-(void)menuHidden:(BOOL)hidden
{
    self.closeButton.hidden = hidden;
    self.rightButton.hidden = hidden;
    self.leftButton.hidden = hidden;
    self.tableListView.hidden = hidden;
    self.tableDetailView.hidden = hidden;
}

-(IBAction)didPressCloseFile:(id)sender
{
    self.view.window.title = @"SQL Explorer";
    [[SQLStoreSharedManager sharedManager] close];
    
    [self menuHidden:YES];
}

-(IBAction)didPressOpenFile:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Create a File Open Dialog class.
        NSOpenPanel* openFileControl = [NSOpenPanel openPanel];
        
        // Set array of file types
        NSArray *fileTypes = @[@"sqlite", @"sql", @"db"];
        
        // Enable options in the dialog.
        openFileControl.canChooseFiles = YES;
        openFileControl.allowedFileTypes = fileTypes;
        openFileControl.allowsMultipleSelection = NO;
        
        if ( [openFileControl runModal] == NSModalResponseOK )
        {
            [self openFile:openFileControl.URLs.firstObject.path];
        }
    });
}

-(void)openFile:(NSString*)path
{
    // Validate File
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NO];
    if(!fileExists)
    {
        // Log Error File Doesn't Exist
    }
    else
    {
        // Open File
        BOOL isOpened = [[SQLStoreSharedManager sharedManager] openDatabaseAtPath:path];
        if(!isOpened)
        {
            // Log Error File Couldn't Be Opened
        }
        else
        {
            // Get Tables
            [[SQLStoreSharedManager sharedManager] getTables:^(NSArray<SQLTableDescription *> *tables) {
                SQLDatabaseDescription *database = [[SQLDatabaseDescription alloc] init];
                database.name = path.lastPathComponent;
                database.path = path;
                database.tables = tables;
                
                // TODO Add Support for multiple DB
                self.tableListView.database = database;
                self.view.window.title = database.name;
                [self menuHidden:NO];
            }];
        }
    }
}

#pragma mark - SQLTableListDelegate
-(IBAction)didSelectTable:(SQLTableDescription*)table
{
    self.tableDetailView.table = table;
}

@end
