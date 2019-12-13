//
//  ViewController.m
//  imissu
//
//  Created by long-laptop on 16/3/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Addition.h"
#import "APIClient.h"
#import "NIMSDK.h"
#import "WebUIViewController.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@class CAEmitterLayer;

@interface ViewController (){
    UITextView *textViewPlaceholder ;
    UIButton *likeButton2 ;
    NSString *from ;
}
@property (nonatomic, strong) UIButton *likeButton;
@property (strong)			CAEmitterLayer	*heartsEmitter;
@end

@implementation ViewController
@synthesize likeButton;
@synthesize heartsEmitter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES ;
    
    textViewPlaceholder=[[UITextView alloc]initWithFrame:CGRectMake(20,100,kScreen_Width -40,100)];
    
    textViewPlaceholder.backgroundColor=[UIColor whiteColor];
    
    textViewPlaceholder.text=@"说出你想跟我说的话吧!";
    
    textViewPlaceholder.textColor=[UIColor grayColor];
    
    textViewPlaceholder.delegate= self;
    
    textViewPlaceholder.layer.borderColor = [UIColor grayColor].CGColor;
    
    textViewPlaceholder.layer.borderWidth =1.0;
    
    textViewPlaceholder.layer.cornerRadius =5.0;
    
//    [self.view addSubview:textViewPlaceholder];

    
    
    likeButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width - 100)/2, textViewPlaceholder.bottom + 20, 100, 20)];
    likeButton.backgroundColor = [UIColor redColor];
    [likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [likeButton setTitle: @"想你了" forState: UIControlStateNormal];
    [likeButton.layer setMasksToBounds:YES];
    [likeButton.layer setCornerRadius:3]; //设置矩形四个圆角半径
//    [self.view addSubview:likeButton];
    
    likeButton2 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width - 100)/2, likeButton.bottom + 40, 100, 40)];
    likeButton2.backgroundColor = [UIColor grayColor];
    [likeButton2 addTarget:self action:@selector(gotoTouch) forControlEvents:UIControlEventTouchUpInside];
    [likeButton2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [likeButton2.layer setMasksToBounds:YES];
    [likeButton2.layer setCornerRadius:3]; //设置矩形四个圆角半径
    [likeButton2 setTitle: @"试试" forState: UIControlStateNormal];
    [self.view addSubview:likeButton2];
    
    UIButton *likeButton3 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width - 100)/2, likeButton2.bottom + 20, 100, 20)];
    likeButton3.backgroundColor = [UIColor purpleColor];
    [likeButton3 addTarget:self action:@selector(gotoWeb) forControlEvents:UIControlEventTouchUpInside];
    [likeButton3.layer setMasksToBounds:YES];
    [likeButton3.layer setCornerRadius:3]; //设置矩形四个圆角半径
    [likeButton3 setTitle: @"Tell Me" forState: UIControlStateNormal];
//    [self.view addSubview:likeButton3];

    
    self.heartsEmitter = [CAEmitterLayer layer];
    self.heartsEmitter.emitterPosition = CGPointMake(likeButton.frame.origin.x + likeButton.frame.size.width/2.0 , self.view.frame.size.height);
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

-(void)gotoWeb{
    WebUIViewController *view = [[WebUIViewController alloc] init];
    
    [self.navigationController pushViewController:view animated:YES];
}

//获得设备型号
- (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

-(void)gotoTouch{
    likeButton2.backgroundColor = [UIColor orangeColor];
    NSString *registerId = [JPUSHService registrationID] ;
    NSString *acount = @"";
    NSString *type = @"" ;
    NSString *model = [self getCurrentDeviceModel] ;
    NSString *token = @"123456" ;
    if ([@"iPhone6s" isEqualToString: model]) {
//        registerId = @"121c83f760270f1338b" ;
        acount = @"xl" ;
        type = @"nan" ;
    }else{
//        registerId = @"191e35f7e0460c9e127" ;
        acount = @"kk" ;
        type = @"nv" ;
    }
    
    [self sendPushHeartWithRegisterId:registerId AndWithMessage:@"Center Room , Touch And Feel!"];
    
    [[[NIMSDK sharedSDK] loginManager]
     login:acount token:token completion:^(NSError *error) {
            NSLog(@"error : %@" , error) ;
            TouchEachOtherViewController *touch
                                = [[TouchEachOtherViewController alloc] init];
            touch.type = type ;
            touch.account = acount ;
            [self.navigationController pushViewController:touch animated:YES];
    }];
    
}

- (void)viewWillUnload
{
    [super viewWillUnload];
    [self.heartsEmitter removeFromSuperlayer];
    self.heartsEmitter = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLove) name:@"showLove" object:nil];
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

-(void)buttonClick : (UIButton *)sender{
    [sender setBackgroundColor:[UIColor grayColor]];
}

- (void)likeButtonPressed:(UIButton *)sender
{
    likeButton.backgroundColor = [UIColor redColor];

    NSString *registerId = [JPUSHService registrationID] ;
    NSString *message = @"Pumpkin , i miss u so much!" ;
    from = @"1" ;
    if ([@"191e35f7e0460c9e127" isEqualToString: registerId]) {
        registerId = @"121c83f760270f1338b" ;
        message = @"Pumpkin , i miss u so much !" ;
        from =  @"1" ;
    }else{
        registerId = @"191e35f7e0460c9e127" ;
        message = @"i'm thiking of u , what r u doing?" ;
        from = @"2" ;
    }
    
    if (nil != textViewPlaceholder.text&&![textViewPlaceholder.text isEqualToString:@"说出你想跟我说的话吧!"]) {
        message = textViewPlaceholder.text ;
    }
    
    [self sendPushHeartWithRegisterId:registerId AndWithMessage:message];
}


-(void) sendPushHeartWithRegisterId : (NSString *) registerId AndWithMessage :(NSString *)message{
    
    APIClient *client = [APIClient sharedJsonClient];
    NSString *pushHeart = [NSString stringWithFormat:@"http://loltube.cn/jpush?title=%@&message=%@&id=%@" , from , message ,registerId];
    [client requestJsonDataWithPath:pushHeart withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        NSLog(@"%@" , data);
    }];
}

@end
