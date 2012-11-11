
#import "cocos2d.h"
#import "MenuManager.h"

@interface StatsPage : CCLayer
{
    CCMenu *backMenu;
}

@property (nonatomic, retain) CCMenu *backMenu;

+(CCScene *) scene;

@end