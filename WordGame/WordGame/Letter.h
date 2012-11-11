//
//  Letter.h
//  WordGame
//
//  Created by Adam Jacaruso on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Utils.h"

@interface Letter : CCSprite
{
    NSString *_letter;
    NSString *_image;
    BOOL _locked;
    Utils *_utils;
    int _letterBankX;
    int _letterBankY;
    int _pointVal;
}

@property (nonatomic, retain) NSString *letter;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, retain) Utils *utils;
@property (nonatomic, assign) int letterBankX;
@property (nonatomic, assign) int letterBankY;
@property (nonatomic, assign) int pointVal;


//getters
-(NSString *) getLetter;
-(NSString *) getImage;
-(BOOL) getLocked;
-(int) getLetterBankX;
-(int) getLetterBankY;
-(int) getPointVal;
-(CGPoint) getLetterPosition;

//setters
-(void) setLetter:(NSString *) newLetter;
-(void) setImage:(NSString *) newImage;
-(void) setLocked:(BOOL) lockState;
-(void) setLetterBankX:(int)xVal;
-(void) setLetterBankY:(int)yVal;

//Functions
-(void) goToSetPosition;


//constructor
-(Letter *) lock:(BOOL) lock;
@end
