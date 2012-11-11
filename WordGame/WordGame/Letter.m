//
//  Letter.m
//  WordGame
//
//  Created by Adam Jacaruso on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Letter.h"

@implementation Letter
@synthesize letter = _letter, image = _image, locked = _locked, utils = _utils, letterBankY = _letterBankY, letterBankX = _letterBankX, pointVal = _pointVal;

//getters
-(NSString *)getLetter
{
    //return  @"test";
    return _letter;
}

-(NSString *)getImage
{
    return _image;
}

-(BOOL)getLocked
{
    return _locked;
}

-(int) getLetterBankX{
    return _letterBankX;
}

-(int) getLetterBankY{
    return _letterBankY;
}

-(CGPoint) getLetterPosition{
    CGPoint position = ccp(_letterBankX, _letterBankY);
    return position;
}

-(int)getPointVal{
    return _pointVal;
}

//setters
-(void) setLetter:(NSString *)newLetter
{
    _letter = newLetter;
}

-(void) setImage:(NSString *)newImage
{
    _image = newImage;
}

-(void) setLocked:(BOOL)lockState
{
    _locked = lockState;
}

-(void) setLetterBankX:(int)xVal{
    _letterBankX = xVal;
}

-(void) setLetterBankY:(int)yVal{
    _letterBankY = yVal;
}

-(void) goToSetPosition{
    self.position = ccp(_letterBankX, _letterBankY);
}

//constructor
-(Letter *) lock:(BOOL)lock
{
    _utils = [[Utils alloc] init];
    NSString *randomLetter = [_utils randomizeLetter];
    NSString *letterImage = [NSString stringWithFormat:@"%@.png", randomLetter];
    self = [[super initWithFile:letterImage rect:CGRectMake(0, 0, 40, 40)] autorelease];
    
    _letter = [[NSString alloc] initWithString:randomLetter];
    _pointVal = 5;
    _image = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@.png", _letter]];
    
    self.anchorPoint = ccp(0,0);
    
    [self setLocked:lock];
    
    randomLetter = nil;
    [randomLetter release];
    
    letterImage = nil;
    [letterImage release];
    
    return self;
}

@end
