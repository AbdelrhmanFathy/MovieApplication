//
//  PrepareImages.h
//  MovieApplication
//
//  Created by iOS Training on 4/1/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MovieData.h"
@interface PrepareMovieData : UIViewController

-(NSMutableArray *)getMovieDataByPopularity;
-(NSMutableArray *)getMovieDataByHighestRating;
-(MovieData*)getMovieReviews:(MovieData*)mData;
-(MovieData*)getMovieTrailers:(MovieData*)mData;
@end
