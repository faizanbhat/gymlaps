#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject {
    SystemSoundID _soundID;
}

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath;
+ (id)soundEffectForResourceName:(NSString*)resourceName ofType:(NSString*)resourceType;
- (id)initWithContentsOfFile:(NSString *)path;
- (void)play;
- (void)vibrate;
- (void)playVibrate;

@end
