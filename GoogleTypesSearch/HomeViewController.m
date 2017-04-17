//
//  HomeViewController.m
//  GoogleTypesSearch
//
//  Created by Infoicon on 17/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"

@interface HomeViewController ()<UITextFieldDelegate,SearchDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    // Do any additional setup after loading the view.
}


#pragma mark:- Search Delegate

-(void)getSearch:(NSString*)name address:(NSString *)address latitude:(NSString *)lat longitude:(NSString * )lng{

    NSLog(@"Latitude=%@,Longitude=%@",lat,lng);
    _txtSearch.text = [NSString stringWithFormat:@"%@, %@",name,address];
}


#pragma mark:- Textfield Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if (_txtSearch == textField){
    
        NSArray *types = @[@"atm",@"restaurant"];
        
        SearchViewController *objVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
        objVC.delegate=self;
        objVC.types = types;
        [self presentViewController:objVC animated:YES completion:nil];
    }
    
}

@end
