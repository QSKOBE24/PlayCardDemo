//
//  Card.m
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import "Card.h"

@interface Card ()

@end



@implementation Card


-(int)match:(NSArray *)array{
    
    for (Card *card in array) {
        if ([card.content isEqualToString:self.content]) {
            return 1;
        }
    }
    return 0;
}

@end
