//
//  PrepareImages.m
//  MovieApplication
//
//  Created by iOS Training on 4/1/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import "PrepareMovieData.h"

@implementation PrepareMovieData
MovieData *mData;
-(void)viewDidLoad{
    [super viewDidLoad];
   }
-(NSMutableArray *)getMovieDataByPopularity
{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("com.app", DISPATCH_QUEUE_CONCURRENT);
    
    NSMutableArray * arrOfMovies=[NSMutableArray new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = queue;
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
    [manager GET:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=58f45d950f0a69723bdc8c5fd2457f07" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSMutableArray* arr=[responseObject objectForKey:@"results"] ;
        for(int i=0;i<arr.count;i++)
        {
            mData=[MovieData new];
            
            [mData setMovieId:[arr[i][@"id"] integerValue]];
            [mData setMovieImage:arr[i][@"poster_path"]];
            [mData setTitle:arr[i][@"title"]];
            [mData setOverview:arr[i][@"overview"]];
            [mData setUserRating:[arr[i][@"vote_average"] doubleValue] ];
            [mData setReleaseDate:arr[i][@"release_date"]];
           // [mData setMovieDuration:arr[i][@""]];
            [arrOfMovies addObject:mData];
        }
        dispatch_group_leave(group);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_group_leave(group);
    }];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return arrOfMovies;
}

-(MovieData*)getMovieReviews:(MovieData*)mData
{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("com.app2", DISPATCH_QUEUE_CONCURRENT);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = queue;
    dispatch_group_enter(group);
    
 
    dispatch_async(queue, ^{
        [manager GET:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld%s",[mData movieId],"/reviews?&api_key=58f45d950f0a69723bdc8c5fd2457f07&language=en-US&page=1"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableArray* arr=[responseObject objectForKey:@"results"] ;
            mData.movieReviews=@"";
            for(int i=0;i<arr.count;i++)
            {
                
                mData.movieReviews= [mData.movieReviews stringByAppendingString:arr[i][@"author"]];
                mData.movieReviews=  [mData.movieReviews stringByAppendingString:@"\n"];
                mData.movieReviews= [mData.movieReviews stringByAppendingString:arr[i][@"content"]];
                 mData.movieReviews=  [mData.movieReviews stringByAppendingString:@"\n"];
                mData.movieReviews=  [mData.movieReviews stringByAppendingString:@"#*#"];
            }
            dispatch_group_leave(group);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return mData;
}
-(MovieData*)getMovieTrailers:(MovieData*)mData
{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("com.app4", DISPATCH_QUEUE_CONCURRENT);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = queue;
    dispatch_group_enter(group);
    
    
    dispatch_async(queue, ^{
        [manager GET:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld%s",[mData movieId],"/videos?&api_key=58f45d950f0a69723bdc8c5fd2457f07&language=en-US&page=1"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableArray* arr=[responseObject objectForKey:@"results"] ;
            mData.movieTrailers=@"";
            for(int i=0;i<arr.count;i++)
            {
                
                mData.movieTrailers= [mData.movieTrailers stringByAppendingString:arr[i][@"key"]];
                mData.movieTrailers=  [mData.movieTrailers stringByAppendingString:@"\n"];
                mData.movieTrailers=  [mData.movieTrailers stringByAppendingString:@"#*#"];
            }
            dispatch_group_leave(group);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return mData;
}
-(NSMutableArray *)getMovieDataByHighestRating
{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("com.app3", DISPATCH_QUEUE_CONCURRENT);
    
    NSMutableArray * arrOfMovies=[NSMutableArray new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = queue;
    dispatch_group_enter(group);
    
    dispatch_async(queue, ^{
        [manager GET:@"https://api.themoviedb.org/3/discover/movie?sort_by=top_rated.%30desc&api_key=58f45d950f0a69723bdc8c5fd2457f07" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSMutableArray* arr=[responseObject objectForKey:@"results"] ;
            for(int i=0;i<arr.count;i++)
            {
                mData=[MovieData new];
                
                [mData setMovieId:[arr[i][@"id"] integerValue]];
                [mData setMovieImage:arr[i][@"poster_path"]];
                [mData setTitle:arr[i][@"title"]];
                [mData setOverview:arr[i][@"overview"]];
                [mData setUserRating:[arr[i][@"vote_average"] doubleValue] ];
                [mData setReleaseDate:arr[i][@"release_date"]];
                [mData setMovieDuration:@"1000"];
                [mData setFavorite:0];
                [arrOfMovies addObject:mData];
            }
            dispatch_group_leave(group);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return arrOfMovies;
}
@end
