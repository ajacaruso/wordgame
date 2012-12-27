
#import "Utils.h"
#include <stdlib.h>

@implementation Utils

+(NSString *) randomizeLetter{
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

+(BOOL) isValidWord:(NSString *)word {
    //return [UIReferenceLibraryViewController dictionaryHasDefinitionForTerm:word];
    return true;
}

+(NSDictionary *)getRandomLevel{
    NSDictionary *randomLevel = [[NSDictionary alloc] init];
    
    NSError *error;
    
    randomLevel = [NSJSONSerialization
                     JSONObjectWithData:[NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gametypemain_2" ofType:@"json"]]
                     options:kNilOptions
                     error:&error];
    
    return randomLevel;
    
}

+(NSDictionary *)getLevel:(NSString *)level{
    NSDictionary *newLevel = [[NSDictionary alloc] init];
    
    NSError *error;
    
    newLevel = [NSJSONSerialization
                   JSONObjectWithData:[NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:level ofType:@"json"]]
                   options:kNilOptions
                   error:&error];
    
    return newLevel;
    
}

@end
