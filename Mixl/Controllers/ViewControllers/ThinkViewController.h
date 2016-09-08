//
//  ThinkViewController.h
//  Bopsee
//
//  Created by Admin on 6/15/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThinkViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblNextTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDateName;
@property (weak, nonatomic) IBOutlet UIImageView *imgDate;

@property (strong, nonatomic) NSMutableDictionary   *dateInfo;

@end
