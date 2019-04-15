//
//  ViewController.h
//  MovieApplication
//
//  Created by iOS Training on 3/31/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PrepareMovieData.h"
#import "MovieData.h"
#import "MovieDetailsController.h"
#import "DataBaseClass.h"
@interface ViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout>
@property NSMutableArray *loadedImages;
@end

