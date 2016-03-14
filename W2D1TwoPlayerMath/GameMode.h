//
//  GameMode.h
//  W2D1TwoPlayerMath
//
//  Created by Karlo Pagtakhan on 03/14/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface GameMode : NSObject

@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;
@property (nonatomic, strong) Player *currentPlayer;
@property (nonatomic) NSInteger currentAnswer;
@property (nonatomic, copy) NSString *currentQuestion;

-(instancetype)initGame;
-(NSString *)getRandomQuestion;
-(NSString *)getCurrentQuestion;
-(BOOL)giveAnswer:(NSInteger)answer byPlayer:(Player *)player;

@end
