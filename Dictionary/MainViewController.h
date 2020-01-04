//
//  MainViewController.h
//  Dictionary
//
//  Created by Son Lui on 2013/07/17.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "Animation.h"
#import "ExampleRecord.h"
#import "SecondViewController.h"
#import "aaaaaCell.h"

@interface MainViewController_3_5 : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray* rs2;
    NSMutableArray* rs2_anime;
    Animation *animeStart;
    Animation *animeFinish;
    int kekka;
    SecondViewController *secondController;
}
@end

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray* rs2;
    NSMutableArray* rs2_anime;
    Animation *animeStart;
    Animation *animeFinish;
    int kekka;
    SecondViewController *secondController;
}
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITextField *rirekiBtn1;

- (IBAction)rirekiBtn1:(id)sender;

@end
