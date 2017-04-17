//
//  SearchViewController.m
//  GoogleTypesSearch
//
//  Created by Infoicon on 14/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

#import "SearchViewController.h"
#import "Result.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrayResults;

}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsHeightTableView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_textFieldSearch];
    
    [self hideSearchTableView];
    [self configTableView];
    
    
}

-(void)configTableView{

   
    _tableView.layer.cornerRadius=5.0;
    _tableView.layer.borderWidth=2.0;
    _tableView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    _tableView.layer.masksToBounds=YES;
}


- (void)textFieldDidChange:(NSNotification *)notification {
    // Do whatever you like to respond to text changes here.
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(getGooglePlaces) withObject:self afterDelay:0.3];
    
  
}

-(void)getGooglePlaces{

    if (_textFieldSearch.text.length==0) {
        [self hideSearchTableView];
        return;
    }
    
    
    [_activityIndicator startAnimating];
    NSString *strSearch  = _textFieldSearch.text;
    
   
    NSString *typesString = [_types componentsJoinedByString:@"|"];
    
    NSString *str= [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyAjqCBfjCjxpw6VtRkIvM7URE3tKTr-pK8&name=%@&types=%@&radius=10000&sensor=true&location=28.5952,77.3281",strSearch,typesString];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [str stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSLog(@"RESPONSE: %@",response);
                NSLog(@"DATA: %@",data);
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                            NSLog(@"%@",jsonResponse);
                            
                            NSArray *results=[jsonResponse objectForKey:@"results"];
                            
                            if(results.count>0){
                                
                                NSMutableArray *arrfinal=[NSMutableArray array];
                                for (NSDictionary* result in results) {
                                    
                                    Result *res=[[Result alloc]initWithResult:result];
                                    [arrfinal addObject:res];
                                    
                                }
              
                                arrayResults=arrfinal;
                                
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    [self.activityIndicator stopAnimating];
                                    [self.tableView reloadData];
                                    [self showSearchTableView];
                                });
                                
                                
                            } else{
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    [self.activityIndicator stopAnimating];
                                    [self.tableView reloadData];
                                    [self hideSearchTableView];
                                });
                            }
                            
                        }
                    }}else {
                        // Fail
                        NSLog(@"error : %@", error.description);
                    }
            }] resume];

}

-(void)showSearchTableView{

    
    [UIView animateWithDuration:0.4 animations:^{
        
        _constraintsHeightTableView.constant=250;
        [self.view layoutIfNeeded];
    }];
    
}

-(void)hideSearchTableView{
  
    [UIView animateWithDuration:0.4 animations:^{
        
        _constraintsHeightTableView.constant=0;
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayResults.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath
                             ];
    Result *result=[arrayResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text=result.name;
    cell.detailTextLabel.text=result.address;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     Result *result=[arrayResults objectAtIndex:indexPath.row];
    
    [self dismissViewControllerAnimated:YES completion:^{

        [self.delegate getSearch:result.name address:result.address latitude:result.latitude longitude:result.longitude];
    }];
    
}


@end
