//
//  SecondViewController.h
//  Dictionary
//
//  Created by yuumak on 2013/07/25.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "Searchlist.h"
#import "aaaaaCell.h"

@interface SecondViewController_3_5 : UIViewController

@end

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar2;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
- (IBAction)backBtn1:(id)sender;

@property (nonatomic) int idnoAdd;
@property (nonatomic) NSString *completeString;
@property (nonatomic) NSArray *insertarray;

@property (nonatomic) NSMutableArray *mContract2;

@end
