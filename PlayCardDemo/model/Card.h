//
//  Card.h
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic,strong)NSString *content;//牌面

@property(nonatomic,getter=isChoosen)BOOL choosen;//当前牌是否被选中

@property(nonatomic,getter=isMatched)BOOL matched;//当前牌是否匹配其它的牌

//-(int)isMatched:(Card *)card;
-(int)match:(NSArray *)array;
-(int)matchCardCount:(NSInteger)matchCardCount inChoosenArray:(NSArray *)chooseArray;
@end
