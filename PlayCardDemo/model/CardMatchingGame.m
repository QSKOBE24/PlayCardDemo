//
//  CardMatchingGame.m
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/18.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property(nonatomic,assign,readwrite)NSInteger score;
@property(nonatomic,strong)NSMutableArray *cards;
@property(nonatomic,strong)NSMutableArray *choosenCards;//已经选择的卡牌数量
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(NSMutableArray *)choosenCards{
    if (!_choosenCards) {
        _choosenCards = [[NSMutableArray alloc] init];
    }
    return _choosenCards;
}

-(void)setCost:(NSInteger)cost{
    if (cost > 0) {
          _cost = cost;
    }
}

-(void)setMatchBonous:(NSInteger)matchBonous{
    if (matchBonous > 0) {
        _matchBonous = matchBonous;
    }
}

-(void)setNotMatchCost:(NSInteger)notMatchCost{
    if (notMatchCost > 0) {
        _notMatchCost = notMatchCost;
    }
}

-(instancetype)initWithCardCounts:(NSInteger)cardCounts UsingDeck:(Deck *)deck{
    self = [super init];
    if (self) {
        for (int i = 0 ; i < cardCounts; i++) {
            Card *card = [deck drawRamdonCard];
            if (card) {
                 [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


-(instancetype)initWithMatchCardCounts:(NSInteger)matchCardsCount AllCardCounts:(NSInteger)allCardsCount UsingDeck:(Deck *)deck{
    self = [super init];
    if (self) {
        _matchCardsCount = matchCardsCount;
        for (int i = 0 ; i < allCardsCount; i++) {
            Card *card = [deck drawRamdonCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


-(Card *)cardAtIndex:(NSInteger)index{
    return index < self.cards.count ? self.cards[index]: nil;
}

static const int MATCH_AWARD = 4;
static const int NOT_MATCH_PENALITY = 2;
static const int SELECT_COST = 1;
//玩法一
-(void)selectCardAtIndex:(NSInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {//当前牌未匹配
        if (card.isChoosen) {//当前牌被选中
            card.choosen = NO;
        }else{ //当前牌未被选中
            for (Card *otherCard in self.cards) { //遍历其它尚未匹配的牌
                if (otherCard.isChoosen && !otherCard.isMatched ) { //如果有其它尚未匹配且选中的牌
                    int matchScore = [card match:@[otherCard]];//获取匹配分数
                    if (matchScore) { //匹配成功
                        card.matched = YES;
                        otherCard.matched = YES;
                        self.score += matchScore * MATCH_AWARD;//匹配分数相加
                    }else{ //如果没有匹配，那么之前尚未匹配的牌就要置为未选中，牌面翻转
                        otherCard.choosen = NO;
                        self.score -= NOT_MATCH_PENALITY ; //匹配失败，需要扣掉惩罚分
                    }
                    break;
                }
                
            }
            
            self.score -= SELECT_COST;//每次选择完牌后，需要减去看牌的消耗分，防止玩家一直尝试看牌来记住所有的牌
            card.choosen = YES;
        }
    }
}

//玩法二
-(void)matchCardAtIndex:(NSInteger)index{
    //选择的那张牌
    Card *card = [self cardAtIndex:index];
    
    if(self.choosenCards.count < _matchCardsCount - 1){ //当前牌不是最后一张牌
        
        //int matchScore = [card matchCardCount:_matchCardsCount inChoosenArray:self.choosenCards];//计算出此时匹配分数
        
        [self.choosenCards addObject:card];//将本张牌添加到已经选出的牌数组中去
        
        for (Card *card in self.choosenCards) {
            card.choosen = YES;
        }
        //self.score += matchScore;
        self.score -= self.cost;//减去翻牌的消耗分数
        
    }else { //当前牌是最后一张牌
        
        int matchScore  = [card matchCardCount:_matchCardsCount inChoosenArray:self.choosenCards];//计算当前的匹配分数
        [self.choosenCards addObject:card];
        
        for (Card *card in self.choosenCards) {
            card.choosen = YES;
        }
        self.score += matchScore;
        self.score -= self.cost;//减去翻牌的消耗分数
        
    }    
}



@end
