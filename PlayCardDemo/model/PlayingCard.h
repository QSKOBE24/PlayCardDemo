//
//  PlayingCard.h
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface PlayingCard : Card
@property(nonatomic,strong)NSString *suite;
@property(nonatomic)NSUInteger rank;

+(NSArray*)validSuits;
+(NSArray*)validRank;
+(NSInteger)maxRank;
//-(int)matchCardCount:(NSInteger)matchCardCount inChoosenArray:(NSArray *)chooseArray;
@end
