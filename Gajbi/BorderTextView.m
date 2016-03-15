//
//  BorderTextView.m
//  TelegrafMK
//
//  Created by Ljupco J on 10/1/15.
//  Copyright © 2015 Nextsense. All rights reserved.
//

#import "BorderTextView.h"

@interface BorderTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation BorderTextView

-(void)textChange:(NSNotification *)notification {
    if([self hasText]) {
        self.placeholderLabel.alpha = 0;
    } else {
        self.placeholderLabel.alpha = 1;
    }
}

- (void)drawRect:(CGRect)rect {
    self.layer.borderColor = [self.borderColor CGColor];
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius = 5;
    
    if(self.placeholder && !self.placeholderLabel) {
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1, rect.size.width - 8, 30)];
        [self.placeholderLabel setFont:[UIFont systemFontOfSize:14]];
        [self.placeholderLabel setText:self.placeholder];
        [self.placeholderLabel setTextColor:[UIColor grayColor]];
        [self addSubview:self.placeholderLabel];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
}

static NSString *empty = @"";
-(void)setText:(NSString *)text{
    [super setText:text];
    if([text isEqualToString:empty]){
        self.placeholderLabel.alpha = 1;
    }
}

@end
