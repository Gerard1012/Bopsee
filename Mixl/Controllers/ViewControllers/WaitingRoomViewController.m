//
//  WaitingRoomViewController.m
//  Bopsee
//
//  Created by Admin on 6/15/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "WaitingRoomViewController.h"

@interface WaitingRoomViewController (){
    NSMutableArray *dates;
    NSMutableDictionary *date;
    NSString* dateNumber;
    NSString *date1Image, *date2Image, *date3Image, *date4Image, *date5Image, *date6Image;
}

@end

@implementation WaitingRoomViewController

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
    dates = [[NSMutableArray alloc] init];
    dates = appController.matchedUsers;
    date1Image = [[dates objectAtIndex:0] objectForKey:@"image"];
    date2Image = [[dates objectAtIndex:1] objectForKey:@"image"];
    date3Image = [[dates objectAtIndex:2] objectForKey:@"image"];
    date4Image = [[dates objectAtIndex:3] objectForKey:@"image"];
    date5Image = [[dates objectAtIndex:4] objectForKey:@"image"];
    date6Image = [[dates objectAtIndex:5] objectForKey:@"image"];
    date = [[NSMutableDictionary alloc] init];
}

- (void) initView{
    
    [commonUtils setCircleViewImage:_viewDate1 imageview:_imgDate1 borderWidth:1.0f borderColor:[UIColor lightGrayColor]];
    if ([date1Image isEqual:[NSNull null]]){
        [_imgDate1 setImage:[UIImage imageNamed:@"person1"]];
    }else{
        //[commonUtils setImageViewAFNetworking:_imgDate1 withImageUrl:date1Image withPlaceholderImage:[UIImage imageNamed:@"person1"]];
        [_imgDate1 setImage:[UIImage imageNamed:date1Image]];
    }
    
    [commonUtils setCircleViewImage:_viewDate2 imageview:_imgDate2 borderWidth:1.0f borderColor:[UIColor lightGrayColor]];
    if ([date2Image isEqual:[NSNull null]]){
        [_imgDate2 setImage:[UIImage imageNamed:@"person2"]];
    }else{
        //[commonUtils setImageViewAFNetworking:_imgDate2 withImageUrl:date2Image withPlaceholderImage:[UIImage imageNamed:@"person2"]];
        [_imgDate2 setImage:[UIImage imageNamed:date2Image]];
    }
    
    [commonUtils setCircleViewImage:_viewDate3 imageview:_imgDate3 borderWidth:1.0f borderColor:[UIColor lightGrayColor]];
    if ([date3Image isEqual:[NSNull null]]){
        [_imgDate3 setImage:[UIImage imageNamed:@"person3"]];
    }else{
        //[commonUtils setImageViewAFNetworking:_imgDate3 withImageUrl:date3Image withPlaceholderImage:[UIImage imageNamed:@"person3"]];
        [_imgDate3 setImage:[UIImage imageNamed:date3Image]];
    }
    
    [commonUtils setCircleViewImage:_viewDate4 imageview:_imgDate4 borderWidth:1.0f borderColor:[UIColor lightGrayColor]];
    if ([date4Image isEqual:[NSNull null]]){
        [_imgDate4 setImage:[UIImage imageNamed:@"person4"]];
    }else{
        //[commonUtils setImageViewAFNetworking:_imgDate4 withImageUrl:date4Image withPlaceholderImage:[UIImage imageNamed:@"person4"]];
        [_imgDate4 setImage:[UIImage imageNamed:date4Image]];
    }
    
    [commonUtils setCircleViewImage:_viewDate5 imageview:_imgDate5 borderWidth:1.0f borderColor:[UIColor lightGrayColor]];
    if ([date5Image isEqual:[NSNull null]]){
        [_imgDate5 setImage:[UIImage imageNamed:@"person5"]];
    }else{
        //[commonUtils setImageViewAFNetworking:_imgDate5 withImageUrl:date5Image withPlaceholderImage:[UIImage imageNamed:@"person5"]];
        [_imgDate5 setImage:[UIImage imageNamed:date5Image]];
    }
    
    [commonUtils setCircleViewImage:_viewDate6 imageview:_imgDate6 borderWidth:1.0f borderColor:[UIColor lightGrayColor]];
    if ([date6Image isEqual:[NSNull null]]){
        [_imgDate6 setImage:[UIImage imageNamed:@"person6"]];
    }else{
        //[commonUtils setImageViewAFNetworking:_imgDate6 withImageUrl:date6Image withPlaceholderImage:[UIImage imageNamed:@"person6"]];
        [_imgDate6 setImage:[UIImage imageNamed:date6Image]];
    }
    
    
}

- (IBAction)onBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onDate1Clicked:(id)sender {
    dateNumber = @"1";
    date = [dates objectAtIndex:0];
    [self showNext];
}

- (IBAction)onDate2Clicked:(id)sender {
    dateNumber = @"2";
    date = [dates objectAtIndex:1];
    [self showNext];
}

- (IBAction)onDate3Clicked:(id)sender {
    dateNumber = @"3";
    date = [dates objectAtIndex:2];
    [self showNext];
}

- (IBAction)onDate4Clicked:(id)sender {
    dateNumber = @"4";
    date = [dates objectAtIndex:3];
    [self showNext];
}

- (IBAction)onDate5Clicked:(id)sender {
    dateNumber = @"5";
    date = [dates objectAtIndex:4];
    [self showNext];
}

- (IBAction)onDate6Clicked:(id)sender {
    dateNumber = @"6";
    date = [dates objectAtIndex:5];
    [self showNext];
}

- (void) showNext{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AbuseViewController* abuseController =
    (AbuseViewController*) [storyboard instantiateViewControllerWithIdentifier:@"AbuseVC"];
    abuseController.dateInfo = date;
    abuseController.dateNumber = dateNumber;
    [self.navigationController pushViewController:abuseController animated:YES];
}

@end
