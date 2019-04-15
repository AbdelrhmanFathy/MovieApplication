//
//  MovieDetailsController.h
//  MovieApplication
//
//  Created by iOS Training on 4/3/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieData.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HCSStarRatingView.h"
#import "DataBaseClass.h"
@interface MovieDetailsController : UITableViewController
@property MovieData *mMovieData;
@property NSArray * mMovieReviews;
@property NSArray * mMovieTrailers;
-(void)makeBlurImage;
@end
