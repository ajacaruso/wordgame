
#import "MainMenu.h"


@implementation MainMenu
@synthesize mainMenu;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	MainMenu *layer = [MainMenu node];
	
	[scene addChild: layer];
	
	return scene;
}
-(id) init
{
	if( (self=[super init ])) {
		
        CCMenuItemImage * play = [CCMenuItemImage itemFromNormalImage:@"play_button"
                                                        selectedImage: @"play_button"
                                                               target:self
                                                             selector:@selector(playGame:)];
        
        CCMenuItemImage * options = [CCMenuItemImage itemFromNormalImage:@"options_button"
                                                           selectedImage: @"options_button"
                                                                  target:self
                                                                selector:@selector(showOptions:)];
        
        CCMenuItemImage * stats = [CCMenuItemImage itemFromNormalImage:@"stats_button"
                                                         selectedImage: @"stats_button"
                                                                target:self
                                                              selector:@selector(showStats:)];
        
        mainMenu = [CCMenu menuWithItems: play, stats, options, nil];
        [mainMenu alignItemsVerticallyWithPadding: 20.0f];
        
        [self addChild:mainMenu];
        
        /**** 
         
        Utils Call Example:
         
        NSLog(@"Testing - %@", [Utils randomizeLetter]);
         
        *****/
        
	}
	return self;
}

- (void) playGame: (CCMenuItem  *) menuItem 
{
    [GameManager createGameTypeMain];
}

-(void) showOptions: (CCMenuItem *) menuItem
{
    [MenuManager goToOptionsMenu];
}

-(void) showStats: (CCMenuItem *) menuItem
{
    [MenuManager goToStatsPage];
}

- (void) dealloc
{
	[super dealloc];
}
@end