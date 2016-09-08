//
//  ChooseSessionViewController.m
//  Bopsee
//
//  Created by Admin on 6/14/16.
//  Copyright © 2016 Brani. All rights reserved.
//

 
#import "ChooseSessionTableViewCell.h"

@interface ChooseSessionViewController (){
    NSMutableArray* availabilitySessions;
    NSString* selectedSessionDay;
}

@property (nonatomic, strong) CalendarView * calendarView;

@end

@implementation ChooseSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData{
    availabilitySessions = appController.availabilitySessions;
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init] ;
    [fomatter setDateFormat:@"MMMM dd, yyyy"];
    selectedSessionDay = [fomatter stringFromDate:[NSDate date]];
}

- (void) initView{
    
    //Alert View
    _viewAlertCon.layer.cornerRadius = 3.0f;
    _btnYes.layer.cornerRadius = 13.0f;
    _btnNo.layer.cornerRadius = 13.0f;
    _viewAlert.hidden = YES;
    
    //Calendar init
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"Default Calendar";
    _calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(0, 80, [[UIScreen mainScreen] bounds].size.width - 20, [[UIScreen mainScreen] bounds].size.height - 280)];
    NSLog(@"Hight ------------------> %d", (int)[[UIScreen mainScreen] bounds].size.height);
    _calendarView.delegate    = self;
    _calendarView.datasource  = self;
    _calendarView.calendarDate = [NSDate date];
    _calendarView.monthAndDayTextColor        = [UIColor darkGrayColor];
    _calendarView.dayBgColorWithoutData       = [UIColor clearColor];
    _calendarView.dayBgColorSelected          = UIColorFromRGB(0xd51755);
    _calendarView.dayTxtColorWithoutData      = [UIColor darkGrayColor];
    _calendarView.dayTxtColorSelected         = [UIColor whiteColor];
    _calendarView.dayTxtColorEvent            = [UIColor redColor];;
    _calendarView.borderColor                 = [UIColor clearColor];
    
    _calendarView.allowsChangeMonthByDayTap   = YES;
    _calendarView.allowsChangeMonthByButtons  = YES;
    _calendarView.keepSelDayWhenMonthChange   = YES;
    _calendarView.nextMonthAnimation          = UIViewAnimationOptionTransitionFlipFromRight;
    _calendarView.prevMonthAnimation          = UIViewAnimationOptionTransitionFlipFromLeft;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:_calendarView];
        _calendarView.center = CGPointMake(self.view.center.x, _calendarView.center.y);
    });
    
}

- (IBAction)onBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSubmitClicked:(id)sender {
    BOOL isItem;
    isItem = NO;
    for(NSMutableDictionary *session in availabilitySessions){
        if([[session objectForKey:@"session_state"] isEqualToString:@"1"]){
            isItem = YES;
        }
    }
    if(isItem == YES){
        _viewAlert.hidden = NO;
        [self.view bringSubviewToFront:_viewAlert];
    }
    else{
        [commonUtils showVAlertSimple:@"Warning!" body:@"Please Choose Availability Sessions." duration:1.0];
    }
}

- (IBAction)onClickedYes:(id)sender {
    _viewAlert.hidden = YES;
    for(NSMutableDictionary *session in availabilitySessions){
        if([[session objectForKey:@"session_state"] isEqualToString:@"1"]){
            NSMutableDictionary *newSession = [[NSMutableDictionary alloc] init];
            [newSession setObject:[NSString stringWithFormat:@"%@ %@", selectedSessionDay, [session objectForKey:@"session_date"]] forKey:@"session_date"];
            [newSession setObject:@"1" forKey:@"session_state"];
            [appController.scheduledSessions addObject:newSession];
        }
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DashboardViewController* dashboardViewController =
    (DashboardViewController*) [storyboard instantiateViewControllerWithIdentifier:@"DashboardVC"];
    [self.navigationController pushViewController:dashboardViewController animated:YES];

}

- (IBAction)onClickedNo:(id)sender {
    _viewAlert.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [availabilitySessions count];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseSessionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseSessionTableViewCell"];
    
    NSMutableDictionary *dic = [availabilitySessions objectAtIndex:indexPath.row];
    
    [cell.lblSessionDate setText:[NSString stringWithFormat:@"%@ %@", selectedSessionDay, [dic objectForKey:@"session_date"]]];
    
    NSString* sessionState;
    UIColor*  txtColor;
    if([[dic objectForKey:@"session_state"] isEqualToString:@"1"])
    {
        sessionState = @"JOIN";
        txtColor = UIColorFromRGB(0x4CAB00);
        cell.imgJOIN.highlighted = NO;
    }
    else{
        sessionState = @" ";
        txtColor = [UIColor clearColor];
        cell.imgJOIN.highlighted = YES;
    }
    
    [cell.lblJOIN setText:sessionState];
    cell.lblJOIN.textColor = txtColor;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [availabilitySessions objectAtIndex:indexPath.row];
    
    if([[dic objectForKey:@"session_state"] isEqualToString:@"1"])
    {
        [dic setObject:@"0" forKey:@"session_state"];
    }
    else{
        [dic setObject:@"1" forKey:@"session_state"];
    }
    [availabilitySessions setObject:dic atIndexedSubscript:indexPath.row];
    [_tableAvailability reloadData];
}

#pragma mark - CalendarDelegate protocol conformance

-(void)dayChangedToDate:(NSDate *)selectedDate
{
    NSLog(@"dayChangedToDate %@",selectedDate);
    
//    NSDate* date;
//    NSTimeInterval sec = [selectedDate timeIntervalSince1970] + 86400;
//    date = [NSDate dateWithTimeIntervalSince1970:sec];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init] ;
    [fomatter setDateFormat:@"MMMM dd, yyyy"];
    selectedSessionDay = [fomatter stringFromDate:selectedDate];
    [_tableAvailability reloadData];
}


#pragma mark - CalendarDataSource protocol conformance

-(BOOL)isDataForDate:(NSDate *)date
{
//    NSDate * eventDay;
//    for(eventDay in _eventDayList)
//    {   if ([date compare:eventDay] == NSOrderedSame)
//        return YES;
//    }
   return NO;
}

- (BOOL) canSwipeToDate:(NSDate *)date {
    return YES;
}



@end
