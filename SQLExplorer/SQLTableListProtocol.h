//
//  SQLTableListProtocol.h
//  SQLExplorer
//
//  Created by Joseph Afework on 9/11/15.
//  Copyright © 2015 Joseph Afework. All rights reserved.
//

#ifndef SQLTableListProtocol_h
#define SQLTableListProtocol_h

@protocol SQLTableListDelegate <NSObject>
@required
-(void)didSelectTable:(SQLTableDescription*)table;
@end

#endif /* SQLTableListProtocol_h */
