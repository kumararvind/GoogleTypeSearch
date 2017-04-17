//
//  Result.h
//  GoogleTypesSearch
//
//  Created by Infoicon on 14/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *latitude;
@property (nonatomic,strong)NSString *longitude;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *result_id;
@property (nonatomic,strong)NSString *rating;
@property (nonatomic,strong)NSString *reference;
@property (nonatomic,strong)NSString *type1;
@property (nonatomic,strong)NSString *type2;
@property (nonatomic,strong)NSString *address;

-(instancetype)initWithResult:(NSDictionary*)result;

@end
