//
//  ViewController.m
//  PlayCardDemo
//
//  Created by qskobe24 on 2017/3/17.
//  Copyright © 2017年 qskobe24. All rights reserved.
//

#import "ViewController.h"
#import "PlayingDeck.h"
#import "CardMatchingGame.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabels;
@property(nonatomic,assign)NSInteger flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsArrays;

@property(nonatomic,strong)CardMatchingGame *game;

@property(nonatomic,strong)Deck *deck;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//-(CardMatchingGame *)game{
//    if (!_game) {
//        _game  = [[CardMatchingGame alloc] initWithCardCounts:self.cardsArrays.count UsingDeck:[self createDeck]];
//        _game.cost = 1;
//        _game.notMatchCost  = 2;
//        _game.matchBonous = 4;
//    }
//    return  _game;
//}

-(CardMatchingGame *)game{
    if (!_game) {
        _game  = [[CardMatchingGame alloc] initWithMatchCardCounts:4 AllCardCounts:self.cardsArrays.count UsingDeck:[self createDeck]];
        _game.cost = 1;
        _game.notMatchCost  = 2;
        _game.matchBonous = 4;
    }
    return  _game;
}

-(Deck *)deck{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return  _deck;
}


-(Deck *)createDeck{
    return [[PlayingDeck alloc] init];
}

-(void)setFlipCount:(NSInteger)flipCount{
    _flipCount = flipCount;
    self.flipLabels.text = [NSString stringWithFormat:@"Flips:%ld",(long)self.flipCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButtonClicked:(UIButton *)sender {
    //获取被点击的纸牌在数组中的位置
    NSInteger index = [self.cardsArrays indexOfObject:sender];
    //[self.game selectCardAtIndex:index];
    //[self updateUI];
    [self.game matchCardAtIndex:index];
    [self updateCardsInUI];

}

//根据牌面是否选中和是否匹配来更新UI
-(void)updateCardsInUI{
    for (UIButton *button  in  self.cardsArrays) {
        NSInteger index = [self.cardsArrays indexOfObject:button];
        Card *card = [self.game cardAtIndex:index];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[self titleForCardInUI:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundForCardInUI:card] forState:UIControlStateNormal];
        button.enabled = !card.choosen;
    }
    self.flipLabels.text = [NSString stringWithFormat:@"Score = %ld",(long)self.game.score];
}

-(NSString *)titleForCardInUI:(Card *)card{
    return card.choosen ? card.content : @"";
}


-(UIImage *)backgroundForCardInUI:(Card *)card{
    return [UIImage imageNamed:card.choosen?@"frotImage" :@"backImage"];
}


//根据牌面是否选中和是否匹配来更新UI
-(void)updateUI{
    for (UIButton *button  in  self.cardsArrays) {
        NSInteger index = [self.cardsArrays indexOfObject:button];
        Card *card = [self.game cardAtIndex:index];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.matched;
    }
    self.flipLabels.text = [NSString stringWithFormat:@"Score = %ld",(long)self.game.score];
}

-(NSString *)titleForCard:(Card *)card{
    return card.choosen ? card.content : @"";
}


-(UIImage *)backgroundForCard:(Card *)card{
    return [UIImage imageNamed:card.isChoosen?@"frotImage" :@"backImage"];
}


@end
