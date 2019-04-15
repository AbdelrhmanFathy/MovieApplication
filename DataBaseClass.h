//
//  DataBaseClass.h
//  MovieApplication
//
//  Created by abdelrhman on 4/10/19.
//  Copyright © 2019 abdelrhman. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>
#import "MovieData.h"
@interface DataBaseClass : RLMObject

-(void)insertIntoDB:(MovieData *)mData;
-(NSMutableArray *)selectAllFavMovie;
-(MovieData *)selectMovie:(MovieData *)mData;
-(void)dropDB;
-(void)updateFavInDB:(MovieData *)mData;
@end

