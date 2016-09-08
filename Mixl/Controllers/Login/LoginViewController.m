//
//  LoginViewController.m
//  Mixl
//
//  Created by admin on 4/6/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UIScrollViewDelegate> {
    
    IBOutlet UIScrollView *introScrollView;
    IBOutlet UIView *introScrollContent1View;
    IBOutlet UIView *introScrollContent2View;
    IBOutlet UIView *introScrollContent3View;
    IBOutlet UIView *introScrollContent4View;
    IBOutlet UIView *introScrollContent5View;
    
    IBOutlet UIPageControl *introPageControl;
    int introIndex;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void) initView {
    
    [introPageControl.layer setZPosition:10];
    
    NSInteger pageCount = 5;
    
    introScrollView.contentSize = CGSizeMake(introScrollView.frame.size.width * pageCount, introScrollView.frame.size.height);
    introScrollView.pagingEnabled = YES;
    [commonUtils removeAllSubViews:introScrollView];
    
    CGRect frame1 = introScrollContent1View.frame;
    frame1.origin.x = 0;
    [introScrollContent1View setFrame:frame1];
    
    CGRect frame2 = introScrollContent2View.frame;
    frame2.origin.x = introScrollView.frame.size.width;
    [introScrollContent2View setFrame:frame2];
    
    CGRect frame3 = introScrollContent3View.frame;
    frame3.origin.x = introScrollView.frame.size.width * 2;
    [introScrollContent3View setFrame:frame3];
    
    CGRect frame4 = introScrollContent4View.frame;
    frame4.origin.x = introScrollView.frame.size.width * 3;
    [introScrollContent4View setFrame:frame4];

    CGRect frame5 = introScrollContent5View.frame;
    frame5.origin.x = introScrollView.frame.size.width * 4;
    [introScrollContent5View setFrame:frame5];

    
    [introScrollView addSubview:introScrollContent1View];
    [introScrollView addSubview:introScrollContent2View];
    [introScrollView addSubview:introScrollContent3View];
    [introScrollView addSubview:introScrollContent4View];
    [introScrollView addSubview:introScrollContent5View];
    
    introScrollView.pagingEnabled = YES;
    introIndex = 0;
    
    [self setIntro];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.2];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    introIndex = (introScrollView.contentOffset.x / introScrollView.frame.size.width);
    [self setIntro];
}
- (void)setIntro {
    introPageControl.currentPage = introIndex;
}


- (IBAction)onFBSignInClicked:(id)sender {
    if(self.isLoadingUserBase) return;
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_birthday", @"user_photos"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in with token : @%@", result.token);
             if ([result.grantedPermissions containsObject:@"email"]) {
                 NSLog(@"result is:%@",result);
                 [self fetchUserInfo];
             }
         }
     }];

}

- (void)fetchUserInfo {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken] tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, gender, bio, location, friends, hometown, friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"facebook fetched info : %@", result);
                 
                 NSDictionary *temp = (NSDictionary *)result;
                 NSMutableDictionary *userFBInfo = [[NSMutableDictionary alloc] init];
                 [userFBInfo setObject:[temp objectForKey:@"id"] forKey:@"user_facebook_id"];
                 
                 [userFBInfo setObject:[temp objectForKey:@"email"] forKey:@"user_email"];
                 
                 if([commonUtils checkKeyInDic:@"first_name" inDic:[temp mutableCopy]]) {
                     [userFBInfo setObject:[temp objectForKey:@"first_name"] forKey:@"user_first_name"];
                 }
                 if([commonUtils checkKeyInDic:@"last_name" inDic:[temp mutableCopy]]) {
                     [userFBInfo setObject:[temp objectForKey:@"last_name"] forKey:@"user_last_name"];
                 }
                 
                 NSString *gender = @"1";
                 if([commonUtils checkKeyInDic:@"gender" inDic:[temp mutableCopy]]) {
                     if([[temp objectForKey:@"gender"] isEqualToString:@"female"]) gender = @"2";
                 }
                 [userFBInfo setObject:gender forKey:@"user_gender"];
                 
                 NSString *age = @"30";
                 if([commonUtils checkKeyInDic:@"age" inDic:[temp mutableCopy]]) {
                     age = [NSString stringWithFormat:@"%@", [temp objectForKey:@"age"]];
                 }
                 [userFBInfo setObject:age forKey:@"user_age"];
                 
//                 if([commonUtils getUserDefault:@"currentLatitude"] && [commonUtils getUserDefault:@"currentLongitude"]) {
//                     [userFBInfo setObject:[commonUtils getUserDefault:@"currentLatitude"] forKey:@"user_location_latitude"];
//                     [userFBInfo setObject:[commonUtils getUserDefault:@"currentLongitude"] forKey:@"user_location_longitude"];
//                 }
                 
                 NSString *fbProfilePhoto = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [temp objectForKey:@"id"]];
                 [userFBInfo setObject:fbProfilePhoto forKey:@"user_photo_url"];
                 
                 [userFBInfo setObject:@"2" forKey:@"signup_mode"];
                 
                 if([commonUtils getUserDefault:@"user_apns_id"] != nil) {
                     [userFBInfo setObject:[commonUtils getUserDefault:@"user_apns_id"] forKey:@"user_apns_id"];
                     
                     self.isLoadingUserBase = YES;
                     //[commonUtils showActivityIndicatorColored:self.view];
                     //            [NSThread detachNewThreadSelector:@selector(requestData:) toTarget:self withObject:userInfo];
                     [self requestData:userFBInfo];
                     
                 } else {
                     [appController.vAlert doAlert:@"Notice" body:@"Failed to get your device token.\nTherefore, you will not be able to receive notification for the new activities." duration:1.0f done:^(DoAlertView *alertView) {
                         
                         self.isLoadingUserBase = YES;
                         //[commonUtils showActivityIndicatorColored:self.view];
                         // [NSThread detachNewThreadSelector:@selector(requestData:) toTarget:self withObject:userInfo];
                         [self requestData:userFBInfo];
                     }];
                 }
                 
             } else {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}


#pragma mark - API Request - User Signup After FB Login
- (void) requestData:(id) params {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserImportViewController* userImportController =
    (UserImportViewController*) [storyboard instantiateViewControllerWithIdentifier:@"UserImportVC"];
    userImportController.userFBInfo = params;
    [self.navigationController pushViewController:userImportController animated:YES];

    
//    NSDictionary *resObj = nil;
//    resObj = [commonUtils httpJsonRequest:API_URL_USER_FBLOGIN withJSON:(NSMutableDictionary *) params];
//    
    self.isLoadingUserBase = NO;
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
    
}

@end
