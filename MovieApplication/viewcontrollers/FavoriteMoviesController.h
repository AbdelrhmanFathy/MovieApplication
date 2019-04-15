//
//  FavoriteMoviesController.h
//  MovieApplication
//
//  Created by abdelrhman on 4/12/19.
//  Copyright © 2019 abdelrhman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseClass.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieDetailsController.h"
@interface FavoriteMoviesController : UICollectionViewController<UICollectionViewDelegateFlowLayout>
@property NSMutableArray * mMovies;
@end
