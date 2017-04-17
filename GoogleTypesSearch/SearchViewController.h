//
//  ViewController.h
//  GoogleTypesSearch
//
//  Created by Infoicon on 14/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchDelegate <NSObject>
@required
-(void)getSearch:(NSString*)name address:(NSString*)address latitude:(NSString*)lat longitude:(NSString*)lng;

@end


@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

// Types can be atm/restorent array
@property (strong, nonatomic) NSArray *types;

@property(weak,nonatomic) id<SearchDelegate> delegate;

@end

