//
//  Player.m
//  W2D1TwoPlayerMath
//
//  Created by Karlo Pagtakhan on 03/14/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "Player.h"

@implementation Player

-(instancetype) initWithName:(NSString *) name{
  if (self = [super init]) {
    _name = name;
    _score = 0;
    _lives = 3;
  }
  return self;
}

-(void) addScore:(NSInteger)points{
  self.score += points;

}
-(void) subtractLife:(NSInteger)lives{
  self.lives -= lives;
}
-(NSString *) getScore{
  return [NSString stringWithFormat:@"%ld",self.score];
}
-(NSString *) getLives{
  return [NSString stringWithFormat:@"%ld",self.lives];
}

@end
