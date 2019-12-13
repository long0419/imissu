//
//  TouchEachOtherViewController.m
//  imissu
//
//  Created by long-laptop on 16/3/13.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "TouchEachOtherViewController.h"
#import "NIMSDK.h"
#import "AudioToolbox/AudioToolbox.h"
#import "UIView+Addition.h"

@class CAEmitterLayer;

@interface TouchEachOtherViewController (){
    UILabel *label ;
    CGPoint locaiton ;
}

@end

@implementation TouchEachOtherViewController
@synthesize heartsEmitter;

- (id) init{
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    return self;
}

-(void)showLove{
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:150.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    heartsBurst.duration		= 5.0;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}

-(void)dealloc{
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _meImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 80, 80)];
    [_meImage setImage:[UIImage imageNamed:self.type]];
    _meImage.hidden = YES ;
    _meImage.userInteractionEnabled = YES ;
    [self.view addSubview:_meImage];
    
    NSString *name = @"" ;
    if ([self.type isEqualToString:@"nan"]) {
        name = @"nv" ;
    }else{
        name = @"nan" ;
    }
    
    _missImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 80, 80)];
    [_missImage setImage:[UIImage imageNamed:name]];
    _missImage.hidden = YES ;
    _missImage.userInteractionEnabled = YES ;
    [self.view addSubview:_missImage];
  
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20  , 44 , 30, 20)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, kScreen_Width, 20)];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    locaiton = CGPointMake(0, 0);
    
    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width - 100)/2, label.bottom + 20, 100, 20)];
    likeButton.backgroundColor = [UIColor redColor];
    [likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [likeButton setTitle: @"想你了" forState: UIControlStateNormal];
    [likeButton.layer setMasksToBounds:YES];
    [likeButton.layer setCornerRadius:3]; //设置矩形四个圆角半径
    //    [self.view addSubview:likeButton];

    
    self.heartsEmitter = [CAEmitterLayer layer];
    self.heartsEmitter.emitterPosition =  CGPointMake(likeButton.frame.origin.x + likeButton.frame.size.width/2.0 , self.view.frame.size.height);
    self.heartsEmitter.emitterSize = likeButton.bounds.size;
    self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
    self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
    self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    heart.emissionLongitude = M_PI/2.0;
    heart.emissionRange = 0.55 * M_PI;
    heart.birthRate		= 0.0;
    heart.lifetime		= 10.0;
    heart.velocity		= -120;
    heart.velocityRange = 60;
    heart.yAcceleration = 10;
    heart.contents		= (id) [[UIImage imageNamed:@"PooHeart"] CGImage];
    heart.color			= [[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
    heart.redRange		= 0.3;
    heart.blueRange		= 0.3;
    heart.alphaSpeed	= -0.5 / heart.lifetime;
    heart.scale			= 0.15;
    heart.scaleSpeed	= 0.5;
    heart.spinRange		= 2.0 * M_PI;
    
    self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
    [self.view.layer addSublayer:heartsEmitter];
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    _meImage.hidden = NO ;
    _meImage.center = touchPoint ;
    
    [self compareTouchPoint:touchPoint];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
//    NSLog(@"touchesMoved %f == %f" , touchPoint.x , touchPoint.y);
    
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text = NSStringFromCGPoint(touchPoint);
    
    NSString *reciever = @"" ;
    if ([self.account isEqualToString:@"kk"]) {
        reciever = @"xl" ;
    }else{
        reciever = @"kk" ;
    }

    NIMSession *session = [NIMSession session:reciever type:NIMSessionTypeP2P];
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
    
    [self compareTouchPoint:touchPoint];
    
}

- (void) compareTouchPoint :(CGPoint) begin {
//    NSLog(@"begin %@" , NSStringFromCGPoint(begin));
//    NSLog(@"locaiton %@" , NSStringFromCGPoint(locaiton));

    NSLog(@"wayway %d" , [self farwayFromTwoPoints:begin andWith:locaiton]);
    
    if ([self farwayFromTwoPoints:begin andWith:locaiton] >=0 &&
            [self farwayFromTwoPoints:begin andWith:locaiton] < 50) {
//        self.view.backgroundColor = [UIColor redColor];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self showLove];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        locaiton = CGPointMake(0, 0);
    }
}

-(int) farwayFromTwoPoints :(CGPoint) point1 andWith:(CGPoint) point2{
    return sqrt(pow( point1.x - point2.x ,2)+pow(point1.y-point2.y , 2 ));
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _meImage.hidden = YES ;
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text = @"finish";
    
    NSString *reciever = @"" ;
    if ([self.account isEqualToString:@"test"]) {
        reciever = @"xl" ;
    }else{
        reciever = @"test" ;
    }
    
    NIMSession *session = [NIMSession session:reciever type:NIMSessionTypeP2P];
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
    
}



#pragma mark -- Send Message Delegate
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    NSLog(@"message :%@" , message) ;
}

- (void)onRecvMessages:(NSArray *)messages{
    for(NIMMessage *message in messages){
        if ([message.text isEqualToString:@"finish"]) {
            _missImage.hidden = YES ;
            label.text = @"" ;
            self.view.backgroundColor = [UIColor whiteColor];
            locaiton = CGPointMake(0, 0);
        }else{
            CGPoint otherPoint = CGPointFromString(message.text);
            locaiton = otherPoint ;
            NSString *msg = @"我想你了" ;

            if ([self.account isEqualToString:@"test"]) {
                msg = @"Pumpkin , 我想你了" ;
            }
            
            label.text = msg ;
            _missImage.center = otherPoint ;
            _missImage.hidden = NO ;
        }
    }
}


@end
