

#import "cocos2d.h"

@interface GameTypeMainTile : CCSprite{
    BOOL useable;
    NSString *special;
    NSString *specialOne;
    NSString *specialTwo;
    BOOL useableOne;
    BOOL useableTwo;
}

@property (nonatomic, assign) BOOL useable;
@property (nonatomic, assign) NSString *special;

@property (nonatomic, assign) BOOL useableOne;
@property (nonatomic, assign) BOOL useableTwo;
@property (nonatomic, assign) NSString *specialOne;
@property (nonatomic, assign) NSString *specialTwo;

- (GameTypeMainTile*)initWithFile:(NSString *)file starting:(int)starting image1:(NSString *)image1 isUseable1:(BOOL)isUseable1 special1:(NSString *)special1 image2:(NSString *)image2 isUseable2:(BOOL)isUseable2 special2:(NSString *)special2;
- (void)setUseable:(BOOL)newUseable;
- (BOOL)getUseable;
- (void)setSpecial:(NSString *)newSpecial;
- (NSString *)getSpecial;
- (void)setTileTexture:(NSString *)file;
- (void)setAsEmpty;

@end