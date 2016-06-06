//
//  ViewController.m
//  MyUIButton
//
//  Created by William-Weng on 2016/6/3.
//  Copyright © 2016年 William-Weng. All rights reserved.
//

#import "ViewController.h"
#import "MyUIButton.h"

@interface ViewController () {
    NSMutableDictionary *myUIButtonDic, *boomDic;
    NSInteger level, levelMax ,boomCount, saveCount, mapCount;
    UISwitch *mySwitch;
    CGRect screenRect;
}

-(void)produceBoom:(NSInteger)count;
-(void)produceMap:(NSInteger)count;
-(void)produceSwitch;
-(void)setBoom;
-(void)removeAllButton;
-(void)gameOver;
-(void)clearGame;
-(void)calculateBoom:(MyUIButton *)button;
-(void)switchOn:(MyUIButton *)button;
-(void)switchOff:(MyUIButton *)button;
-(NSInteger)calculateCount:(MyUIButton *)button;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    screenRect = [[UIScreen mainScreen] bounds];
    levelMax = 9;
    level = 1;
    
    [self produceBoom:(level+2)];
    [self produceMap:(level+2)];
    [self produceSwitch];
    [self setBoom];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//--------------------myFunction----------------------//

-(void)produceMap:(NSInteger)count {
    
    NSInteger rowCounts = count;
    NSInteger rowGap = 5;
    NSInteger startX = rowGap;
    NSInteger startY = 20;
    
    myUIButtonDic = [[NSMutableDictionary alloc] init];
    
    CGFloat blockWidth = (screenRect.size.width - (rowCounts+1)*rowGap)/rowCounts;
    
    for (int y=0; y<rowCounts; y++) {
        for (int x=0; x<rowCounts; x++) {
            
            Coordinate coordinate;
            coordinate.x = x;
            coordinate.y = y;
            
            MyUIButton *btn = [MyUIButton buttonFactory:CGRectMake(startX + (rowGap+blockWidth)*x, startY +(rowGap+blockWidth)*y, blockWidth, blockWidth) Color:(x%2)?[UIColor redColor]:[UIColor grayColor] Coordinate:coordinate titleFontSize:blockWidth * 0.8];
            
            [myUIButtonDic setValue:btn forKey:[NSString stringWithFormat:@"(%d,%d)",btn.coordinate.x,btn.coordinate.y]];
            [btn addTarget:self action:@selector(calculateBoom:) forControlEvents:UIControlEventTouchDown];
            
            [self.view addSubview:btn];
        }
        
        mapCount = [myUIButtonDic count];
    }
}

-(void)produceSwitch {
    mySwitch = [[UISwitch alloc] init];
    [mySwitch setFrame:CGRectMake(screenRect.size.width/2 - mySwitch.frame.size.width/2, screenRect.size.width + (screenRect.size.height - screenRect.size.width)/2, 0, 0)];
    mySwitch.transform = CGAffineTransformMakeScale(2, 2);
    
    mySwitch.on = YES;
    [self.view addSubview:mySwitch];
}

-(void)produceBoom:(NSInteger)count {
    
    boomDic = [[NSMutableDictionary alloc] init];
    boomCount = count;
    
    while (boomDic.count < count) {
        int x = arc4random()%count;
        int y = arc4random()%count;
        
        [boomDic setValue:@(9) forKey:[NSString stringWithFormat:@"(%d,%d)",x,y]];
        NSLog(@"%@",boomDic);
    }
}

-(void)setBoom{
    NSArray *boomKeys = [boomDic allKeys];
    
    for (NSString *boomKey in boomKeys) {
        [myUIButtonDic[boomKey] setIsBoom:YES];
    }
}

-(void)removeAllButton {
    NSArray *myUIButtonKeys = [myUIButtonDic allKeys];
    
    for (NSString *myUIButtonKey in myUIButtonKeys) {
        [myUIButtonDic[myUIButtonKey] removeFromSuperview];
    }
}

-(void)gameOver {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"GameOver" message:@"你踏到地雷了XD" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再試一次吧" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)clearGame {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ClearGame" message:@"果然是高手…" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下一關…" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)calculateBoom:(MyUIButton *)button {
    if (mySwitch.on) {
        [self switchOn:button];
    } else {
        [self switchOff:button];
    }
}

-(void)switchOn:(MyUIButton *)button {
    NSInteger count = 0;
    
    if (button.title.length == 0 && button.isBoom) {
        [self gameOver];
    } else {
        count = [self calculateCount:button];
        
        if (button.title.length == 0) {
            saveCount += 1;
            button.title = [NSString stringWithFormat:@"%ld",(long)count];
            [button setTitle:button.title forState:UIControlStateNormal];
        }
        
    }
    
    if (saveCount + boomCount == mapCount) {
        [self clearGame];
        [self removeAllButton];
        
        saveCount = 0;
        boomCount = 0;
        level += 1;
        
        if (level >= levelMax) {
            level = levelMax;
        }
        
        [self produceBoom:(level+2)];
        [self produceMap:(level+2)];
        [self setBoom];
    }
}

-(void)switchOff:(MyUIButton *)button {
    
    if ([button.title isEqualToString:@""]) {
        button.title = [NSString stringWithFormat:@"%@",@"?"];
    } else if ([button.title isEqualToString:@"?"]) {
        button.title = [NSString stringWithFormat:@"%@",@""];
    }
    
    [button setTitle:button.title forState:UIControlStateNormal];
}

-(NSInteger)calculateCount:(MyUIButton *)button {
    NSInteger nearBoomCount = 0;
    Coordinate coordinate = button.coordinate;
    
    for (int x=(coordinate.x-1); x<=(coordinate.x+1); x++) {
        for (int y=(coordinate.y-1); y<=(coordinate.y+1); y++) {
            NSString *coordinateStr = [NSString stringWithFormat:@"(%d,%d)",x,y];
            if([myUIButtonDic[coordinateStr] isBoom]) {
                nearBoomCount += 1;
            }
        }
    }
    
    return nearBoomCount;
}

@end
