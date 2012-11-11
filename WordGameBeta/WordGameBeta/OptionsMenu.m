
#import "OptionsMenu.h"

@implementation OptionsMenu
@synthesize optionsMenu, backMenu;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	OptionsMenu *layer = [OptionsMenu node];
	
	[scene addChild: layer];
	
	return scene;
}



-(id) init
{
	if( (self=[super init])) {
        
		//Options Menu
        CCMenuItemImage * credits = [CCMenuItemImage itemFromNormalImage:@"credits_button"
                                                           selectedImage: @"credits_button"
                                                                  target:self
                                                                selector:@selector(showCredits:)];
        
        CCMenuItemImage * settings = [CCMenuItemImage itemFromNormalImage:@"settings_button"
                                                            selectedImage: @"settings_button"
                                                                   target:self
                                                                 selector:@selector(showSettings:)];
        
        optionsMenu = [CCMenu menuWithItems: settings, credits, nil];
        [optionsMenu alignItemsVerticallyWithPadding: 20.0f];
        
        [self addChild:optionsMenu];
        
        //Back Menu
        backMenu = [CCMenu menuWithItems:nil];
        CCMenuItemImage *backBtn = [CCMenuItemImage itemFromNormalImage:@"BackArrow_Button.png"
                                                          selectedImage: @"BackArrow_Button.png"
                                                                 target:self
                                                               selector:@selector(back:)];
        [backMenu addChild:backBtn];
        backMenu.position = ccp(45, 45);
        
        [self addChild:backMenu];
        
	}
	return self;
}

- (void) showCredits: (CCMenuItem  *) menuItem 
{
    [MenuManager goToCreditsPage];
}

-(void) showSettings: (CCMenuItem *) menuItem
{
    [MenuManager goToGameSettingsPage];
}

- (void) back: (CCMenuItem  *) menuItem 
{
    [MenuManager goToMainMenu];
}

- (void) dealloc
{
	[super dealloc];
}
@end