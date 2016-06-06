//
//  MyUIButton.m
//  MyUIButton
//
//  Created by William-Weng on 2016/6/3.
//  Copyright © 2016年 William-Weng. All rights reserved.
//

#import "MyUIButton.h"

@implementation MyUIButton

+(MyUIButton *)buttonFactory:(CGRect)rect Color:(UIColor*)color Coordinate:(Coordinate)coordinate titleFontSize:(NSInteger)size {
    
    MyUIButton *button = [[MyUIButton alloc]initWithFrame:rect];
    
    button.backgroundColor = color;
    button.coordinate = coordinate;
    button.isBoom = NO;
    button.title = @"";
    
    button.titleLabel.font = [UIFont systemFontOfSize:size];

    return button;
}

@end
