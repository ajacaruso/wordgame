
#import "StatsPage.h"

@implementation StatsPage
@synthesize backMenu;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	StatsPage *layer = [StatsPage node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
         CCLabelTTF *label = [CCLabelTTF labelWithString:@"Stats Page" fontName:@"Marker Felt" fontSize:32];
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
    [MenuManager goToMainMenu];
}


- (void) dealloc
{
	[super dealloc];
}
@end