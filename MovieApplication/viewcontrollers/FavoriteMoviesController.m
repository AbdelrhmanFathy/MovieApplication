//
//  FavoriteMoviesController.m
//  MovieApplication
//
//  Created by abdelrhman on 4/12/19.
//  Copyright © 2019 abdelrhman. All rights reserved.
//

#import "FavoriteMoviesController.h"

@interface FavoriteMoviesController ()

@end

@implementation FavoriteMoviesController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image=[UIImageView new];
    [image setImage:[UIImage imageNamed:@"background.jpg"]];
    [image setAlpha:0.7];
    self.collectionView.backgroundView=image;
    DataBaseClass *db=[DataBaseClass new];
    _mMovies=[db selectAllFavMovie];
    [self.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    DataBaseClass *db=[DataBaseClass new];
    _mMovies=[db selectAllFavMovie];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mMovies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favCell" forIndexPath:indexPath];
     UIImageView *movieImg=[cell viewWithTag:1];
    if( [[_mMovies objectAtIndex:indexPath.row] movieImage]!=nil)
    {
        [movieImg sd_setImageWithURL:[NSURL URLWithString:[@"https://image.tmdb.org/t/p/w185/" stringByAppendingString: [[_mMovies objectAtIndex:indexPath.row] movieImage]]]];
    }
    else
    {
        [movieImg setImage:[UIImage imageNamed:@"no-image-icon-15.png"]];
    }
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsController *mDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetalisVC"];
    mDetails.mMovieData=_mMovies[indexPath.row];
    [self.navigationController pushViewController:mDetails animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize c=CGSizeMake(collectionView.frame.size.width/2,collectionView.frame.size.width/2);
    return c;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
@end
