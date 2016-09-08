//
//  AppSettingsViewController.h
//  Bopsee
//
//  Created by Admin on 6/15/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *swCommunication;
@property (weak, nonatomic) IBOutlet UISwitch *swText;
@property (weak, nonatomic) IBOutlet UISwitch *swEmail;
@property (weak, nonatomic) IBOutlet UISwitch *swAppNotification;

@property (weak, nonatomic) IBOutlet UIView *viewAlert;
@property (weak, nonatomic) IBOutlet UIView *viewAlertCon;
@property (weak, nonatomic) IBOutlet UIButton *btnYes;
@property (weak, nonatomic) IBOutlet UIButton *btnNo;

@end
