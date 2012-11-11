

#import "cocos2d.h"

@interface GameTypeMainTile : CCSprite{
    BOOL useable;
}

@property (nonatomic, assign) BOOL useable;

- (GameTypeMainTile*)initWithFile:(NSString *)file isUsable:(BOOL)isUsable;
- (void)setUseable:(BOOL)newUseable;
- (BOOL)getUseable;
- (void)setTileTexture:(NSString *)file;
- (void)setAsEmpty;

@end
