
#import "Utils.h"
#include <stdlib.h>

@implementation Utils

+(NSString *) randomizeLetter{
    
    NSString *returnString = [[NSString alloc] initWithString:@"a"];
    NSMutableDictionary *LetterDictionary = [self createLetterDictionary];
    NSMutableArray *LetterArray = [[NSMutableArray alloc] init];
    
    [LetterDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        int numberOfLetter = [object intValue];
        for(int i = 0; i < numberOfLetter; i++){
            NSString *LetterString = [[NSString alloc] initWithString:key];
            [LetterArray addObject:LetterString];
        }
    }];
    
    NSUInteger randomIndex = arc4random() % [LetterArray count];
    returnString = [LetterArray objectAtIndex:randomIndex];
    return returnString;
}

+(NSString *)randomizeVowl{
    
    NSString *returnString = [[NSString alloc] initWithString:@"a"];
    NSMutableDictionary *LetterDictionary = [self createVowlDictionary];
    NSMutableArray *LetterArray = [[NSMutableArray alloc] init];
    
    [LetterDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        int numberOfLetter = [object intValue];
        for(int i = 0; i < numberOfLetter; i++){
            NSString *LetterString = [[NSString alloc] initWithString:key];
            [LetterArray addObject:LetterString];
        }
    }];
    
    NSUInteger randomIndex = arc4random() % [LetterArray count];
    returnString = [LetterArray objectAtIndex:randomIndex];
    return returnString;
}

+(NSMutableDictionary *)createLetterDictionary{
    
    NSMutableDictionary *LetterDictionary = [[NSMutableDictionary alloc] init];
    
    [LetterDictionary setObject:[NSNumber numberWithInt:16] forKey:@"a"];
    [LetterDictionary setObject:[NSNumber numberWithInt:4] forKey:@"b"];
    [LetterDictionary setObject:[NSNumber numberWithInt:6] forKey:@"c"];
    [LetterDictionary setObject:[NSNumber numberWithInt:8] forKey:@"d"];
    [LetterDictionary setObject:[NSNumber numberWithInt:24] forKey:@"e"];
    [LetterDictionary setObject:[NSNumber numberWithInt:4] forKey:@"f"];
    [LetterDictionary setObject:[NSNumber numberWithInt:5] forKey:@"g"];
    [LetterDictionary setObject:[NSNumber numberWithInt:5] forKey:@"h"];
    [LetterDictionary setObject:[NSNumber numberWithInt:13] forKey:@"i"];
    [LetterDictionary setObject:[NSNumber numberWithInt:2] forKey:@"j"];
    [LetterDictionary setObject:[NSNumber numberWithInt:2] forKey:@"k"];
    [LetterDictionary setObject:[NSNumber numberWithInt:7] forKey:@"l"];
    [LetterDictionary setObject:[NSNumber numberWithInt:6] forKey:@"m"];
    [LetterDictionary setObject:[NSNumber numberWithInt:13] forKey:@"n"];
    [LetterDictionary setObject:[NSNumber numberWithInt:15] forKey:@"o"];
    [LetterDictionary setObject:[NSNumber numberWithInt:4] forKey:@"p"];
    [LetterDictionary setObject:[NSNumber numberWithInt:2] forKey:@"q"];
    [LetterDictionary setObject:[NSNumber numberWithInt:13] forKey:@"r"];
    [LetterDictionary setObject:[NSNumber numberWithInt:10] forKey:@"s"];
    [LetterDictionary setObject:[NSNumber numberWithInt:15] forKey:@"t"];
    [LetterDictionary setObject:[NSNumber numberWithInt:7] forKey:@"u"];
    [LetterDictionary setObject:[NSNumber numberWithInt:3] forKey:@"v"];
    [LetterDictionary setObject:[NSNumber numberWithInt:4] forKey:@"w"];
    [LetterDictionary setObject:[NSNumber numberWithInt:2] forKey:@"x"];
    [LetterDictionary setObject:[NSNumber numberWithInt:4] forKey:@"y"];
    [LetterDictionary setObject:[NSNumber numberWithInt:2] forKey:@"z"];
    
    return LetterDictionary;
    
    /*
    1 point: E ×24, A ×16, O ×15, T ×15, I ×13, N ×13, R ×13, S ×10, L ×7, U ×7
    2 points: D ×8, G ×5
    3 points: C ×6, M ×6, B ×4, P ×4
    4 points: H ×5, F ×4, W ×4, Y ×4, V ×3
    5 points: K ×2
    8 points: J ×2, X ×2
    10 points: Q ×2, Z ×2
     */
}

+(NSMutableDictionary *)createVowlDictionary{
    
    NSMutableDictionary *LetterDictionary = [[NSMutableDictionary alloc] init];
    
    [LetterDictionary setObject:[NSNumber numberWithInt:16] forKey:@"a"];
    [LetterDictionary setObject:[NSNumber numberWithInt:24] forKey:@"e"];
    [LetterDictionary setObject:[NSNumber numberWithInt:13] forKey:@"i"];
    [LetterDictionary setObject:[NSNumber numberWithInt:15] forKey:@"o"];
    [LetterDictionary setObject:[NSNumber numberWithInt:7] forKey:@"u"];
    
    return LetterDictionary;
}

+(BOOL) isValidWord:(NSString *)word {
    
    bool isValid = true;
    
    if([self isRealWord:word] && [self isAllowedWordType:word]){
        
        NSLog(@"%@ %@", word, @" : Valid");
        isValid = true;
    }else{
        
        NSLog(@"%@ %@", word, @" : Invalid");
        isValid = false;
        
    }
    return isValid;
}

+(bool)isRealWord:(NSString *)currentWord{
    
    bool isValid = true;
    
    
    
    UITextChecker* checker = [[UITextChecker alloc] init];
    
    NSRange range;
    
    range = [checker rangeOfMisspelledWordInString:currentWord
             
                                             range:NSMakeRange(0, [currentWord length])
             
                                        startingAt:0
             
                                              wrap:NO
             
                                          language:@"en_US"];
    
    
    
    if (range.location == NSNotFound) {
        
        NSLog(@"%@ %@", @"Is A Real Word : ", currentWord);
        
        isValid = true;
        
    }
    
    else {
        
        NSLog(@"%@ %@", @"Is Not A Real Word : ", currentWord);
        
        isValid = false;
        
    }
    
    
    
    return isValid;
    
}


+(bool)isAllowedWordType:(NSString *)currentWord{
    
    bool isAllowedWordTypeValid = true;
    NSString * currentWordUpperCaseFirstLetter =  [currentWord stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[currentWord substringToIndex:1] uppercaseString]];
    
    NSString *str = [NSString stringWithFormat: @"the %@ is ", currentWordUpperCaseFirstLetter];
    
    
    
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSArray arrayWithObject:NSLinguisticTagSchemeNameTypeOrLexicalClass] options:~NSLinguisticTaggerOmitWords];
    
    [tagger setString:str];
    
    [tagger enumerateTagsInRange:NSMakeRange(0, [str length])
     
                          scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
     
                         options:~NSLinguisticTaggerOmitWords
     
                      usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                          
                          if([tag isEqualToString:@"OtherWord"] || [tag isEqualToString:@"PersonalName"])   {
                              
                              bool isAllowedWordTypeValid = false;
                              
                          }
                          
                          //NSLog(@"found: %@ (%@)", [str substringWithRange:tokenRange], tag);
                          
                      }];
    
    return isAllowedWordTypeValid;
    
}

+(NSDictionary *)getRandomLevel{
    
    NSDictionary *levelDictionary = [[NSDictionary alloc] init];
    NSDictionary *randomLevel = [[NSDictionary alloc] init];
    NSMutableArray *levels = [[NSMutableArray alloc] init];
    NSError *error;
    
    levelDictionary = [NSJSONSerialization
                   JSONObjectWithData:[NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gametypemain_levels" ofType:@"json"]]
                   options:kNilOptions
                   error:&error];
    
    
    
    levels = [levelDictionary objectForKey:@"levels"];
    int randomNumber = arc4random()%[levels count];
    NSDictionary *level = [levels objectAtIndex:randomNumber];
    NSString *levelString = [level objectForKey:@"level"];
    
    NSLog(@"Level Loading : %@", levelString);
    
    randomLevel = [NSJSONSerialization
                     JSONObjectWithData:[NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:levelString ofType:@"json"]]
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

+(int)getLevelSpeed{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    return [defs integerForKey:@"levelSpeed"] + 1;
}

+(void)setLevelSpeed:(int)speed{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setInteger:speed forKey:@"levelSpeed"];
}



@end
