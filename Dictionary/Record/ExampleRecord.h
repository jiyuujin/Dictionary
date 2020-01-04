//
//  ExampleRecord.h
//  Dictionary
//
//  Created by Son Lui on 2013/07/17.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#ifndef Dictionary_ExampleRecord_h
#define Dictionary_ExampleRecord_h



#endif

@interface ExampleRecord : NSObject
{
    int i_;
    NSString* w_;
    NSString* m_;
    int l_;
}

// I'm using ARC.
@property (nonatomic) int columnOfItem;
@property (nonatomic, copy) NSString* columnOfWord;
@property (nonatomic, copy) NSString* columnOfMean;
@property (nonatomic) int columnOfLevel;

@end
