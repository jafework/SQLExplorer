//
//  SQLTableNameView.m
//  SQLExplorer
//
//  Created by Joseph Afework on 9/10/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#import "SQLTableNameView.h"

@interface SQLTableNameView ()
@property (nonatomic, weak) IBOutlet NSTextFieldCell *nameView;
@end

@implementation SQLTableNameView

-(void)setTable:(SQLTableDescription *)table
{
    _table = table;
    [self reloadUI];
}

-(void)reloadUI
{
    self.nameView.stringValue = [NSString stringWithFormat:@"%@ (%@ rows)",self.table.name,self.table.rows];
}

+(CGFloat)height
{
    return 30.0f;
}

+(NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
