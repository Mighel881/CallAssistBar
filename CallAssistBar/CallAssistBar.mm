#line 1 "/Users/xybp888/Desktop/CallAssistBar/CallAssistBar/CallAssistBar.xm"
#import <UIKit/UIKit.h>
#import "TUCall.h"
#import <AddressBook/AddressBook.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.xybp888.test.plist"   
 
inline bool GetPrefBool(NSString *key){
  return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}


@interface PHInCallRootViewController:UIViewController
@property (retain, nonatomic) UIViewController* CallViewController;
@property (assign) BOOL dismissalWasDemandedBeforeRemoteViewControllerWasAvailable;
@property(retain, nonatomic) TUCall *alertActivationCall;
+(id)sharedInstance;
+(void)setShouldForceDismiss;
-(void)prepareForDismissal;
-(void)dismissPhoneRemoteViewController;
-(void)presentPhoneRemoteViewControllerForView:(id)arg1;
@end

@interface SpringBoard <UIGestureRecognizerDelegate>
@property (retain, nonatomic) UIWindow *callWindow;
@property (retain, nonatomic) UIButton *contactView;
@property (retain, nonatomic) UIButton *acceptButton;
@property (retain, nonatomic) UIButton *declineButton;
@property (retain, nonatomic) UIButton *speakerButton;
@property (retain, nonatomic) UILabel *callerLabel;
@property (retain, nonatomic) UILabel *numberLabel;
+(id)sharedApplication;
-(void)shouldShowCallBanner;
-(void)shouldHideCallBanner;
@end

@interface TUCallCenter
+(id)sharedInstance;
-(id)incomingCall;
-(void)answerCall:(id)arg1;
-(void)disconnectCall:(id)arg1;
-(void)holdCall:(id)arg1 ;
-(void)unholdCall:(id)arg1;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class TUCall; @class PHInCallUIUtilities; @class PHInCallRootViewController; @class TUCallCenter; @class SpringBoard; 
static void (*_logos_orig$_ungrouped$TUCall$_handleStatusChange)(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$TUCall$_handleStatusChange(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController)(_LOGOS_SELF_TYPE_NORMAL PHInCallRootViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController(_LOGOS_SELF_TYPE_NORMAL PHInCallRootViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$move$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIPanGestureRecognizer *); static void _logos_method$_ungrouped$SpringBoard$shouldShowCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$shouldHideCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$shouldAnswerCall(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$shouldDisconnectCall(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SpringBoard$orientationChanged(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$PHInCallUIUtilities(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("PHInCallUIUtilities"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SpringBoard(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SpringBoard"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$TUCallCenter(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("TUCallCenter"); } return _klass; }
#line 45 "/Users/xybp888/Desktop/CallAssistBar/CallAssistBar/CallAssistBar.xm"

static void _logos_method$_ungrouped$TUCall$_handleStatusChange(_LOGOS_SELF_TYPE_NORMAL TUCall* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    _logos_orig$_ungrouped$TUCall$_handleStatusChange(self, _cmd);
    id incomingCallState = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];
    if(incomingCallState){
        [[_logos_static_class_lookup$SpringBoard() sharedApplication] shouldShowCallBanner];
    }else{
        [[_logos_static_class_lookup$SpringBoard() sharedApplication] shouldHideCallBanner];
    }
}




static void _logos_method$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController(_LOGOS_SELF_TYPE_NORMAL PHInCallRootViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    id incomingCallState = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];
    if(![_logos_static_class_lookup$PHInCallUIUtilities()isSpringBoardLocked] && incomingCallState){
        [self prepareForDismissal];
        [self dismissPhoneRemoteViewController];
     
    }
    _logos_orig$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController(self, _cmd);
}



@interface UIWindow ()
- (void)_setSecure:(BOOL)arg1;
@end
@interface UIApplication ()
- (UIDeviceOrientation)_frontMostAppOrientation;
@end

static float kScreenW;
static float kScreenH;
static UIDeviceOrientation orientationOld;
static BOOL forceNewLocation;
static float kWidth = 63.0;
static float kHeight = 13.0;
static int kLocX;
static int kLocY;
static BOOL isheng;

static void orientationChanged()
{
    [[_logos_static_class_lookup$SpringBoard() sharedApplication] orientationChanged];
}


__attribute__((used)) static UIWindow * _logos_method$_ungrouped$SpringBoard$callWindow(SpringBoard * __unused self, SEL __unused _cmd) { return (UIWindow *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallWindow(SpringBoard * __unused self, SEL __unused _cmd, UIWindow * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callWindow, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIView * _logos_method$_ungrouped$SpringBoard$contactView(SpringBoard * __unused self, SEL __unused _cmd) { return (UIView *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$contactView); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setContactView(SpringBoard * __unused self, SEL __unused _cmd, UIView * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$contactView, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$acceptButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setAcceptButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$acceptButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$declineButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$declineButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setDeclineButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$declineButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UIButton * _logos_method$_ungrouped$SpringBoard$speakerButton(SpringBoard * __unused self, SEL __unused _cmd) { return (UIButton *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$speakerButton); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setSpeakerButton(SpringBoard * __unused self, SEL __unused _cmd, UIButton * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$speakerButton, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SpringBoard$callerLabel(SpringBoard * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callerLabel); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setCallerLabel(SpringBoard * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$callerLabel, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SpringBoard$numberLabel(SpringBoard * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$numberLabel); }; __attribute__((used)) static void _logos_method$_ungrouped$SpringBoard$setNumberLabel(SpringBoard * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SpringBoard$numberLabel, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIApplication * arg1){
    if(!GetPrefBool(@"kTweakEnabled")) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        
        kScreenW = [[UIScreen mainScreen] bounds].size.width;
        kScreenH = [[UIScreen mainScreen] bounds].size.height;
       
        
        self.callWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, 35, screenBounds.size.width - 20, 100)];
        self.callWindow.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:0.0];
        kLocX = self.callWindow.frame.origin.x;
        kLocY = self.callWindow.frame.origin.y;
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.callWindow.bounds;
        blurEffectView.layer.cornerRadius = 20;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [blurEffectView.layer setMasksToBounds:YES];
        [self.callWindow addSubview:blurEffectView];

        self.callWindow.windowLevel = UIWindowLevelAlert-10;
        self.callWindow.layer.cornerRadius = 20;
        self.callWindow.userInteractionEnabled = YES;
        [self.callWindow setHidden:NO];
        [self.callWindow.layer setMasksToBounds:YES];

        static UISwipeGestureRecognizer* swipeUpGesture;
        swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(shouldHideCallBanner)];
        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [self.callWindow addGestureRecognizer:swipeUpGesture];

        

        if(!self.contactView){ 

            self.contactView = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
            self.contactView.alpha = 1;
            self.contactView.layer.cornerRadius = 35;
            self.contactView.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.7];

            [self.callWindow addSubview:self.contactView];

        }

        if(!self.acceptButton){

            self.acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(self.callWindow.frame.size.width - 138, 30, 45, 45)];
            self.acceptButton.alpha = 1;
            self.acceptButton.layer.cornerRadius = 22;
            self.acceptButton.backgroundColor = [UIColor colorWithRed:0.13 green:0.75 blue:0.42 alpha:1.0];

            UIImage *acceptImage = [UIImage imageWithContentsOfFile:@"/Library/CallAssistBar/answer.png"];
            UIImageView *acceptImageView = [[UIImageView alloc] initWithImage:acceptImage];
            acceptImageView.frame = self.acceptButton.bounds;
            acceptImageView.contentMode = UIViewContentModeCenter;
            acceptImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            acceptImageView.clipsToBounds  = YES;
            [self.acceptButton addSubview:acceptImageView];

            UITapGestureRecognizer *tapAnswer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(shouldAnswerCall)];
            tapAnswer.numberOfTapsRequired = 1;
            [self.acceptButton addGestureRecognizer:tapAnswer];

            [self.callWindow addSubview:self.acceptButton];

        }

        if(!self.speakerButton){

            self.speakerButton = [[UIButton alloc] initWithFrame:CGRectMake(self.callWindow.frame.size.width - 138, 30, 45, 45)];
            self.speakerButton.alpha = 1;
            self.speakerButton.hidden = YES;
            self.speakerButton.layer.cornerRadius = 22;
            self.speakerButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0];

            UITapGestureRecognizer *tapSpeaker = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(shouldAnswerCall)];
            tapSpeaker.numberOfTapsRequired = 1;
            [self.speakerButton addGestureRecognizer:tapSpeaker];

            [self.callWindow addSubview:self.speakerButton];

        }

        if(!self.declineButton){

            self.declineButton = [[UIButton alloc] initWithFrame:CGRectMake(self.callWindow.frame.size.width - 80, 30, 45, 45)];
            self.declineButton.alpha = 1;
            self.declineButton.layer.cornerRadius = 22;
            self.declineButton.backgroundColor = [UIColor colorWithRed:0.92 green:0.23 blue:0.35 alpha:1.0];

            UIImage *declineImage = [UIImage imageWithContentsOfFile:@"/Library/CallAssistBar/decline.png"];
            UIImageView *declineImageView = [[UIImageView alloc] initWithImage:declineImage];
            declineImageView.frame = self.declineButton.bounds;
            declineImageView.contentMode = UIViewContentModeCenter;
            declineImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            declineImageView.clipsToBounds  = YES;
            [self.declineButton addSubview:declineImageView];

            UITapGestureRecognizer *tapDisconnect = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(shouldDisconnectCall)];
            tapDisconnect.numberOfTapsRequired = 1;
            [self.declineButton addGestureRecognizer:tapDisconnect];

            [self.callWindow addSubview:self.declineButton];

        }

        if (!self.callerLabel){
            self.callerLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, 100, 50)];
            [self.callerLabel setTextColor:[UIColor whiteColor]];
            [self.callerLabel setBackgroundColor:[UIColor clearColor]];
            [self.callerLabel setFont:[UIFont boldSystemFontOfSize:18]];
            self.callerLabel.text = @"Jony Ive";
            [self.callWindow addSubview:self.callerLabel];
        }

        if (!self.numberLabel){
            self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 32, 150, 50)];
            [self.numberLabel setTextColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.7]];
            [self.numberLabel setBackgroundColor:[UIColor clearColor]];
            [self.numberLabel setFont:[UIFont systemFontOfSize:15]];
            self.numberLabel.text = @"1 (519) 555 3789";
            [self.callWindow addSubview:self.numberLabel];
        }
        self.callWindow.hidden = YES;
    }
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)&orientationChanged, CFSTR("com.apple.springboard.screenchanged"), NULL, 0);
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, (CFNotificationCallback)&orientationChanged, CFSTR("UIWindowDidRotateNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    
 
    _logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$(self, _cmd, arg1);
}



static void _logos_method$_ungrouped$SpringBoard$move$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIPanGestureRecognizer * recognizer) {
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;

    CGPoint translation = [recognizer translationInView:self.callWindow];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                 recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.callWindow];

    if (recognizer.state == UIGestureRecognizerStateEnded) {

        CGPoint velocity = [recognizer velocityInView:self.callWindow];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;

        float slideFactor = 0.1 * slideMult; 
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                 recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), screenBounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), screenBounds.size.height);

        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
         recognizer.view.center = finalPoint;
     } completion:nil];
    }
}

static void _logos_method$_ungrouped$SpringBoard$shouldShowCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){ 

    TUCall *incomingCallInfo = [[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall];
    
    self.callerLabel.text = incomingCallInfo.displayName;
    self.numberLabel.text = incomingCallInfo.destinationID;

    UIImage *otherContactImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/BetterHUD/contact.png"];
        
    UIImageView *contactImageView = [[UIImageView alloc] initWithImage:otherContactImage];
    contactImageView.frame = self.contactView.bounds;
    contactImageView.layer.cornerRadius = 20;
    [contactImageView.layer setMasksToBounds:YES];
    [self.contactView addSubview:contactImageView];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        self.callWindow.hidden = NO;
        if(isheng){
         
           self.callWindow.center = CGPointMake(self.callWindow.center.x,+215);
        }else{
            self.callWindow.center = CGPointMake(self.callWindow.center.x, +85);
        }
       
    }
    completion:^(BOOL finished) {
        
    }];

}

static void _logos_method$_ungrouped$SpringBoard$shouldHideCallBanner(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    [UIView animateWithDuration:0.3f animations:^{
        self.callWindow.hidden = YES;
        self.callWindow.center = CGPointMake(self.callWindow.center.x, self.callWindow.center.y);
        
    }
    completion:^(BOOL finished) {
        
    }];
}

static void _logos_method$_ungrouped$SpringBoard$shouldAnswerCall(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    [[_logos_static_class_lookup$TUCallCenter() sharedInstance] answerCall:[[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall]];
    
    
    
    
}

static void _logos_method$_ungrouped$SpringBoard$shouldDisconnectCall(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    [[_logos_static_class_lookup$TUCallCenter() sharedInstance] disconnectCall:[[_logos_static_class_lookup$TUCallCenter() sharedInstance] incomingCall]];
    
    [self shouldHideCallBanner];
}



static void _logos_method$_ungrouped$SpringBoard$orientationChanged(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    UIDeviceOrientation orientation = [[UIApplication sharedApplication] _frontMostAppOrientation];
    if(orientation == orientationOld && !forceNewLocation) {
        return;
    }
    forceNewLocation = NO;
    BOOL isLandscape;
    __block CGAffineTransform newTransform;
    __block int xLoc;
    __block int yLoc;
#define DegreesToRadians(degrees) (degrees * M_PI / 180)
    switch (orientation) {
        case UIDeviceOrientationLandscapeRight: {
            NSLog(@"测试1"); 
            isLandscape = YES;
            isheng = YES;
            yLoc = kScreenH / 2 - self.callWindow.frame.size.width + 30;
            xLoc = 1.0;
          
            newTransform = CGAffineTransformMakeRotation(-DegreesToRadians(90));
            break;
        }
        case UIDeviceOrientationLandscapeLeft: {
            NSLog(@"测试2"); 
            isheng = YES;
            isLandscape = YES;
            yLoc = kScreenH / 2 - self.callWindow.frame.size.width/2;
            xLoc = kScreenW - kHeight - 90.0;
            newTransform = CGAffineTransformMakeRotation(DegreesToRadians(90));
            [self.callWindow setUserInteractionEnabled:YES];
            break;
        }
        case UIDeviceOrientationPortraitUpsideDown: {
          
            isLandscape = NO;
            yLoc = (kScreenH-kHeight-kLocY);
            xLoc = kLocX;
         
            newTransform = CGAffineTransformMakeRotation(DegreesToRadians(180));
            break;
        }
        case UIDeviceOrientationPortrait:
        default: {
           
            isLandscape = NO;
            isheng = NO;
            yLoc = kLocY;
            xLoc = kLocX;
          
            newTransform = CGAffineTransformMakeRotation(DegreesToRadians(0));
            break;
        }
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.callWindow setTransform:newTransform];
        CGRect frame = self.callWindow.frame;
        frame.origin.y = yLoc;
        frame.origin.x = xLoc;
        self.callWindow.frame = frame;
        orientationOld = orientation;
    } completion:nil];
}



































static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$TUCall = objc_getClass("TUCall"); MSHookMessageEx(_logos_class$_ungrouped$TUCall, @selector(_handleStatusChange), (IMP)&_logos_method$_ungrouped$TUCall$_handleStatusChange, (IMP*)&_logos_orig$_ungrouped$TUCall$_handleStatusChange);Class _logos_class$_ungrouped$PHInCallRootViewController = objc_getClass("PHInCallRootViewController"); MSHookMessageEx(_logos_class$_ungrouped$PHInCallRootViewController, @selector(_loadAudioCallViewController), (IMP)&_logos_method$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController, (IMP*)&_logos_orig$_ungrouped$PHInCallRootViewController$_loadAudioCallViewController);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIPanGestureRecognizer *), strlen(@encode(UIPanGestureRecognizer *))); i += strlen(@encode(UIPanGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(move:), (IMP)&_logos_method$_ungrouped$SpringBoard$move$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(shouldShowCallBanner), (IMP)&_logos_method$_ungrouped$SpringBoard$shouldShowCallBanner, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(shouldHideCallBanner), (IMP)&_logos_method$_ungrouped$SpringBoard$shouldHideCallBanner, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(shouldAnswerCall), (IMP)&_logos_method$_ungrouped$SpringBoard$shouldAnswerCall, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(shouldDisconnectCall), (IMP)&_logos_method$_ungrouped$SpringBoard$shouldDisconnectCall, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(orientationChanged), (IMP)&_logos_method$_ungrouped$SpringBoard$orientationChanged, _typeEncoding); }{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callWindow), (IMP)&_logos_method$_ungrouped$SpringBoard$callWindow, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallWindow:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallWindow, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIView *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(contactView), (IMP)&_logos_method$_ungrouped$SpringBoard$contactView, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIView *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setContactView:), (IMP)&_logos_method$_ungrouped$SpringBoard$setContactView, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(acceptButton), (IMP)&_logos_method$_ungrouped$SpringBoard$acceptButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setAcceptButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setAcceptButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(declineButton), (IMP)&_logos_method$_ungrouped$SpringBoard$declineButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setDeclineButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setDeclineButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(speakerButton), (IMP)&_logos_method$_ungrouped$SpringBoard$speakerButton, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIButton *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setSpeakerButton:), (IMP)&_logos_method$_ungrouped$SpringBoard$setSpeakerButton, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(callerLabel), (IMP)&_logos_method$_ungrouped$SpringBoard$callerLabel, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setCallerLabel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setCallerLabel, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(numberLabel), (IMP)&_logos_method$_ungrouped$SpringBoard$numberLabel, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(setNumberLabel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setNumberLabel, _typeEncoding); } } }
#line 421 "/Users/xybp888/Desktop/CallAssistBar/CallAssistBar/CallAssistBar.xm"
