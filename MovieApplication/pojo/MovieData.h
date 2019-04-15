//
//  MovieData.h
//  MovieApplication
//
//  Created by iOS Training on 4/2/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface MovieData :RLMObject

    @property (nonatomic,assign)NSInteger movieId;
    @property NSString * releaseDate;
    @property double userRating;
    @property NSString * title;
    @property NSString * movieImage;
    @property NSString * overview;
    @property NSString * movieDuration;
    @property NSString * movieReviews;
    @property NSString * movieTrailers;
    @property int favorite;
@end
