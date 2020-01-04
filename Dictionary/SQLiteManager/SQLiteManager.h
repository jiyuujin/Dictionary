//
//  SQLiteManager.h
//  Customer
//
//  Created by Son Lui on 2013/08/09.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import <sqlite3.h>
#import "Searchlist.h"

@interface SQLiteManager : NSObject

-(bool)openDB;

-(NSMutableArray *)selectSearchlist:(int)idno;

- (BOOL)insertSearchlist:(NSArray *)insertarray;

- (int)max_idno;

@end
