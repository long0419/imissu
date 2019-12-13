//
//  TouchEachOtherViewController.h
//  imissu
//
//  Created by long-laptop on 16/3/13.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMSDK.h"
#import "AudioToolbox/AudioToolbox.h"
@class CAEmitterLayer;

@interface TouchEachOtherViewController : UIViewController <NIMChatManagerDelegate>

@property (nonatomic , strong) NSString *type ;
@property (nonatomic , strong) NSString *account ;

@property (nonatomic , strong) UIImageView *meImage ;
@property (nonatomic , strong) UIImageView *missImage ;
@property (strong)			CAEmitterLayer	*heartsEmitter;

@end
