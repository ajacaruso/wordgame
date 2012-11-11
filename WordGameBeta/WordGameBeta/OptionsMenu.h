
#import "cocos2d.h"
#import "MenuManager.h"

@interface OptionsMenu : CCLayer
{
    CCMenu *optionsMenu;
    CCMenu *backMenu;
}

@property (nonatomic, retain) CCMenu *optionsMenu;
@property (nonatomic, retain) CCMenu *backMenu;

+(CCScene *) scene;

@end
