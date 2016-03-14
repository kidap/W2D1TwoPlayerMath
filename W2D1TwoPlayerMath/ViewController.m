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
@property (strong, nonatomic) IBOutlet UITextField *answerTextField;
@property (strong, nonatomic) NSString *answerString;
@property (strong, nonatomic) GameMode *gameHandler;

@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  //Initialize Game
  self.answerString = [[NSString alloc] init];
  if(!self.gameHandler){
    self.gameHandler = [[GameMode alloc] initGame];
  }
  
  self.questionLabel.text = [self.gameHandler getRandomQuestion];
  
  //Update label texts
  [self updatedScores];
  
}
- (IBAction)numberPressed:(UIButton *)sender {
  //Get the number pressed using the tags
  self.answerString = [self.answerString stringByAppendingString:[@(sender.tag) stringValue]];
  
  //self.answerString = @"number entered";
  self.answerTextField.text = self.answerString;
}

- (IBAction)submitAnswer:(id)sender {
  //Submit the answer to the game handler
  //If answer is correct, get another ramdom question. Else, display the same question but update question
  if([self.gameHandler giveAnswer:[self.answerString integerValue] byPlayer:self.gameHandler.currentPlayer]){
    self.questionLabel.text = [self.gameHandler getRandomQuestion];
  } else{
    self.questionLabel.text = [self.gameHandler getCurrentQuestion];
  }
  
  //Update label texts
  [self updatedScores];
  
  //Clear answer field
  self.answerTextField.text = @"";
  self.answerString = @"";
}

-(void) updatedScores{
  //Update Player 1 score
  self.player1Label.text = [NSString stringWithString:[NSString stringWithFormat:@"%@: (Score)%@ (Lives)%@",self.gameHandler.player1.name, [self.gameHandler.player1 getScore], [self.gameHandler.player1 getLives]]];
  
  //Update Player 2 score
  self.player2Label.text = [NSString stringWithString:[NSString stringWithFormat:@"%@: (Score)%@ (Lives)%@",self.gameHandler.player2.name, [self.gameHandler.player2 getScore], [self.gameHandler.player2 getLives]]];
}



@end
