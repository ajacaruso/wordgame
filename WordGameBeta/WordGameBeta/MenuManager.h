//
//  MenuManager.h
//  WordGameBeta
//
//  Created by Adam Jacaruso on 9/13/12.
//
//

#import "cocos2d.h"
#import "MainMenu.h"
#import "OptionsMenu.h"
#import "StatsPage.h"
#import "CreditsPage.h"
#import "GameSettingsPage.h"

@interface MenuManager : NSObject

+(void)createMainMenu;
+(void)goToMainMenu;
+(void)goToOptionsMenu;
+(void)goToStatsPage;
+(void)goToCreditsPage;
+(void)goToGameSettingsPage;

@end
