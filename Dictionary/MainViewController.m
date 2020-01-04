//
//  MainViewController.m
//  Dictionary
//
//  Created by Son Lui on 2013/07/17.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

static NSString* const DB_FILE = @"ejdict.sqlite3";

@implementation MainViewController
{
    FMDatabase* _db;
    NSString *newString;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self) {
        //self.title = @"toZaim";
        CGRect screenSize = [UIScreen mainScreen].bounds;
        if (screenSize.size.height <= 480) {
            //screenType = SCREEN_TYPE_3_5;
            nibNameOrNil = @"MainViewController_3_5";
        }
        else {
            //screenType = SCREEN_TYPE_4_0;
            nibNameOrNil = @"MainViewController";
        }
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    
    self.textField1.delegate = self;
    [_textField1 becomeFirstResponder];
    _textField1.keyboardType = UIKeyboardTypeASCIICapable;
    _textField1.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textField1];
    
    [self openDatabase];
    //rs2 = [self executeQuery2];
    //[_tableView1 reloadData];
    
    UILabel *label1 = [[UILabel alloc]init];
    UILabel *label2 = [[UILabel alloc]init];
    //NSLog(@"%@",label1);
    //NSLog(@"%@",label2);
    [self.tableView1 addSubview:label1];
    [self.tableView1 addSubview:label2];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)openDatabase
{
    NSString *dbPath = nil;
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);

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
    
    //open database with FMDB.
    _db = [FMDatabase databaseWithPath:dbPath];
    return [_db open];
}

- (void)closeDatabase
{
    if (_db) {
        [_db close];
    }
}

- (NSMutableArray*)executeQuery2
{
    //結果格納用配列
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    NSString *param = [NSString stringWithFormat:@"%@%%",newString];
 
    //クエリ実行
    //FMResultSet *rs = [_db executeQuery:@"SELECT word, mean FROM items ORDER BY word "];
    FMResultSet *rs = [_db executeQuery:@"SELECT word, mean FROM items WHERE word LIKE ? ORDER BY word ", param];
    //FMResultSet *rs = [_db executeQuery:@"SELECT * FROM items WHERE item_id LIKE ? ORDER BY word ", @"%2."];
    NSLog(@"%@",param);
    
    if ([_db hadError]) {
        NSLog(@"Err %d: %@", [_db lastErrorCode], [_db lastErrorMessage]);
    }
    
    //結果の取得(カラム名指定)
    while ([rs next]) {
        //結果格納用オブジェクト
        ExampleRecord *record = [[ExampleRecord alloc]init];
        //record.columnOfItem = [rs intForColumn:@"item_id"];
        record.columnOfWord = [rs stringForColumn:@"word"];
        record.columnOfMean = [rs stringForColumn:@"mean"];
        //record.columnOfLevel = [rs intForColumn:@"level"];
        
        [result addObject:record];
    }
    
    //close ResultSet.
    [rs close];
    
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    //NSLog(@"%d", rs2.count);
    return rs2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aaaaaCell";
    aaaaaCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell1 == nil) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:@"aaaaaCell" owner:self options:nil]lastObject];
        
        cell1.backgroundColor = [ UIColor redColor ];
    }
    
    ExampleRecord* records = [rs2 objectAtIndex: indexPath.row];

    cell1.label1.text = records.columnOfWord;
    cell1.label2.text = records.columnOfMean;
    
    cell1.label2.numberOfLines = 0;
    cell1.label2.lineBreakMode = UILineBreakModeWordWrap;
    
    return cell1;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"test.");
    newString = _textField1.text;
    newString = [newString stringByReplacingCharactersInRange:range withString:string];
    //NSLog(@"newStirng : %@", newString );
    
    rs2 = [self executeQuery2];
    [_tableView1 reloadData];
    [_textField1 becomeFirstResponder];
    
    return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"セルがタップされた");
    int count = 0;
    count++;
    //int newcount = count + 1;
    NSLog(@"%d", count);
    
//    if ((count%2) == 1) {
        aaaaaCell *ani = (aaaaaCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        // アニメーション
        animeStart = [[Animation alloc]initWithFrame:CGRectMake(self.view.frame.size.width+1, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        // アニメーションブロック開始
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDidStopSelector:@selector(bark)];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.view addSubview:animeStart];
        
        // 移動先の座標を設定
        CGRect screenSize = [UIScreen mainScreen].bounds;
        if (screenSize.size.height <= 480) {
            animeStart.frame = CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width, self.view.frame.size.height*0.45);
        }
        else {
            animeStart.frame = CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width, self.view.frame.size.height*0.54);
        }
        
        animeStart.word2.text = ani.label1.text;
        animeStart.mean3.text = ani.label2.text;
        
        // アニメーションブロック終了
        [UIView commitAnimations];
/*    }
    else {
        aaaaaCell *ani = (aaaaaCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        // アニメーション
        animeFinish = [[Animation alloc]initWithFrame:CGRectMake(self.view.frame.size.width+1, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        // アニメーションブロック開始
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bark)];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.view addSubview:animeFinish];
        
        // 移動先の座標を設定
        CGRect screenSize = [UIScreen mainScreen].bounds;
        if (screenSize.size.height <= 480) {
            animeFinish.frame = CGRectMake(self.view.frame.size.width+1, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
        else {
            animeFinish.frame = CGRectMake(self.view.frame.size.width+1, 0, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        animeFinish.word2.text = ani.label1.text;
        animeFinish.mean3.text = ani.label2.text;
        
        // アニメーションブロック終了
        [UIView commitAnimations];
    }*/
}

- (void)bark
{
    NSLog(@"アニメーション完結！");
}

- (void) _deselectTableRow:(UITableView *)tableView
{
    NSLog(@"セルがkaizyo");
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)rirekiBtn1:(id)sender
{
    SecondViewController *secondViewController = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    //self.navigationController.navigationBarHidden = YES;
    secondViewController.completeString = newString;
    [self.navigationController pushViewController:secondViewController animated:YES];
}
@end
