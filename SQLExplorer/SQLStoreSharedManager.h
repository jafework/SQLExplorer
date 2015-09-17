//
//  SQLStoreSharedManager.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLTableDescription.h"

@interface SQLStoreSharedManager : NSObject

+(instancetype)sharedManager;

-(void)close;
-(BOOL)openDatabaseAtPath:(NSString*)path;

-(void)getTables:(void(^)(NSArray<SQLTableDescription *>*))completion;
-(void)getRowsWithOffset:(NSNumber*)offset withTableDescription:(SQLTableDescription*)table completion:(void(^)(NSArray*))completion;
@end
