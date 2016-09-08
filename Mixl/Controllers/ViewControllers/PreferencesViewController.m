//
//  PreferencesViewController.m
//  Bopsee
//
//  Created by Admin on 6/13/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "PreferencesViewController.h"
#import "EthnicityTableViewCell.h"

@interface PreferencesViewController (){
    int ageMin;
    int ageMax;
    int heightMin;
    int heightMax;
    NSString* gender;
    NSString* ethnicity;
    BOOL changedFlag;
    
    NSMutableArray *clickEthnicity;
}

@end

@implementation PreferencesViewController

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
    
    changedFlag = NO;
    //ageMin = [[userSettings objectForKey:@"age_range_min"] intValue];
    //ageMax = [[userSettings objectForKey:@"age_range_max"] intValue];
    //heightMin = [[userSettings objectForKey:@"height_range_min"] intValue];
    //heightMax = [[userSettings objectForKey:@"height_range_max"] intValue];
    //gender = [userSettings objectForKey:@"user_gender"];
    //ethnicity = [userSettings objectForKey:@"user_ethnicity"];
    ageMin = 25;
    ageMax = 45;
    heightMin = 39;
    heightMax = 67;
    gender = @"male";
    ethnicity = @"Native American";
    
    clickEthnicity = [[NSMutableArray alloc] init];
    for(int i = 0; i < appController.ethnicityList.count; i++) [clickEthnicity addObject:@"0"];
  
}

- (void) initView{
    
    _lblGender.text = gender;
    _lblEthnicity.text = ethnicity;
    [self configureAgeSlider];
    [self configureHeightSlider];
    
    _viewEthnicity.layer.cornerRadius = 7.0f;
    _viewEthnicity.layer.borderWidth = 1.0f;
    _viewEthnicity.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _btnOK.layer.cornerRadius = 5.0f;
    _viewEthnicity.hidden = YES;
    
}

#pragma mark -

#pragma mark - Age Slider
- (void) configureMyThemeForSlider:(NMRangeSlider *)slider
{
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"slider-my-trackBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider-my-track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slider-my-handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 1, 1, 1)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"slider-my-handle-highlighted"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 1, 1, 1)];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
}


- (void) configureAgeSlider
{
    [self configureMyThemeForSlider:_ageSlider];
    _ageSlider.lowerValue = (float) ageMin / 100;
    _ageSlider.upperValue = (float) ageMax / 100;
    [self updateAgeRange];
}

#pragma mark - Height Slider
- (void) configureMy1ThemeForSlider:(NMRangeSlider *)slider
{
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"slider-my1-trackBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"slider-my1-track"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slider-my1-handle"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 1, 1, 1)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"slider-my1-handle-highlighted"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 1, 1, 1)];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
}

- (void) configureHeightSlider
{
    [self configureMy1ThemeForSlider:_heightSlider];
    _heightSlider.lowerValue = (float) heightMin / 100;
    _heightSlider.upperValue = (float) heightMax / 100;
    [self updateHeightRange];
}

- (IBAction)ageRangeSlider:(id)sender {
    changedFlag = YES;
    [self updateAgeRange];
}

- (IBAction)heightRangeSlider:(id)sender {
    changedFlag = YES;
    [self updateHeightRange];
}

- (void) updateAgeRange{
    _lblAgeRange.text = [NSString stringWithFormat:@"%d-%d",(int)((float)_ageSlider.lowerValue * 100),(int)((float)_ageSlider.upperValue * 100)];
}

- (void) updateHeightRange{
    int ftLower = (int)(((float)_heightSlider.lowerValue * 100) / 12);
    int inLower = (int)((int)((float)_heightSlider.lowerValue * 100) % 12);
    int ftUpper = (int)(((float)_heightSlider.upperValue * 100) / 12);
    int inUpper = (int)((int)((float)_heightSlider.upperValue * 100) % 12);
    _lblHeightRange.text = [NSString stringWithFormat:@"%d' %d\"-%d' %d\"", ftLower, inLower, ftUpper, inUpper];
}

#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    changedFlag = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onClickedGender:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _viewPic.frame;
        _viewPic.frame = CGRectMake(0, self.view.frame.size.height - rect.size.height, rect.size.width, rect.size.height);
    }];
}
- (IBAction)onClickedDone:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _viewPic.frame;
        _viewPic.frame = CGRectMake(0, self.view.frame.size.height, rect.size.width, rect.size.height);
    }];
}

- (IBAction)onClickedEthni:(id)sender {
    _viewEthnicity.hidden = NO;
}

- (IBAction)onClickedOK:(id)sender {
    _viewEthnicity.hidden = YES;
    NSString *ethni = @" ";
    for(int i = 0; i < appController.ethnicityList.count; i++){
        if([[clickEthnicity objectAtIndex:i] isEqualToString:@"1"]){
            if([ethni isEqualToString:@" "]){
                ethni = [NSString stringWithFormat:@"%@", [appController.ethnicityList objectAtIndex:i]];
            }else{
                ethni = [NSString stringWithFormat:@"%@, %@", ethni, [appController.ethnicityList objectAtIndex:i]];
            }
        }
    }
    ethnicity = ethni;
    _lblEthnicity.text = ethnicity;
}

- (IBAction)onBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onNextClicked:(id)sender {
    
    if(changedFlag == YES){
        //[self onSaveSettings];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DashboardViewController* dashboardViewController =
        (DashboardViewController*) [storyboard instantiateViewControllerWithIdentifier:@"DashboardVC"];
        [self.navigationController pushViewController:dashboardViewController animated:YES];
    }
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DashboardViewController* dashboardViewController =
        (DashboardViewController*) [storyboard instantiateViewControllerWithIdentifier:@"DashboardVC"];
        [self.navigationController pushViewController:dashboardViewController animated:YES];
    }
}

#pragma UIPickerViewDelegate Method
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numRow = 0;
    numRow = appController.genderList.count;
    return numRow;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *strPicker;
    strPicker = [appController.genderList objectAtIndex:row];
    return strPicker;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _lblGender.text = [appController.genderList objectAtIndex:row];
}


#pragma UITableViewDelegate Method
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numRow;
    numRow = appController.ethnicityList.count;
    return numRow;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        EthnicityTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"EthnicityTableViewCell"];
        cell.ethnicityName.text = [appController.ethnicityList objectAtIndex:indexPath.row];
        if([[clickEthnicity objectAtIndex:indexPath.row] isEqualToString:@"0"]) cell.imgCheck.hidden = YES;
        else cell.imgCheck.hidden = NO;
        return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if([[clickEthnicity objectAtIndex:indexPath.row] isEqualToString:@"0"]){
            [clickEthnicity replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        else{
            [clickEthnicity replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }
        [tableView reloadData];
}


- (void)onSaveSettings{
    
    NSString* age_range_min = [NSString stringWithFormat:@"%d", (int)((float)_ageSlider.lowerValue * 100)];
    NSString* age_range_max = [NSString stringWithFormat:@"%d", (int)((float)_ageSlider.upperValue * 100)];
    NSString* height_range_min = [NSString stringWithFormat:@"%d", (int)((float)_heightSlider.lowerValue * 100)];
    NSString* height_range_max = [NSString stringWithFormat:@"%d", (int)((float)_heightSlider.upperValue * 100)];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_lblGender.text forKey:@"gender"];
    [dic setObject:age_range_min forKey:@"age_range_min"];
    [dic setObject:age_range_max forKey:@"age_range_max"];
    [dic setObject:height_range_min forKey:@"height_range_min"];
    [dic setObject:height_range_max forKey:@"height_range_max"];
    [dic setObject:_lblEthnicity.text forKey:@"ethnicity"];
    
    [JSWaiter ShowWaiter:self.view title:@"Updating..." type:0];
    [NSThread detachNewThreadSelector:@selector(requestUpdateSettings:) toTarget:self withObject:dic];
}

#pragma mark - request data user profile change
- (void) requestUpdateSettings:(id) params {
    
    NSDictionary *resObj = nil;
    resObj = [commonUtils myhttpJsonRequest:API_URL_SETTINGS withJSON:params];
    
    [JSWaiter HideWaiter];
    
    if (resObj != nil) {
        NSDictionary *result = (NSDictionary *)resObj;
        NSDecimalNumber *status = [result objectForKey:@"error"];
        if([status intValue] == 0) {
            
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            
            userInfo = appController.currentUser;
            [userInfo setObject:[result objectForKey:@"preference"] forKey:@"preference"];
            appController.currentUser =  userInfo;
            [commonUtils setUserDefault:@"settingChanged" withFormat:@"1"];
            
            [commonUtils setUserDefaultDic:@"current_user" withDic:appController.currentUser];
            NSLog(@"------------user info updated setting : %@", appController.currentUser);
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DashboardViewController* dashboardViewController =
            (DashboardViewController*) [storyboard instantiateViewControllerWithIdentifier:@"DashboardVC"];
            [self.navigationController pushViewController:dashboardViewController animated:YES];
            
        } else {
            NSArray *msg = (NSArray *)[resObj objectForKey:@"messages"];
            NSString *stringMsg = (NSString *)[msg objectAtIndex:0];
            if([stringMsg isEqualToString:@""]) stringMsg = @"Please complete entire form";
            [commonUtils showVAlertSimple:@"Warning" body:stringMsg duration:1.4];
        }
    } else {
        [commonUtils showVAlertSimple:@"Connection Error" body:@"Please check your internet connection status" duration:1.0];
    }
}


@end
