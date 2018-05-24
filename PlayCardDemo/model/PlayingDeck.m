//
//  PlayingDeck.m
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import "PlayingDeck.h"
#import "PlayingCard.h"

@implementation PlayingDeck

-(instancetype)init{
    self = [super init];
    if (self) {
        for (NSString *suite in [PlayingCard validSuits]) {
            for (NSInteger rank = 1 ; rank <= [PlayingCard maxRank]  ; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suite = suite;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }

    return self;
}

@end
