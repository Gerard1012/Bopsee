//
//  AppController.m


#import "AppController.h"

static AppController *_appController;

@implementation AppController

+ (AppController *)sharedInstance {
    static dispatch_once_t predicate;
    if (_appController == nil) {
        dispatch_once(&predicate, ^{
            _appController = [[AppController alloc] init];
        });
    }
    return _appController;
}

- (id)init {
    self = [super init];
    if (self) {
        
        // Utility Data
        _appMainColor = RGBA(239, 238, 226, 1.0f);
        _appTextColor = RGBA(41, 43, 48, 1.0f);
        _appThirdColor = RGBA(61, 155, 196, 1.0f);
        
        _vAlert = [[DoAlertView alloc] init];
        _vAlert.nAnimationType = 2;  // there are 5 type of animation
        _vAlert.dRound = 7.0;
        _vAlert.bDestructive = NO;  // for destructive mode
        
        
        // Intro Images
        _introSliderImages = (NSMutableArray *) @[
                                                  @"intro1",
                                                  @"intro2",
                                                  @"intro3",
                                                  @"intro4",
                                                  @"intro5"
                                                  ];
        
        _settingsList = (NSMutableArray *) @[     @"Matches",
                                                  @"App Settings",
                                                  @"Preferences",
                                                  @"Help & Support",
                                                  @"Give Us Feedback"
                                                  ];
        

        _ageList = [[NSMutableArray alloc] init];
        _heighList = [[NSMutableArray alloc] init];
        _genderList = [[NSMutableArray alloc] init];
        _ethnicityList = [[NSMutableArray alloc] init];
        
        for(int i = 17; i < 71; i++) [_ageList addObject:[NSString stringWithFormat:@"%d", i]];
        for(int j = 39; j < 101; j++){
            int a = (int) (j / 12);
            int b = (int) (j % 12);
            [_heighList addObject:[NSString stringWithFormat:@"%d' %d\"", a, b]];
        }
        _genderList = [@[
                        @"male",
                        @"female"
                        ] mutableCopy];

        _ethnicityList  = [@[
                             @"Asian",
                             @"Middle Eastern",
                             @"Black",
                             @"Native American",
                             @"Hispanic/Latin",
                             @"Pacific Islander",
                             @"Indian",
                             @"White",
                             @"Two or more races"
                             ] mutableCopy];
        
        _scheduledSessions = [[NSMutableArray alloc] init];
        _scheduledSessions = [@[
                        [@{@"session_date" : @"June 11, 2016 8:00 PM", @"session_state" : @"0"} mutableCopy],
                        [@{@"session_date" : @"June 12, 2016 9:00 PM", @"session_state" : @"1"} mutableCopy],
                        [@{@"session_date" : @"June 13, 2016 9:00 PM", @"session_state" : @"1"} mutableCopy],
                        [@{@"session_date" : @"June 14, 2016 8:00 PM", @"session_state" : @"0"} mutableCopy],
                        [@{@"session_date" : @"June 15, 2016 10:00 PM", @"session_state" : @"2"} mutableCopy],
                        [@{@"session_date" : @"June 16, 2016 8:00 PM", @"session_state" : @"0"} mutableCopy],
                        ] mutableCopy];
        
        
        _availabilitySessions = [[NSMutableArray alloc] init];
        _availabilitySessions = [@[
                                   [@{@"session_date" : @"8:00 PM", @"session_state" : @"0"} mutableCopy],
                                   [@{@"session_date" : @"9:00 PM", @"session_state" : @"0"} mutableCopy],
                                   [@{@"session_date" : @"10:00 PM", @"session_state" : @"0"} mutableCopy],
                                   ] mutableCopy];

        
        _matchedUsers = [[NSMutableArray alloc] init];
        _matchedUsers = [@[
                           [@{@"image" : @"user1", @"name" : @"Dean Decarlo"} mutableCopy],
                           [@{@"image" : @"user2", @"name" : @"John Hose"} mutableCopy],
                           [@{@"image" : @"user3", @"name" : @"Joe Done"} mutableCopy],
                           [@{@"image" : @"user4", @"name" : @"Amanda Decarlo"} mutableCopy],
                           [@{@"image" : @"user5", @"name" : @"Ela Hose"} mutableCopy],
                           [@{@"image" : @"user6", @"name" : @"Eily Done"} mutableCopy],
                           ] mutableCopy];


        _seeUsers = [[NSMutableArray alloc] init];
//        _seeUsers = [@[
//                           [@{@"image" : @"user1", @"name" : @"Dean Decarlo"} mutableCopy],
//                           [@{@"image" : @"user2", @"name" : @"John Hose"} mutableCopy],
//                           ] mutableCopy];
        
        _guessUsers = [[NSMutableArray alloc] init];
        _guessUsers = [@[
                       [@{@"image" : @"user1", @"name" : @"Dean Decarlo"} mutableCopy],
                       [@{@"image" : @"user2", @"name" : @"John Hose"} mutableCopy],
                       [@{@"image" : @"user3", @"name" : @"Joe Done"} mutableCopy],
                       ] mutableCopy];
        
        _isFromSignUpSecondPage = NO;
        _isNewBarkUploaded = NO;
        _isMyProfileChanged = NO;
        
        // Data
        _currentUser = [[NSMutableDictionary alloc] init];
        _receiverUser = [[NSMutableDictionary alloc] init];

    }
    return self;
}


+ (NSDictionary*) requestApi:(NSMutableDictionary *)params withFormat:(NSString *)url {
    return [AppController jsonHttpRequest:url jsonParam:params];
}

+ (id) jsonHttpRequest:(NSString*) urlStr jsonParam:(NSMutableDictionary *)params {
    NSString *paramStr = [commonUtils getParamStr:params];
    //NSLog(@"\n\nparameter string : \n\n%@", paramStr);
    NSData *requestData = [paramStr dataUsingEncoding:NSUTF8StringEncoding];

    NSData *data = nil;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSHTTPURLResponse *response = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody: requestData];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
//    NSLog(@"\n\nresponse string : \n\n%@", responseString);
    return [[SBJsonParser new] objectWithString:responseString];
}

@end
