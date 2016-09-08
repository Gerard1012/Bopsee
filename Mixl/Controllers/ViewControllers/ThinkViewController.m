//
//  ThinkViewController.m
//  Bopsee
//
//  Created by Admin on 6/15/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "ThinkViewController.h"

@interface ThinkViewController (){
    NSString* nextTime;
    NSString* see;
}

@end

@implementation ThinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData{
    nextTime = @"1:00";
}

- (void) initView{
    _lblNextTime.text = nextTime;
    _lblDateName.text = [_dateInfo objectForKey:@"name"];
    [_imgDate setImage:[UIImage imageNamed:[_dateInfo objectForKey:@"image"]]];
}

- (IBAction)onBopClicked:(id)sender {
    see = @"0";
    [self thinkResult];
}

- (IBAction)onSeeClicked:(id)sender {
    see = @"1";
    [self thinkResult];
}

- (void) thinkResult{
    
    NSMutableArray *sees = [[NSMutableArray alloc] init];
    sees = appController.seeUsers;
    if([see isEqualToString:@"1"]){
        [sees addObject:_dateInfo];
    }
    else{
        [sees removeObject:_dateInfo];
    }
    appController.seeUsers = sees;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WrapViewController* wrapViewViewController =
    (WrapViewController*) [storyboard instantiateViewControllerWithIdentifier:@"WrapVC"];
    [self.navigationController pushViewController:wrapViewViewController animated:YES];
}

@end
