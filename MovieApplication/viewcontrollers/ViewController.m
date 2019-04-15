//
//  ViewController.m
//  MovieApplication
//
//  Created by iOS Training on 3/31/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    NSMutableArray *arrOfMovies;
    PrepareMovieData *p;
    MovieData *mData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image=[UIImageView new];
    [image setImage:[UIImage imageNamed:@"background.jpg"]];
    [image setAlpha:0.7];
    self.collectionView.backgroundView=image;
    p=[PrepareMovieData new];
    arrOfMovies=[p getMovieDataByPopularity];
    
    
}-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize c=CGSizeMake(collectionView.frame.size.width/2,collectionView.frame.size.width/2);
    return c;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return arrOfMovies.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *img=[cell viewWithTag:1];
      if([arrOfMovies[indexPath.row] movieImage]!=[NSNull null])
    {
        [img sd_setImageWithURL:[NSURL URLWithString:[@"https://image.tmdb.org/t/p/w185/" stringByAppendingString: [arrOfMovies[indexPath.row] movieImage]]]
         placeholderImage:[UIImage imageNamed:[arrOfMovies[indexPath.row] movieImage] ]options:SDWebImageRefreshCached
         ];
        //[img sizeToFit ];
    }
    else
    {
        [img setImage:[UIImage imageNamed:@"no-image-icon-15.png"]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsController *mDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetalisVC"];
    DataBaseClass *db=[DataBaseClass new];
    mDetails.mMovieData=arrOfMovies[indexPath.row];
    if([db selectMovie:arrOfMovies[indexPath.row]]==nil)
    {
    mDetails.mMovieData=[p getMovieReviews:(mDetails.mMovieData)];
    mDetails.mMovieData=[p getMovieTrailers:(mDetails.mMovieData)];
    }
    else
    {
        mDetails.mMovieData=[db selectMovie:arrOfMovies[indexPath.row]];
    }
    [self.navigationController pushViewController:mDetails animated:YES];
}
- (IBAction)btnChangeSort:(id)sender {
    UIAlertController *alert=[UIAlertController  alertControllerWithTitle:@"Sort By" message:@"choose the way you want to sort the movies By" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *popular=[UIAlertAction actionWithTitle:@"Popularity Sort" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                            {
                               self->arrOfMovies=[self->p getMovieDataByPopularity];
                                
                                [self.collectionView reloadData];
                            }];
    UIAlertAction *highest=[UIAlertAction actionWithTitle:@"Highest Rate Sort" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                            {
                                self->arrOfMovies=[self->p getMovieDataByHighestRating];
                              
                                [self.collectionView reloadData];
                            }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                            {
                        
                            }];
    [alert addAction:popular];
    [alert addAction:highest];
      [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end

