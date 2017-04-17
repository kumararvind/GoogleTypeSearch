//
//  Result.m
//  GoogleTypesSearch
//
//  Created by Infoicon on 14/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

#import "Result.h"

@implementation Result

-(instancetype)initWithResult:(NSDictionary*)result{

    self.name = result[@"name"];
    self.latitude = result[@"geometry"][@"location"][@"lat"];
    self.longitude = result[@"geometry"][@"location"][@"lng"];
    self.icon = result[@"icon"];
    self.result_id = result[@"id"];
    self.rating = result[@"rating"];
    self.reference = result[@"reference"];
    self.address = result[@"vicinity"];
    
    NSArray *types = result[@"types"];
    if (types.count>0){
        self.type1 = [result[@"types"] objectAtIndex:0];
    }
    if(types.count>3){
        self.type2 = [result[@"types"] objectAtIndex:3];
    }
  
    return self;
}



@end
