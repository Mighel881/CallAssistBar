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

%hook TUCall
-(void)_handleStatusChange {
    %orig;
    id incomingCallState = [[%c(TUCallCenter) sharedInstance] incomingCall];
    if(incomingCallState){
        [[%c(SpringBoard) sharedApplication] shouldShowCallBanner];
    }else{
        [[%c(SpringBoard) sharedApplication] shouldHideCallBanner];
    }
}
%end


%hook PHInCallRootViewController //锁定显示正常界面
- (void)_loadAudioCallViewController{
    id incomingCallState = [[%c(TUCallCenter) sharedInstance] incomingCall];
    if(![%c(PHInCallUIUtilities)isSpringBoardLocked] && incomingCallState){
        [self prepareForDismissal];
        [self dismissPhoneRemoteViewController];
     //   NSLog(@"测试未锁定");
    }
    %orig;
}
%end


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
    [[%c(SpringBoard) sharedApplication] orientationChanged];
}

%hook SpringBoard
%property (retain, nonatomic) UIWindow *callWindow;
%property (retain, nonatomic) UIView *contactView;
%property (retain, nonatomic) UIButton *acceptButton;
%property (retain, nonatomic) UIButton *declineButton;
%property (retain, nonatomic) UIButton *speakerButton;
%property (retain, nonatomic) UILabel *callerLabel;
%property (retain, nonatomic) UILabel *numberLabel;

- (void)applicationDidFinishLaunching:(UIApplication *)arg1{
    if(!GetPrefBool(@"kTweakEnabled")) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        
        kScreenW = [[UIScreen mainScreen] bounds].size.width;
        kScreenH = [[UIScreen mainScreen] bounds].size.height;
       // NSLog(@"测试Call");
        // Call Banner
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

        //Banner Elements

        if(!self.contactView){ // 联系人头像

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
    
 //   [self shouldShowCallBanner]; //调试可以打开
    %orig;
}


%new
- (void)move:(UIPanGestureRecognizer *)recognizer {
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;

    CGPoint translation = [recognizer translationInView:self.callWindow];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                 recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.callWindow];

    if (recognizer.state == UIGestureRecognizerStateEnded) {

        CGPoint velocity = [recognizer velocityInView:self.callWindow];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;

        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                 recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), screenBounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), screenBounds.size.height);

        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
         recognizer.view.center = finalPoint;
     } completion:nil];
    }
}
%new
- (void)shouldShowCallBanner{ //显示Bar

    TUCall *incomingCallInfo = [[%c(TUCallCenter) sharedInstance] incomingCall];
    
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
         //   CGRect screenBounds = [UIScreen mainScreen].bounds;
           self.callWindow.center = CGPointMake(self.callWindow.center.x,+215);
        }else{
            self.callWindow.center = CGPointMake(self.callWindow.center.x, +85);
        }
       
    }
    completion:^(BOOL finished) {
        //[self performSelector:@selector(volumeSliderShouldHide) withObject:self afterDelay:3.0 ];
    }];

}
%new
- (void)shouldHideCallBanner{
    [UIView animateWithDuration:0.3f animations:^{
        self.callWindow.hidden = YES;
        self.callWindow.center = CGPointMake(self.callWindow.center.x, self.callWindow.center.y);
        
    }
    completion:^(BOOL finished) {
        //[self performSelector:@selector(volumeSliderShouldHide) withObject:self afterDelay:3.0 ];
    }];
}
%new
-(void)shouldAnswerCall{
    [[%c(TUCallCenter) sharedInstance] answerCall:[[%c(TUCallCenter) sharedInstance] incomingCall]];
    
    //If we wanna replace the answer button with a speaker button
    //self.acceptButton.hidden = YES;
    //self.speakerButton.hidden = NO;
}
%new
-(void)shouldDisconnectCall{
    [[%c(TUCallCenter) sharedInstance] disconnectCall:[[%c(TUCallCenter) sharedInstance] incomingCall]];
    //[[%c(TUCallCenter) sharedInstance] disconnectWithReason:1];
    [self shouldHideCallBanner];
}

%new
- (void)orientationChanged
{
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
          //  NSLog(@"测试1"); //横屏隐藏
            isLandscape = YES;
            isheng = YES;
            yLoc = kScreenH / 2 - self.callWindow.frame.size.width + 30;//kLocX;
            xLoc = 1.0;//kLocY;
          //  [self.callWindow setUserInteractionEnabled:NO];
            newTransform = CGAffineTransformMakeRotation(-DegreesToRadians(90));
            break;
        }
        case UIDeviceOrientationLandscapeLeft: {
           // NSLog(@"测试2"); //横屏隐藏
            isheng = YES;
            isLandscape = YES;
            yLoc = kScreenH / 2 - self.callWindow.frame.size.width/2;
            xLoc = kScreenW - kHeight - 90.0;//(kScreenW-kHeight-kLocY);
            newTransform = CGAffineTransformMakeRotation(DegreesToRadians(90));
            [self.callWindow setUserInteractionEnabled:YES];
            break;
        }
        case UIDeviceOrientationPortraitUpsideDown: {
          //  NSLog(@"测试3");
            isLandscape = NO;
            yLoc = (kScreenH-kHeight-kLocY);
            xLoc = kLocX;
         //   [self.callWindow setUserInteractionEnabled:NO];
            newTransform = CGAffineTransformMakeRotation(DegreesToRadians(180));
            break;
        }
        case UIDeviceOrientationPortrait:
        default: {
           // NSLog(@"测试4");
            isLandscape = NO;
            isheng = NO;
            yLoc = kLocY;
            xLoc = kLocX;
          //  [self.callWindow setUserInteractionEnabled:YES];
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

%end
