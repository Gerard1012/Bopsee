//  AppController.h
//  Created by BE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppController : NSObject

@property (nonatomic, strong) NSMutableArray *introSliderImages, *settingsList;
@property (nonatomic, strong) NSMutableArray *ageList, *heighList, *genderList, *ethnicityList;
@property (nonatomic, strong) NSMutableDictionary *currentUser, *apnsMessage, *receiverUser;
@property (nonatomic, strong) NSMutableArray *scheduledSessions, *availabilitySessions, *matchedUsers, *seeUsers, *guessUsers;

// Temporary Variables
@property (nonatomic, strong) NSString *currentMenuTag, *avatarUrlTemp, *facebookPhotoUrlTemp;
@property (nonatomic, strong) NSMutableDictionary *currentNavBark, *currentNavBarkStat;
@property (nonatomic, assign) BOOL isFromSignUpSecondPage, isNewBarkUploaded, isMyProfileChanged;
@property (nonatomic, strong) NSString *statsVelocityHistoryPeriod, *password, *latestMessageId;


// Utility Variables
@property (nonatomic, strong) UIColor *appMainColor, *appTextColor, *appThirdColor;
@property (nonatomic, strong) DoAlertView *vAlert;

+ (AppController *)sharedInstance;

@end