
#import "GameSettingsPage.h"

@implementation GameSettingsPage
@synthesize backMenu;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	GameSettingsPage *layer = [GameSettingsPage node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Settings Page" fontName:@"Marker Felt" fontSize:32];
        CGSize size = [[CCDirector sharedDirector] winSize];
        label.position =  ccp( size.width /2 , size.height/2 );
        [self addChild: label];
        
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

- (void) back: (CCMenuItem  *) menuItem 
{
    [MenuManager goToOptionsMenu];
}


- (void) dealloc
{
	[super dealloc];
}
@end