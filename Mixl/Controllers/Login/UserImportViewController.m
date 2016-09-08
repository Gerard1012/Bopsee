//
//  UserImportViewController.m
//  Bopsee
//
//  Created by Admin on 6/13/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "UserImportViewController.h"

@interface UserImportViewController ()

@end

@implementation UserImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView{
    
    self.btnAccept.layer.cornerRadius = 25.0f;
    self.btnDecline.layer.cornerRadius = 25.0f;
   
    [commonUtils setCircleViewImage:_viewUserImage imageview:_imgUser borderWidth:2.0f borderColor:[UIColor lightGrayColor]];
    
    NSString* avatarImageURL = [self.userFBInfo objectForKey:@"user_photo_url"];
    NSLog(@"avatar image URL : %@", avatarImageURL);
    if ([avatarImageURL isEqual:[NSNull null]]){
        [_imgUser setImage:[UIImage imageNamed:@"no_photo"]];
    }else{
        
        [commonUtils setImageViewAFNetworking:_imgUser withImageUrl:avatarImageURL withPlaceholderImage:[UIImage imageNamed:@"no_photo"]];
        
//        NSURL* imageURL = [NSURL URLWithString:avatarImageURL];
//        _imgUser.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    }

}


- (IBAction)onClickedAccept:(id)sender {
    
    //    NSDictionary *resObj = nil;
    //    resObj = [commonUtils httpJsonRequest:API_URL_USER_FBLOGIN withJSON:(NSMutableDictionary *) params];
    //
    //    self.isLoadingUserBase = NO;
    //    [JSWaiter HideWaiter];
    //
    //    if (resObj != nil) {
    //        NSDictionary *result = (NSDictionary*)resObj;
    //        NSString *str = [result objectForKey:@"error"];
    //        int flag = [str intValue];
    //        if(flag == 0) {
    //
    //            appController.currentUser = [NSMutableDictionary dictionaryWithDictionary:result];
    //            [commonUtils setUserDefault:@"authorized_token" withFormat:[[result objectForKey:@"user"] objectForKey:@"token"]];
    //            [commonUtils setUserDefault:@"flag_location_query_enabled" withFormat:@"1"];
    //            [commonUtils setUserDefaultDic:@"current_user" withDic:appController.currentUser];
    //            NSLog(@"current user : %@", appController.currentUser);
    //
    //            [commonUtils setUserDefault:@"settingChanged" withFormat:@"1"];
    //            [(AppDelegate *)[[UIApplication sharedApplication] delegate] updateLocationManager];
    //
    //
    ////            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ////            UserImportViewController* userImportController =
    ////            (UserImportViewController*) [storyboard instantiateViewControllerWithIdentifier:@"UserImportVC"];
    ////            [self.navigationController pushViewController:userImportController animated:YES];
    //
    //
    //        } else {
    //            NSArray *msg = (NSArray *)[resObj objectForKey:@"messages"];
    //            NSString *stringMsg = (NSString *)[msg objectAtIndex:0];
    //            if([stringMsg isEqualToString:@""]) stringMsg = @"Please complete entire form";
    //            [commonUtils showVAlertSimple:@"Warning" body:stringMsg duration:1.4];
    //
    //        }
    //    } else {
    //        [commonUtils showVAlertSimple:@"Connection Error" body:@"Please check your internet connection status" duration:1.0];
    //    }
    
    
    appController.currentUser = [NSMutableDictionary dictionaryWithDictionary:self.userFBInfo];
    [commonUtils setUserDefaultDic:@"current_user" withDic:appController.currentUser];
    NSLog(@"current user : %@", appController.currentUser);

    [commonUtils setUserDefault:@"settingChanged" withFormat:@"1"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoViewController* userInfoViewController =
            (UserInfoViewController*) [storyboard instantiateViewControllerWithIdentifier:@"UserInfoVC"];
    [self.navigationController pushViewController:userInfoViewController animated:YES];

}

- (IBAction)onClickedDecline:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}


@end
