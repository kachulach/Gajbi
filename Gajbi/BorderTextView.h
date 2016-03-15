//
//  BorderTextView.h
//  TelegrafMK
//
//  Created by Ljupco J on 10/1/15.
//  Copyright © 2015 Nextsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorderTextView : UITextView

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable NSString *placeholder;

@end
