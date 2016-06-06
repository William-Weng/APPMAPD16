//
//  MyUIButton.h
//  MyUIButton
//
//  Created by William-Weng on 2016/6/3.
//  Copyright © 2016年 William-Weng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct _coordinate {
    int x;
    int y;
} Coordinate;

@interface MyUIButton : UIButton

@property Coordinate coordinate;
@property NSString *title;
@property Boolean isBoom;

+(MyUIButton *)buttonFactory:(CGRect)rect Color:(UIColor*)color Coordinate:(Coordinate)xy titleFontSize:(NSInteger)size;
@end
