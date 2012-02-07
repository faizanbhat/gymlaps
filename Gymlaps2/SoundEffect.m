#import "SoundEffect.h"

@implementation SoundEffect

+(id)soundEffectForResourceName:(NSString*)resourceName ofType:(NSString*)resourceType {
	
	NSBundle *mainBundle = [NSBundle mainBundle];
	NSString *aPath = [mainBundle pathForResource:resourceName ofType:resourceType];
	if(aPath){
		return [[SoundEffect alloc] initWithContentsOfFile:aPath];
	}
	return nil;
}

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath {
    if (aPath) {
        return [[SoundEffect alloc] initWithContentsOfFile:aPath];
    }
    return nil;
}



- (id)initWithContentsOfFile:(NSString *)path {
    self = [super init];
    
    if (self != nil) {
        NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        
        if (aFileURL != nil)  {
            SystemSoundID aSoundID;
            
            // The __bridge tag has to do with how the comipler treats the CFURLRef object in ARC. 
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)aFileURL, &aSoundID);
            
            if (error == kAudioServicesNoError) { // success
                _soundID = aSoundID;
            } else {
                self = nil;
            }
        } else {
            self = nil;
        }
    }
    return self;
}


-(void)play {
    AudioServicesPlaySystemSound(_soundID);
}

-(void)vibrate{
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);	
}

-(void)playVibrate{
    AudioServicesPlaySystemSound(_soundID);
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);	
}


@end
