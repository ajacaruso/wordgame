
#import "cocos2d.h"

@interface GameTypeMainWordBank : CCSprite{
    NSMutableArray *letterBankArray;
}


@property (nonatomic, retain) NSMutableArray *letterBankArray;

- (GameTypeMainWordBank*)initWordBank;
- (void)createInitialWordBank;
- (NSMutableArray *)getLetterBankArray;
- (void)updateWordBank;
- (void)setAllLetterOverlaysOff;
- (bool)bankContainsVowl;
- (bool)stringContainsVowl:(NSString *)letterString;

@end