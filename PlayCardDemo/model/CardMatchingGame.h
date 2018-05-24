//
//  CardMatchingGame.h
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/18.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingDeck.h"

@interface CardMatchingGame : NSObject

@property(nonatomic,assign,readwrite)NSInteger matchCardsCount;//匹配的牌的数目
@property(nonatomic,assign,readwrite)NSInteger notMatchCost;//未匹配的惩罚分
@property(nonatomic,assign,readwrite)NSInteger matchBonous;//匹配成功的奖励分
@property(nonatomic,assign,readwrite)NSInteger cost;//没看一张牌的消耗分

//整个游戏最终的分数
@property(nonatomic,assign,readonly)NSInteger score;

//designated constructor
-(instancetype)initWithCardCounts:(NSInteger)cardCounts UsingDeck:(Deck*)deck;

-(instancetype)initWithMatchCardCounts:(NSInteger)matchCardsCount  AllCardCounts:(NSInteger)allCardsCount UsingDeck:(Deck *)deck;

//游戏的主要玩法1:匹配两张牌
//从牌堆中一张牌去与牌堆中其它的牌进行对比。每次只能对比两张牌的花色和点数
//如果两张牌花色相同：得1分
//如果两张牌点数相同：得4分
//如果两张牌点数和花色都不同，那么扣除掉1分，将之前显示出来的牌，翻转回去。
//如果当前选择的牌与其它牌能够匹配，那么两张牌就从牌堆中删除，不能再进行点击
-(void)selectCardAtIndex:(NSInteger)index;

//游戏主要玩法2：匹配N张牌,其中N的设定可以由玩家自己限定
//从牌堆中一张牌去与牌堆中其它的牌进行对比。每次需要跟牌堆中的N张牌进行对比
//如果N张牌点数全部相同，那么得到的分数位2的N次方；如果N张牌中花色全部相同，那么得到N*（N-1）分
//如果N-1张牌点数相同，那么得到的分数为2的N-2次方；如果N-1张牌花色相同，那么得到(N-1)*(N-3)分
//依次类推，如果点数全部不同，那么不得分，且每局需要扣除N-1分；如果花色全不同，那么需要扣除N的平方分。
-(void)matchCardAtIndex:(NSInteger)index;

-(Card *)cardAtIndex:(NSInteger)index;


@end
