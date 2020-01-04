//
//  SecondViewController.m
//  Dictionary
//
//  Created by yuumak on 2013/07/25.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self) {
        // Custom initialization
        CGRect screenSize = [UIScreen mainScreen].bounds;
        if (screenSize.size.height <= 480) {
            //screenType = SCREEN_TYPE_3_5;
            nibNameOrNil = @"SecondViewController_3_5";
        }
        else {
            //screenType = SCREEN_TYPE_4_0;
            nibNameOrNil = @"SecondViewController";
        }
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // navigationbar color
    self.navigationItem.title = @"検索履歴";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // 左側に「戻る」ボタンの表示
    UIImage *img1 = [UIImage imageNamed:@"btn_back.png"];
    UIButton *backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(backBtn1:)forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:img1 forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backItem, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // DB Open
    SQLiteManager *insertdatabase = [[SQLiteManager alloc] init];
    
    // get max(writingidno)
    self.idnoAdd = [insertdatabase max_idno] + 1;
    NSLog(@"%d", self.idnoAdd);
    
    // Searchlistテーブルにid_customerをinsert
    self.insertarray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.idnoAdd], self.completeString, nil];
    NSLog(@"%@", self.insertarray);
    
    // SearchlistテーブルからwordをSelect
    self.mContract2 = [insertdatabase selectSearchlist:self.idnoAdd];
    
    // CompleteテーブルにInsert
    [insertdatabase insertSearchlist:self.insertarray];
    
    [self.tableView2 reloadData];
}

-(void) viewWillDisppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)backBtn1:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return self.mContract2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aaaaaCell";
    aaaaaCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell2 == nil) {
        cell2 = [[[NSBundle mainBundle] loadNibNamed:@"aaaaaCell" owner:self options:nil]lastObject];
        
        cell2.backgroundColor = [ UIColor redColor ];
    }
    
    Searchlist *record = [self.mContract2 objectAtIndex: 0];
    
    cell2.label1.text = [NSString stringWithFormat:@"%d", record.idno];
    cell2.label2.text = record.word;
    
    return cell2;
}

@end
