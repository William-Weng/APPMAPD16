//
//  main.m
//  0526_Homework
//
//  Created by user22 on 2016/5/26.
//  Copyright © 2016年 user22. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 1、九九乘法表
        printf("%s","1、九九乘法表：\n");
        for(int j=1;j<=9;j++){
            for(int i=1;i<=9;i++){
                printf("%d*%d=%2d ",j,i,i*j);
            }
            printf("\n");
        }
        
        // 2、1+2+3+…+98+99+100
        printf("%s","\n2、1+2+3+…+98+99+100：\n");
        int ans=0;
        for(int i=1;i<=100;i++){
            ans+=i;
        }
        printf("%d\n",ans);
        
        // 3、聖誕樹
        printf("%s","\n3、聖誕樹：\n");
        int lines = 10;
        
        for(int i=1;i<lines;i++) {
            
            for(int j=1;j<lines-i;j++) { // 印空白…
                printf(" ");
            }
            
            for(int j=0;j<(2*i-1);j++){ // 印星星…
                printf("*");
            }
            printf("\n");
        }
    }
    return 0;
}