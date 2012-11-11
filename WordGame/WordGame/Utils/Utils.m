//
//  Utils.m
//  WordGame
//
//  Created by Adam Jacaruso on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#include <stdlib.h>

@implementation Utils

-(NSString *) randomizeLetter{
    NSString *returnString = @"a";
    
    NSString *easyConsonants = @"bcdfghlmnprstw";
    NSString *hardConsonants = @"jkqvxyz";
    NSString *vowels = @"aeiou";
    int ecPct = 55;
    int vPct = 40;
    
    int rand = arc4random()%100;
    
    if(rand <= ecPct)
    {
        //return an easy consonant
        int pos = arc4random()%[easyConsonants length];
        returnString = [easyConsonants substringWithRange:[easyConsonants rangeOfComposedCharacterSequenceAtIndex:(pos)]];
    }
    else if (rand <= ecPct+vPct)
    {
        //return a vowel
        int pos = arc4random()%[vowels length];
        returnString = [vowels substringWithRange:[vowels rangeOfComposedCharacterSequenceAtIndex:(pos)]];
    }
    else {
        //reuturn a hard consonant
        int pos = arc4random()%[hardConsonants length];
        returnString = [hardConsonants substringWithRange:[hardConsonants rangeOfComposedCharacterSequenceAtIndex:(pos)]];
    }
    
    return returnString;
}

-(Boolean) isValidWord:word {
    return [UIReferenceLibraryViewController dictionaryHasDefinitionForTerm:word];
}


@end
