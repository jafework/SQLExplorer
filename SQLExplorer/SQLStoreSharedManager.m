//
//  SQLStoreSharedManager.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLStoreSharedManager.h"
#import <FMDB/FMDB.h>

@interface SQLStoreSharedManager ()
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
@end

@implementation SQLStoreSharedManager
static SQLStoreSharedManager *_sharedManager = nil;

+(instancetype)sharedManager
{
    if(!_sharedManager)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedManager = [[SQLStoreSharedManager alloc] init];
        });
    }
    return _sharedManager;
}

-(void)close
{
    [self.databaseQueue close];
}

-(BOOL)openDatabaseAtPath:(NSString*)path
{
    // Close Existing Database Queue
    if(self.databaseQueue)
    {
        [self.databaseQueue close];
        self.databaseQueue = nil;
    }
    
    // Open Path
    self.databaseQueue = [[FMDatabaseQueue alloc] initWithPath:path];
    
    return (self.databaseQueue != nil);
}

-(void)getTables:(void (^)(NSArray<SQLTableDescription *> *))completion
{
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSMutableArray *tables = [[NSMutableArray alloc] init];
        FMResultSet *result = [db executeQuery:@"SELECT name FROM sqlite_master WHERE type='table'"];
        while([result next])
        {
            SQLTableDescription *table = [[SQLTableDescription alloc] init];
            table.name = result.resultDictionary[@"name"];
            
            NSMutableArray *properties = [[NSMutableArray alloc] init];
            FMResultSet *propertiesResult = [db executeQuery:[NSString stringWithFormat:@"PRAGMA table_info(%@)",table.name]];
            while ([propertiesResult next]) {
                SQLTableProperty *property = [[SQLTableProperty alloc] init];
                property.name = propertiesResult.resultDictionary[@"name"];
                [properties addObject:property];
                NSLog(@"%@",propertiesResult.resultDictionary);
            }
            table.properties = properties;
            
            FMResultSet *count = [db executeQuery:[NSString stringWithFormat:@"SELECT Count(*) FROM %@", table.name]];
            while([count next])
            {
                table.rows = count.resultDictionary[@"Count(*)"];
            }
            [tables addObject:table];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completion)
            {
                completion(tables);
            }
        });
    }];
}

-(void)getRowsWithOffset:(NSNumber*)offset withTableDescription:(SQLTableDescription*)table completion:(void(^)(NSArray*))completion
{
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ LIMIT %@,%d" ,table.name, offset, 50]];
        
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        while([result next])
        {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            for (SQLTableProperty *property in table.properties)
            {
                [row addObject:result.resultDictionary[property.name]];
            }
            [rows addObject:row];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completion)
            {
                completion(rows);
            }
        });
    }];
}

@end
