//
//  SQLiteManager.m
//  Customer
//
//  Created by Son Lui on 2013/08/09.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import "SQLiteManager.h"

static NSString* const DB_FILE = @"searchlist.sqlite3";

@implementation SQLiteManager
{
    FMDatabase *_db;
}

// OpenDatabase
-(bool)openDB
{
    NSString *dbPath = nil;
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([documentsPath count] >= 1) {
        dbPath = [documentsPath objectAtIndex:0];
        dbPath = [dbPath stringByAppendingPathComponent:DB_FILE];
        NSLog(@"db path : %@", dbPath);
    }
    else {
        NSLog(@"search Document path error. database file open error.");
        return false;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPath]) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *orgPath = [bundle bundlePath];
        orgPath = [orgPath stringByAppendingPathComponent:DB_FILE];
        if (![fileManager copyItemAtPath:orgPath toPath:dbPath error:nil]) {
            NSLog(@"db file copy error. : %@ to %@.", orgPath, dbPath);
            return false;
        }
    }
    
    // open database with FMDB.
    _db = [FMDatabase databaseWithPath:dbPath];
    return [_db open];
}

// Select Searchlistテーブル
-(NSMutableArray *)selectSearchlist:(int)idno
{
    //結果格納用配列
    NSMutableArray *result = [NSMutableArray array];
    
    bool flg2 = [self openDB];
    
    if (!flg2) {
        NSLog(@"Open Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
        return result;
    }
    
    // クエリ実行
    FMResultSet *rs2 = [_db executeQuery:@"SELECT * FROM customer WHERE idno = ?; ", [NSString stringWithFormat:@"%d", idno]];
    
    if ([_db hadError]) {
        NSLog(@"Select Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
        [rs2 close];
        [_db close];
        return result;
    }
    
    //結果の取得(カラム名指定)
    while ([rs2 next]) {
        Searchlist *sqlSelect = [[Searchlist alloc]init];
        sqlSelect.idno = [rs2 intForColumn:@"idno"];
        sqlSelect.word = [rs2 stringForColumn:@"word"];
        
        [result addObject:sqlSelect];
    }
    
    [rs2 close];
    [_db close];
    
    return result;
}

// Word保存（SearchlistテーブルにデータをInsert）
- (BOOL)insertSearchlist:(NSArray *)insertarray
{
    //結果格納用配列
    BOOL result = NO;
    
    bool flg2 = [self openDB];
    
    if (!flg2) {
        NSLog(@"Open Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
        return result;
    }
    
    NSLog(@"%@", insertarray);
    
    // トランザクション開始(exclusive)
    [_db beginTransaction];
    
    // ステートメントの再利用フラグ
    [_db setShouldCacheStatements:YES];
    
    // Insertクエリ実行 (idno, id_customer, time_ymd, time_hi, type, target, result, memo)
    [_db executeUpdate:@"INSERT INTO customer VALUES (?, ?);",
     [insertarray objectAtIndex: 0],
     [insertarray objectAtIndex: 1]];
    
    if ([_db hadError]) {
        NSLog(@"Select Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
        [_db rollback];
        [_db close];
        return result;
    }
    
    //commit
    [_db commit];
    
    [_db close];
    
    return result;
}

- (int)max_idno
{
    bool flg2 = [self openDB];
    
    if (!flg2) {
        NSLog(@"Open Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
        return -1;
    }
    
    FMResultSet *rs2 = [_db executeQuery:@"SELECT max(idno) as idno FROM customer;"];
    
    if ([_db hadError]) {
        NSLog(@"Select Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
        [rs2 close];
        [_db close];
        return -1;
    }
    
    [rs2 next];
    int max_writingidno = [rs2 intForColumn:@"idno"];
    
    [rs2 close];
    [_db close];
    
    return max_writingidno;
}

@end
