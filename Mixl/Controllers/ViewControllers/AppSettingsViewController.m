//
//  AppSettingsViewController.m
//  Bopsee
//
//  Created by Admin on 6/15/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "AppSettingsViewController.h"

@interface AppSettingsViewController ()

@end

@implementation AppSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView{
    
    //Alert View
    _viewAlertCon.layer.cornerRadius = 3.0f;
    _btnYes.layer.cornerRadius = 13.0f;
    _btnNo.layer.cornerRadius = 13.0f;
    _viewAlert.hidden = YES;
    
    _swCommunication.on = YES;
    _swText.on = YES;
    _swEmail.on = YES;
    _swAppNotification.on = YES;
}

- (IBAction)onBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onDisableClicked:(id)sender {
    
    _viewAlert.hidden = NO;
}

- (IBAction)onYESClicked:(id)sender {
    
    _viewAlert.hidden = YES;
    [commonUtils removeUserDefaultDic:@"current_user"];
    appController.currentUser = [[NSMutableDictionary alloc] init];
    [commonUtils setUserDefault:@"logged_out" withFormat:@"1"];
    //    [commonUtils setUserDefault:@"flag_location_query_enabled" withFormat:@"0"];
    //    [commonUtils setUserDefault:@"settingChanged" withFormat:@"0"];
    //[self.navigationController popToRootViewControllerAnimated:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController* loginViewController =
    (LoginViewController*) [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)onNOClicked:(id)sender {
    _viewAlert.hidden = YES;
}


- (IBAction)onLogoutClicked:(id)sender {
    
    [commonUtils removeUserDefaultDic:@"current_user"];
    appController.currentUser = [[NSMutableDictionary alloc] init];
    [commonUtils setUserDefault:@"logged_out" withFormat:@"1"];
//    [commonUtils setUserDefault:@"flag_location_query_enabled" withFormat:@"0"];
//    [commonUtils setUserDefault:@"settingChanged" withFormat:@"0"];
    //[self.navigationController popToRootViewControllerAnimated:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController* loginViewController =
    (LoginViewController*) [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

- (IBAction)clickedSWCommunication:(id)sender {
}

- (IBAction)clickedSWText:(id)sender {
}

- (IBAction)clickedSWEmail:(id)sender {
}

- (IBAction)clickedSWAppNotification:(id)sender {
}

@end
