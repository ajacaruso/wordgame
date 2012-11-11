//
//  MenuManager.m
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/13/12.
//
//

#import "MenuManager.h"

@implementation MenuManager

+(void)createMainMenu{
    [[CCDirector sharedDirector] runWithScene: [MainMenu scene]];
}

+(void)goToMainMenu{
     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[MainMenu scene]]];
}

+(void)goToOptionsMenu{
     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[OptionsMenu scene]]];
}

+(void)goToStatsPage{
     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[StatsPage scene]]];
}

+(void)goToCreditsPage{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[CreditsPage scene]]];
}

+(void)goToGameSettingsPage{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[GameSettingsPage scene]]];
}


@end
