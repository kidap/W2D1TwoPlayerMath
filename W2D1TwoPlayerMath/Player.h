//
//  Player.h
//  W2D1TwoPlayerMath
//
//  Created by Karlo Pagtakhan on 03/14/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property(nonatomic, assign) NSInteger lives;
@property(nonatomic, assign) NSInteger score;
@property(nonatomic, copy) NSString *name;

-(instancetype) initWithName:(NSString *) name;
-(void) addScore:(NSInteger)points;
-(void) subtractLife:(NSInteger)lives;
@end
