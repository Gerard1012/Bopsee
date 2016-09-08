//
//  ProfileViewController.m
//  Bopsee
//
//  Created by Admin on 6/15/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "ProfileViewController.h"
#import "EthnicityTableViewCell.h"

@interface ProfileViewController (){
    
    NSString* firstName, *userName, *userEmail, *userAge, *userHeight, *userGender, *userLocation, *userEthnicity;
    NSMutableArray *clickEthnicity;
    BOOL age, height, gender;
}
@end

@implementation ProfileViewController

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
    clickEthnicity = [[NSMutableArray alloc] init];
    for(int i = 0; i < appController.ethnicityList.count; i++) [clickEthnicity addObject:@"0"];
    
}

- (void) initView{
    
    [commonUtils setCircleViewImage:_viewUserImage imageview:_imgUser borderWidth:2.0f borderColor:[UIColor lightGrayColor]];
    
    NSString* avatarImageURL = [appController.currentUser objectForKey:@"user_photo_url"];
    NSLog(@"avatar image URL : %@", avatarImageURL);
    if ([avatarImageURL isEqual:[NSNull null]]){
        [_imgUser setImage:[UIImage imageNamed:@"no_photo"]];
    }else{
        
        [commonUtils setImageViewAFNetworking:_imgUser withImageUrl:avatarImageURL withPlaceholderImage:[UIImage imageNamed:@"no_photo"]];
    }
    
    firstName = [appController.currentUser objectForKey:@"user_first_name"];
    if (firstName != nil){
        _txtName.text = firstName;
    }
    else{
        _txtName.text = @" ";
    }
    
    userName = [appController.currentUser objectForKey:@"user_user_name"];
    if (userName != nil){
        _txtDisplayName.text = userName;
    }
    else{
        if(firstName != nil){
            _txtDisplayName.text = [NSString stringWithFormat:@"%@123", firstName];
        }
    }
    
    userEmail = [appController.currentUser objectForKey:@"user_email"];
    if (userEmail != nil){
        _txtEmail.text = userEmail;
    }
    else{
        _txtEmail.text = [NSString stringWithFormat:@"%@@gmail.com", firstName];
    }
    
    userAge = [appController.currentUser objectForKey:@"user_age"];
    if (userAge != nil){
        _lblAge.text = userAge;
    }
    else{
        _lblAge.text = @"29";
    }
    
    userHeight = [appController.currentUser objectForKey:@"user_height"];
    if (userHeight != nil){
        _lblHeight.text = userHeight;
    }
    else{
        _lblHeight.text = @"5' 5\"";
    }
    
    userGender = [appController.currentUser objectForKey:@"user_gender"];
    if (userGender != nil){
        if([userGender isEqualToString:@"1"]) _lblGender.text = @"male";
        else _lblGender.text = @"female";
    }
    else{
        _lblGender.text = @"male";
    }
    
    userLocation = [appController.currentUser objectForKey:@"user_location"];
    if (userLocation != nil){
        _lblLocation.text = userLocation;
    }
    else{
        _lblLocation.text = @"Los Angeles, CA";
    }
    
    userEthnicity = [appController.currentUser objectForKey:@"user_ethnicity"];
    if (userEthnicity != nil){
        _lblEthnicity.text = userEthnicity;
    }
    else{
        _lblEthnicity.text = @" ";
    }
    
    _viewEthnicity.layer.cornerRadius = 7.0f;
    _viewEthnicity.layer.borderWidth = 1.0f;
    _viewEthnicity.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _btnOK.layer.cornerRadius = 5.0f;
    _viewEthnicity.hidden = YES;
    
    age = NO;
    height = NO;
    gender = NO;
//    _tableAge.hidden = YES;
//    _tableHeight.hidden = YES;
//    _tableGender.hidden = YES;
//    _tableAge.layer.cornerRadius = 4.0f;
//    _tableHeight.layer.cornerRadius = 4.0f;
//    _tableGender.layer.cornerRadius = 4.0f;
}

- (IBAction)onBackClicked:(id)sender {
    [self resetTextFeild];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onNextClicked:(id)sender {
    [self resetTextFeild];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onCameraClicked:(id)sender {
    UIActionSheet *alertCamera = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take a picture",
                                  @"Select photos from camera roll", nil];
    alertCamera.tag = 1;
    [alertCamera showInView:[UIApplication sharedApplication].keyWindow];
}
- (IBAction)onClickedDone:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _viewPic.frame;
        CGRect rectBack = _viewBack.frame;
        CGRect rectTop = _viewTop.frame;
        _viewBack.frame = CGRectMake(0, rectTop.size.height, rectBack.size.width, rectBack.size.height);
        _viewPic.frame = CGRectMake(0, self.view.frame.size.height, rect.size.width, rect.size.height);
    }];
    
}

- (IBAction)onClickedAge:(id)sender {
//    _tableAge.hidden = NO;
//    _tableHeight.hidden = YES;
//    _tableGender.hidden = YES;
    
    age = YES;
    height = NO;
    gender = NO;
    [_pickerView reloadAllComponents];
    [self moveView];
}

- (void) moveView{
   [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _viewPic.frame;
        CGRect rectBack = _viewBack.frame;
        CGRect rectTop = _viewTop.frame;
        _viewBack.frame = CGRectMake(0, rectTop.size.height - rect.size.height, rectBack.size.width, rectBack.size.height);
        _viewPic.frame = CGRectMake(0, self.view.frame.size.height - rect.size.height, rect.size.width, rect.size.height);
   }];
}
- (IBAction)onClickedHeight:(id)sender {
//    _tableAge.hidden = YES;
//    _tableHeight.hidden = NO;
//    _tableGender.hidden = YES;

    age = NO;
    height = YES;
    gender = NO;
    [_pickerView reloadAllComponents];
    [self moveView];
}

- (IBAction)onClickedGender:(id)sender {
//    _tableAge.hidden = YES;
//    _tableHeight.hidden = YES;
//    _tableGender.hidden = NO;
    age = NO;
    height = NO;
    gender = YES;
    [_pickerView reloadAllComponents];
    [self moveView];
}

- (IBAction)onClickedEthnicity:(id)sender {
    _viewEthnicity.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = _viewPic.frame;
        CGRect rectBack = _viewBack.frame;
        CGRect rectTop = _viewTop.frame;
        _viewBack.frame = CGRectMake(0, rectTop.size.height, rectBack.size.width, rectBack.size.height);
        _viewPic.frame = CGRectMake(0, self.view.frame.size.height, rect.size.width, rect.size.height);
    }];
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
    userEthnicity = ethni;
    _lblEthnicity.text = userEthnicity;
}

#pragma UIPickerViewDelegate Method
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numRow = 0;
    if (age == YES) {
        numRow =  appController.ageList.count;
    }else if (height == YES){
        numRow = appController.heighList.count;
    }else if (gender == YES){
        numRow = appController.genderList.count;
    }
    return numRow;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *strPicker;
    if (age == YES) {
        strPicker = [appController.ageList objectAtIndex:row];
    }
    else if (height == YES){
        strPicker = [appController.heighList objectAtIndex:row];
    }else if (gender == YES){
        strPicker = [appController.genderList objectAtIndex:row];
    }
    return strPicker;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect rect = _viewPic.frame;
//
//        _viewPic.frame = CGRectMake(0, self.view.frame.size.height - rect.size.height, rect.size.width, rect.size.height);
//    }];

    if (age == YES) {
        _lblAge.text = [appController.ageList objectAtIndex:row];
    }else if (height == YES){
        _lblHeight.text = [appController.heighList objectAtIndex:row];
    }else{
        _lblGender.text = [appController.genderList objectAtIndex:row];
    }
}

#pragma UITableViewDelegate Method
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numRow;
//    if (tableView == _tableAge) {
//        numRow =  appController.ageList.count;
//    }else if (tableView == _tableHeight){
//        numRow = appController.heighList.count;
//    }else if (tableView == _tableGender){
//        numRow = appController.genderList.count;
//    }else{
        numRow = appController.ethnicityList.count;
//    }
    
    return numRow;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (tableView == _tableEthnicity) {
        
        EthnicityTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"EthnicityTableViewCell"];
        cell.ethnicityName.text = [appController.ethnicityList objectAtIndex:indexPath.row];
        if([[clickEthnicity objectAtIndex:indexPath.row] isEqualToString:@"0"]) cell.imgCheck.hidden = YES;
        else cell.imgCheck.hidden = NO;
        return cell;
//    }
//    else{
//        
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//        cell.textLabel.font = [UIFont systemFontOfSize:16];
//        cell.backgroundColor = [UIColor lightGrayColor];
//        if (tableView == _tableAge) {
//            cell.textLabel.text = [appController.ageList objectAtIndex:indexPath.row];
//        }
//        else if (tableView == _tableHeight){
//            cell.textLabel.text = [appController.heighList objectAtIndex:indexPath.row];
//        }else if (tableView == _tableGender){
//            cell.textLabel.text = [appController.genderList objectAtIndex:indexPath.row];
//        }
//        
//        return cell;
//    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tableEthnicity) {
        
        if([[clickEthnicity objectAtIndex:indexPath.row] isEqualToString:@"0"]){
            [clickEthnicity replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        else{
            [clickEthnicity replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }
        [tableView reloadData];
    }
//    else{
//        
//        tableView.hidden = YES;
//        if (tableView == _tableAge) {
//            _lblAge.text = [appController.ageList objectAtIndex:indexPath.row];
//        }else if (tableView == _tableHeight){
//            _lblHeight.text = [appController.heighList objectAtIndex:indexPath.row];
//        }else{
//            _lblGender.text = [appController.genderList objectAtIndex:indexPath.row];
//        }
//    }
}

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 20;
//}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    switch (buttonIndex) {
            
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%ld , %ld", (long)actionSheet.tag , (long)buttonIndex);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imageSEL = info[UIImagePickerControllerEditedImage];
    [_imgUser setImage:imageSEL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) resetTextFeild{
    [_txtName resignFirstResponder];
    [_txtDisplayName  resignFirstResponder];
    [_txtEmail resignFirstResponder];
}

@end
