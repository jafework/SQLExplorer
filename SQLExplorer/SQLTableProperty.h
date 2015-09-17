//
//  SQLTableProperty.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SQLTablePropertyIntegerType,
    SQLTablePropertyBlobType,
    SQLTablePropertyVarcharType
} SQLTablePropertyType;

@interface SQLTableProperty : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic) SQLTablePropertyType type;
@end
