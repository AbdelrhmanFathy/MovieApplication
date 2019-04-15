//
//  DataBaseClass.m
//  MovieApplication
//
//  Created by abdelrhman on 4/10/19.
//  Copyright © 2019 abdelrhman. All rights reserved.
//

#import "DataBaseClass.h"
@implementation DataBaseClass

- (void)insertIntoDB:(MovieData *)mData
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:mData];
    }];
    // NSLog(@"%@",@"Inserted");
}

-(NSMutableArray *)selectAllFavMovie
{
  
    NSMutableArray *arrOfMovies = [NSMutableArray new];
   
    RLMResults<MovieData *> *movies = [MovieData allObjects];
 
    for (MovieData *object in movies) {
        if([object favorite]==1)
        [arrOfMovies addObject:object];
    }
    return arrOfMovies;
}
- (void)dropDB
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}
- (void)updateFavInDB:(MovieData *)mData
{
   
   RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [mData setFavorite:0];
    [realm commitWriteTransaction];
    
}
-(MovieData *)selectMovie:(MovieData *)mData
{
    RLMResults<MovieData *> *movies = [MovieData allObjects];
    MovieData * m=nil;
   //long count=0;
    for (MovieData *object in movies) {
        if([object movieId]==[mData movieId])
        {
            m=object;
            break;
        }
    }
    return m;
}
@end
