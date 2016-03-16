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
@property (strong, nonatomic) GameMode *gameHandler;
@property (strong, nonatomic) IBOutlet UILabel *gameStatusText;

@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self initializeGame];
  
}
- (IBAction)numberPressed:(UIButton *)sender {
  //Get the number pressed using the tags
  if ([[@(sender.tag) stringValue] isEqualToString:@"-1"]) {
    NSInteger result = [self.answerTextField.text integerValue];
    if (result != 0) {
      result *= -1;
      self.answerTextField.text = [NSString stringWithString:[@(result) stringValue]];
    }
  } else if ([[@(sender.tag) stringValue] isEqualToString:@"-2"]) {
    self.answerTextField.text = @"";
  }  else {
    self.answerTextField.text = [self.answerTextField.text stringByAppendingString:[@(sender.tag) stringValue]];
  }
  
  //self.answerTextField.text = @"number entered";
  self.answerTextField.text = self.answerTextField.text;
}

- (IBAction)submitAnswer:(id)sender {
  if (![self.answerTextField.text isEqualToString:@""]) {
   
    //If answer is correct, get another ramdom question. Else, display the same question but update question
    Player *playerWhoAnswered = self.gameHandler.currentPlayer;
    
    //Submit the answer to the game handler
    if([self.gameHandler giveAnswer:[self.answerTextField.text integerValue]
                           byPlayer:self.gameHandler.currentPlayer]){
      [self updatedgameStatusTextWithString:[NSString stringWithFormat:@"%@ got the right answer.",
                                             playerWhoAnswered.name ] andColor:[UIColor greenColor]];
      self.questionLabel.text = [self.gameHandler getRandomQuestion];
    } else{
      [self updatedgameStatusTextWithString:[NSString stringWithFormat:@"%@ got the wrong answer.",
                                             playerWhoAnswered.name]
                                   andColor:[UIColor redColor]];
      self.questionLabel.text = [self.gameHandler getCurrentQuestion];
    }
    
    //Update label texts
    [self updatedScoresLives];
    
    //Clear answer field
    self.answerTextField.text = @"";
    
    //If game ends, display alert controller
    if (self.gameHandler.gameOver) {
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ wins!!!",
                                                                              self.gameHandler.currentPlayer.name]
                                                                     message:@"Do you want to play again?"
                                                              preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
        [self initializeGame];
      }];
      UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * _Nonnull action) {
        self.view.alpha = 0.5;
        [self.view setUserInteractionEnabled:NO];
      }];
      [alert addAction:ok];
      [alert addAction:cancel];
      [self presentViewController:alert animated:YES completion:nil];
    }
  } else {
    self.gameStatusText.text = @"Please enter and answer";
    [self.gameStatusText setTextColor:[UIColor redColor]];
  }
}

-(void) initializeGame{
  //Initialize Game
  self.answerTextField.text = [[NSString alloc] init];
  self.gameHandler = [[GameMode alloc] initGame];

  
  self.questionLabel.text = [self.gameHandler getRandomQuestion];
  self.gameStatusText.text = @"";
  
  //Update label texts
  [self updatedScoresLives];
}

-(void) updatedScoresLives{
  //Update Player 1 score
  self.player1Label.text = [NSString stringWithString:[NSString stringWithFormat:@"%@: (Score)%@ (Lives)%@",
                                                       self.gameHandler.player1.name,
                                                       [self.gameHandler.player1 getScore],
                                                       [self.gameHandler.player1 getLives]]];
  
  //Update Player 2 score
  self.player2Label.text = [NSString stringWithString:[NSString stringWithFormat:@"%@: (Score)%@ (Lives)%@",
                                                       self.gameHandler.player2.name,
                                                       [self.gameHandler.player2 getScore],
                                                       [self.gameHandler.player2 getLives]]];
}

-(void)updatedgameStatusTextWithString:(NSString *)text andColor:(UIColor *)color{
  self.gameStatusText.text = text;
  [self.gameStatusText setTextColor:color];
  self.gameStatusText.alpha = 0;
  
  [UIView animateWithDuration:1 animations:^{
    self.gameStatusText.alpha = 1;
  }];
}



@end
