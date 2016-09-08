//
//  DashboardViewController.m
//  Bopsee
//
//  Created by Admin on 6/13/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "DashboardViewController.h"
#import "DashboardTableViewCell.h"

@interface DashboardViewController (){
    NSMutableArray* scheduledSessions;
}

@end

@implementation DashboardViewController

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
    scheduledSessions = appController.scheduledSessions;
}

- (void) initView{
    //Alert View
    _viewAlertCon.layer.cornerRadius = 3.0f;
    _btnYes.layer.cornerRadius = 15.0f;
    _viewAlert.hidden = YES;
}


- (IBAction)onClickedSetting:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsViewController* settingsViewViewController =
    (SettingsViewController*) [storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
    [self.navigationController pushViewController:settingsViewViewController animated:YES];
}

- (IBAction)onClickedHeart:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MachesViewController* matchesViewController =
    (MachesViewController*) [storyboard instantiateViewControllerWithIdentifier:@"MatchesVC"];
    [self.navigationController pushViewController:matchesViewController animated:YES];
}

- (IBAction)onClickedPluse:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChooseSessionViewController* chooseSessionViewViewController =
    (ChooseSessionViewController*) [storyboard instantiateViewControllerWithIdentifier:@"ChooseSessionVC"];
    [self.navigationController pushViewController:chooseSessionViewViewController animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [scheduledSessions count];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DashboardTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DashboardTableViewCell"];
    
    NSMutableDictionary *dic = [scheduledSessions objectAtIndex:indexPath.row];
    
    [cell.lblScheduled setText:[dic objectForKey:@"session_date"]];
    
    NSString* sessionState = @" ";
    UIColor*  txtColor = [UIColor whiteColor];
    switch ([[dic objectForKey:@"session_state"] intValue]) {
        
        case SESSION_STATE_CONFIRM:
            
            sessionState = @"Confirmed";
            txtColor = UIColorFromRGB(0x4CAB00);
            
            break;
            
        case SESSION_STATE_PENDING:

            sessionState = @"Pending";
            txtColor = UIColorFromRGB(0xff9c00);
            break;

        case SESSION_STATE_CANCEL:
        
            sessionState = @"Cancelled";
            txtColor = UIColorFromRGB(0x888888);
            break;

        default:
            break;
    }
    
    [cell.lblScheduleState setText:sessionState];
    cell.lblScheduleState.textColor = txtColor;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic = [scheduledSessions objectAtIndex:indexPath.row];
    if([[dic objectForKey:@"session_state"] isEqualToString:@"2"]) return NO;
    else return YES;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        UITableViewRowAction *action;
    action =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"    Cancel  " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action.backgroundColor = UIColorFromRGB(0x5bb000);
    
    [self performSelector:@selector(delay:) withObject:indexPath afterDelay:2.0];
    return @[action];
    
}

-(void) delay:(NSIndexPath *) indexPath {
    [scheduledSessions removeObjectAtIndex:indexPath.row];
    // [_selectedContacts removeObjectAtIndex:indexPath.row];
    //api call
    [_tableScheduledSessions reloadData];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSMutableDictionary *dic = [scheduledSessions objectAtIndex:indexPath.row];
    if([[dic objectForKey:@"session_state"] isEqualToString:@"0"]){
    
    _lblAlert.text = [NSString stringWithFormat:@"Your seesion will start on %@.", [dic objectForKey:@"session_date"]];
    _viewAlert.hidden = NO;
    //[commonUtils showVAlertSimple:@"Warning!" body:[NSString stringWithFormat:@"Your seesion will start on %@.", [dic objectForKey:@"session_date"]] duration:1.0];
        
     
    }
    else{
        
        if([[dic objectForKey:@"session_state"] isEqualToString:@"1"]){
            _lblAlert.text = @"Based on your preferences there are not enough people for your session.";
            _viewAlert.hidden = NO;
            //[commonUtils showVAlertSimple:@"Warning!" body:@"Based on your preferences there are not enough people for your session." duration:1.0];
        }
        else{
            _lblAlert.text = @"Based on your preferences there were not enough people for your session.";
            _viewAlert.hidden = NO;
            //[commonUtils showVAlertSimple:@"Warning!" body:@"Based on your preferences there were not enough people for your session." duration:1.0];
        }
    }
}

- (IBAction)onClickedOK:(id)sender {
    
    if ([_lblAlert.text rangeOfString:@"start"].location == NSNotFound){
        _viewAlert.hidden = YES;
    }
    else{
        _viewAlert.hidden = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WaitingRoomViewController* waitingRoomViewController =
        (WaitingRoomViewController*) [storyboard instantiateViewControllerWithIdentifier:@"WatingRoomVC"];
        [self.navigationController pushViewController:waitingRoomViewController animated:YES];

    }
}

@end
