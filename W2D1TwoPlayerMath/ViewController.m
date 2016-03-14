//
//  ViewController.m
//  W2D1TwoPlayerMath
//
//  Created by Karlo Pagtakhan on 03/14/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"
#import "GameMode.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *player1Label;
@property (strong, nonatomic) IBOutlet UILabel *player2Label;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) NSString *answerString;
@property (strong, nonatomic) GameMode *gameHandler;

@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.answerString = @"";
  if(!self.gameHandler){
    self.gameHandler = [[GameMode alloc] initGame];
  }
  
}
-(void) updatedScores{
  [self.player1Label.text stringByAppendingString:[NSString stringWithFormat:@"%@:%@",self.gameHandler.player1.name, @(self.gameHandler.player1.score)]];
  
  [self.player1Label.text stringByAppendingString:[NSString stringWithFormat:@"%@:%@",self.gameHandler.player1.name, @(self.gameHandler.player1.score)]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)numberPressed:(UIButton *)sender {
  [self.answerString stringByAppendingString:@(sender.tag)];
}

- (IBAction)submitAnswer:(id)sender {
}
@end
