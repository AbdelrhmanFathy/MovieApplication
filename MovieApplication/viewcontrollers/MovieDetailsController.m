//
//  MovieDetailsController.m
//  MovieApplication
//
//  Created by iOS Training on 4/3/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import "MovieDetailsController.h"

@implementation MovieDetailsController
UIImageView *image;
UIImageView *fav;
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self makeBlurImage]; //make the movie image of tableview background blur
    
    _mMovieReviews=[[_mMovieData movieReviews] componentsSeparatedByString:@"#*#"];
    _mMovieTrailers=[[_mMovieData movieTrailers] componentsSeparatedByString:@"#*#"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long numberOfRows=0;
    if(_mMovieReviews.count==1)
        numberOfRows= 4+_mMovieReviews.count;
    else
        numberOfRows= 4+_mMovieReviews.count-1;
   
    if(_mMovieTrailers.count==1)
        numberOfRows= 1+numberOfRows+_mMovieTrailers.count;
    else
        numberOfRows= numberOfRows+_mMovieTrailers.count;
    
    
    return numberOfRows;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if (indexPath.row==0)
        {  cell=[tableView dequeueReusableCellWithIdentifier:@"tableCell"];
            UILabel *movieName=[cell viewWithTag:1];
            movieName.text=[_mMovieData title];
            
        }
        else  if (indexPath.row==1)
        {
            cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
            UILabel *movieReleaseDate=[cell viewWithTag:3];
            UIImageView *movieImg=[cell viewWithTag:2];
            HCSStarRatingView *starRatingView = [cell viewWithTag:6];
         
            fav=[cell viewWithTag:9];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addToFav)];
            singleTap.numberOfTapsRequired = 1;
            [fav setUserInteractionEnabled:YES];
            [fav addGestureRecognizer:singleTap];
            if([_mMovieData favorite]==1)
            {
                [fav setImage:[UIImage imageNamed:@"favorite.png"]];
            }
            starRatingView.maximumValue=10;
            starRatingView.minimumValue=0;
            starRatingView.backgroundColor=[UIColor clearColor];
            starRatingView.value = [_mMovieData userRating];
            [movieImg setImage:image.image];
            movieReleaseDate.text=[_mMovieData releaseDate];
        }
        else  if (indexPath.row==2)
        {
            cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
            UITextView *movieOverView=[cell viewWithTag:7];
              movieOverView.text=[_mMovieData overview];
            movieOverView.translatesAutoresizingMaskIntoConstraints=true;
            //[movieOverView sizeToFit];
            movieOverView.scrollEnabled=true;
            
          
        }
        else  if (indexPath.row==3)
        {
            cell=[tableView dequeueReusableCellWithIdentifier:@"cell4"];
        }
        else  if (indexPath.row==4||indexPath.row<(4+_mMovieReviews.count-1))
        {
            
            cell=[tableView dequeueReusableCellWithIdentifier:@"cell5"];
            UITextView *movieReview=[cell viewWithTag:8];
           
            if(_mMovieReviews.count==1)
            {
                [movieReview insertText:@"No Reviews"];
            }
            else	
            {
                movieReview.text=[_mMovieReviews objectAtIndex:indexPath.row-4];
            }
        }
    else if(indexPath.row==(4+_mMovieReviews.count))
    {
         cell=[tableView dequeueReusableCellWithIdentifier:@"cell6"];
    }
    else  if (indexPath.row>=(4+_mMovieReviews.count)||indexPath.row<(4+_mMovieReviews.count+_mMovieTrailers.count-1))
    {
        
        cell=[tableView dequeueReusableCellWithIdentifier:@"cell7"];
        UILabel *movieTrailer=[cell viewWithTag:10];
        
        NSLog(@"%@",[_mMovieTrailers objectAtIndex:0]);
        if(_mMovieTrailers.count==1)
        {
            movieTrailer.text=@"No Trailers";
        }
        else
        {
            NSNumber *trailerNumber=[NSNumber numberWithLong:(indexPath.row-(4+1+_mMovieReviews.count-1))];
            
            movieTrailer.text=[@"Trailer " stringByAppendingString:[trailerNumber stringValue]];
        }
    }
    
    
            
    
    cell.backgroundColor=[UIColor clearColor];
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 if(indexPath.row==0)
 {
     return 60;
 }
    else if(indexPath.row==1)
    {
        return 200;
    }
    else if(indexPath.row==2)
    {
        return 200;
    }
    else if(indexPath.row==3)
    {
        return 30;
    }
    else
    {
        return 120;
    }
}



-(void)addToFav{
    
    DataBaseClass *db=[DataBaseClass new];
    if([_mMovieData favorite]==0)
    {
        [_mMovieData setFavorite:1];
        [fav setImage:[UIImage imageNamed:@"favorite.png"]];
        [db insertIntoDB:_mMovieData];
    }
    else
    {
        [fav setImage:[UIImage imageNamed:@"unfavorite.png"]];
        [db updateFavInDB:_mMovieData];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
-(void)makeBlurImage
{
    image=[UIImageView new];
    if([_mMovieData movieImage]!=nil)
    {
    [image sd_setImageWithURL:[NSURL URLWithString:[@"https://image.tmdb.org/t/p/w185/" stringByAppendingString: [_mMovieData movieImage]]]];;
    }
    else
    {
         [image setImage:[UIImage imageNamed:@"no-image-icon-15.png"]];
    }
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.alpha=0.9;
    //always fill the view
    blurEffectView.frame = image.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [image addSubview:blurEffectView];
    self.tableView.backgroundView=image;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    @try{
    if (indexPath.row>=(4+_mMovieReviews.count)||indexPath.row<(4+_mMovieReviews.count+_mMovieTrailers.count))
    {
    if(_mMovieTrailers.count>1)
    {
   
        long w=indexPath.row - 4-1 - _mMovieReviews.count;
    
        NSString *mID=[_mMovieTrailers objectAtIndex:w];
        NSString *mUrl=[ @"https://www.youtube.com/watch?v=" stringByAppendingFormat:@"%@",mID];
        NSString* webStringURL = [mUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       // NSLog(@"%@",mUrl);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webStringURL] options:@{} completionHandler:nil];
       
    }
    }}
    @catch(NSException *b){
        
    }
}
@end
