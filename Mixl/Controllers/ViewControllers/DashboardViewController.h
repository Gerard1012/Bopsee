//
//  DashboardViewController.h
//  Bopsee
//
//  Created by Admin on 6/13/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableScheduledSessions;
@property (weak, nonatomic) IBOutlet UIView *viewAlert;
@property (weak, nonatomic) IBOutlet UIView *viewAlertCon;
@property (weak, nonatomic) IBOutlet UIButton *btnYes;
@property (weak, nonatomic) IBOutlet UILabel *lblAlert;

@end
