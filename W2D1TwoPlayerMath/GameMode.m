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
    _gameOver = NO;
  }

  return self;
}

-(NSString *)getRandomQuestion{
  NSInteger number1 = arc4random_uniform(20)+1;
  NSInteger number2 = arc4random_uniform(20)+1;
  NSString *operand = [[NSString alloc] init];
  
  switch (arc4random_uniform(4)) {
    case 0:
      operand = @"+";
      self.currentAnswer = number1 + number2;
      break;
    case 1:
      operand = @"-";
      self.currentAnswer = number1 - number2;
      break;
    case 2:
      operand = @"*";
      self.currentAnswer = number1 * number2;
      break;
    case 3:
      operand = @"/";
      //Don't allow fractions
      if (number1 < number2){
        NSInteger tmp = number2;
        number2 = number1;
        number1 = tmp;
      }
      self.currentAnswer = number1 / number2;
      break;
      
    default:
      NSLog(@"Broken link");
      break;
  }
  
  
  self.currentQuestion = [NSString stringWithFormat:@"%@ %@ %@?", @(number1), operand, @(number2)];
  
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
    
    //If player has no more life, set flag. Else, continue and change player
    if (player.lives <= 0){
      self.gameOver = YES;
    }
    
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
