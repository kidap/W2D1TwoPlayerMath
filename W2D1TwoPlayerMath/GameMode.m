//
//  GameMode.m
//  W2D1TwoPlayerMath
//
//  Created by Karlo Pagtakhan on 03/14/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "GameMode.h"

@implementation GameMode

-(instancetype)initGame{
  if (self = [super init]) {
    _player1 = [[Player alloc] initWithName:@"Player1"];
    _player2 = [[Player alloc] initWithName:@"Player2"];
    _currentPlayer = _player1;
    _currentAnswer = 0;
    _currentQuestion = [[NSString alloc] init];
  }

  return self;
}

-(NSString *)getRandomQuestion{
  NSInteger addend1 = arc4random_uniform(20)+1;
  NSInteger addend2 = arc4random_uniform(20)+1;
  
  self.currentAnswer = addend1 + addend2;
  self.currentQuestion = [NSString stringWithFormat:@"%@ + %@?", @(addend1), @(addend2)];
  
  return [NSString stringWithFormat:@"%@: %@", self.currentPlayer.name, self.currentQuestion];
  
}
-(NSString *)getCurrentQuestion{
  return [NSString stringWithFormat:@"%@: %@", self.currentPlayer.name, self.currentQuestion];
}

-(BOOL)giveAnswer:(NSInteger)answer byPlayer:(Player *)player{
  
  if ([self isAnswerCorrect:answer]){
    [player addScore:1];
    [self changeTurn];
    
    return  YES;
  } else {
    [player subtractLife:1];
    [self changeTurn];
    
    return NO;
  }
}


-(BOOL)isAnswerCorrect:(NSInteger)answer{
  
  if (answer == _currentAnswer) {
    return YES;
  }

  return NO;
}

-(void)changeTurn{
  if ([self.currentPlayer isEqual:self.player1]) {
    self.currentPlayer = self.player2;
  } else{
    self.currentPlayer = self.player1;
  }
}


@end
