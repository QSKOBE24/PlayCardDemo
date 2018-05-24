//
//  Deck.m
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property(nonatomic,strong)NSMutableArray *cards;

@end


@implementation Deck


-(NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(void)addCard:(Card *)card{
    [self addCard:card atTop:NO];
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }
}

-(Card *)drawRamdonCard{
    Card *card = nil;
    if ([self.cards count]) {
        NSInteger index = arc4random() % [self.cards count];
        card = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return card;
}

@end
