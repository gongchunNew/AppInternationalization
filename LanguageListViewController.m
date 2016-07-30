//
//  LanguageListViewController.m
//  AppInternationalization
//
//  Created by 龚纯 on 16/7/29.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import "LanguageListViewController.h"
#import "AppDelegate.h"
@interface LanguageListViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) NSArray *languageArray;
@property (assign) NSInteger selectIndex;

@end

@implementation LanguageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _languageArray = [LanguageManager languageStrings];
    _selectIndex = [LanguageManager currentLanguageIndex];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _languageArray.count;
}

#pragma mark tableView Delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString static *cellIdentity = @"languageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    
    if (indexPath.row == _selectIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellStyleDefault;
    }
    cell.textLabel.text = _languageArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _selectIndex = indexPath.row;
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)backButtonClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)doneButtonClick:(id)sender
{
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"prompt") message:NSLocalizedString(@"是否切换语言", @"Whether to switch language") delegate:self cancelButtonTitle: NSLocalizedString(@"是", @"YES")
                                           otherButtonTitles:NSLocalizedString(@"不是", @"NO"), nil];
    alert.delegate = self;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [LanguageManager saveLanguageByIndex:_selectIndex];
        [self reloadRootViewController];
    }
}

- (void)reloadRootViewController
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    delegate.window.rootViewController = [storyboard instantiateInitialViewController];
}


@end
