//
//  PlayingCard.m
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suite = _suite;

+(NSArray *)validSuits{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}


+(NSArray *)validRank{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSInteger)maxRank{
    return  [[self validRank] count] -1;
}

-(NSString *)content{
    
    return [[PlayingCard validRank][self.rank] stringByAppendingString:self.suite];
}

-(NSString *)suite{
    return  _suite ? _suite : @"?";
}

-(void)setSuite:(NSString *)suite{
    if ([[PlayingCard validSuits] containsObject:suite]) {
        _suite = suite;
    }
}

-(int)match:(NSArray *)array{
    int match = 0;
    if (array.count == 1) {
        PlayingCard *otherCard = [array firstObject];
        if ([self.suite isEqualToString:otherCard.suite]) {
            match =  1;
        }else if(self.rank == otherCard.rank){
            match =  4;
        }
    }
    return match;
}

-(int)matchCardCount:(NSInteger)matchCardCount inChoosenArray:(NSArray *)choosenArray{
    int match = 1;
    int rankMatchCount = 0;
    int suitMatchCount = 0;
    if (choosenArray.count < matchCardCount - 1) { //不是最后一张牌
        for (PlayingCard *card in choosenArray) { //依次比较每张牌的花色和点数
            if (self.rank == card.rank) {
                card.matched= YES;
            }else if([self.suite isEqualToString:card.suite]){
                card.matched= YES;
            }
        }
        match = 0;
    }else if(choosenArray.count == matchCardCount - 1){ //最后一张牌
        for (PlayingCard *card in choosenArray) { //依次比较每张牌的花色和点数
            if (self.rank == card.rank) {
                self.matched = YES;
                card.matched = YES;
                rankMatchCount++;
            }else if([self.suite isEqualToString:card.suite]){
                self.matched = YES;
                card.matched = YES;
                suitMatchCount++;
            }else{
                self.matched = NO;
                card.matched = NO;
            }
        }
        
        if (rankMatchCount == choosenArray.count) { //点数全部相同
            for (int i = 0 ; i < choosenArray.count; i++) {
                match *= 2;
            }
            match *= 2;
        }else if(suitMatchCount == choosenArray.count){ //花色完全相同
            match = (int)choosenArray.count * (int)(choosenArray.count + 1);
        }else if(rankMatchCount != 0  || suitMatchCount != 0){//有点数相同也有花色相同
            match = rankMatchCount * 2 + suitMatchCount * 1;
        }else{ //点数和花色都不同
            match = 0;
        }
    }

    return match;
}


@end
