//
//  LanguageListViewController.h
//  AppInternationalization
//
//  Created by 龚纯 on 16/7/29.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanguageManager.h"
@interface LanguageListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
