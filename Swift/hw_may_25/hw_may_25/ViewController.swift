//
//  ViewController.swift
//  hw_may_25
//
//  Created by user22 on 2016/5/24.
//  Copyright © 2016年 user22. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1、九九乘法表
        print("\n1、九九乘法表：")
        for x in 1...9{
            for y in 1...9{
                print("\(x)x\(y)=\(x*y>9 ?"" :" ")\(x*y)",terminator:" ")
            }
            print()
        }
        
        // 2、聖誕樹
        print("\n2、聖誕樹：")
        let lines = 10
        
        for n in 1...lines {
            
            for _ in 1..<(lines-n+1) { // 印空白…
                print(" ",terminator:"")
            }
            
            for _ in 1...(2*n-1){ // 印星星…
                print("*",terminator:"")
            }
            
            print()
        }

        // 3、1+2+3+…+99+100
        print("\n3、1+2+3+…+99+100：")
        var ans=0
        for i in 1...100{
            ans+=i
        }
        print(ans)
        
        
        // 4、補助
        print("\n4、補助：")
        let old = arc4random_uniform(100)
        
        switch old {
        case 18...29:
            print(old,"歲 ==> 可以有補助 >.<")
        case 65...74:
            print(old,"歲 ==> 可以有補助 >.<")
        default:
            print(old,"歲 ==> 要自己繳錢 T.T")
        }
        
        // 5、尋找非質數
        print("\n5、尋找非質數：")
        
        let numberStart = 167
        let numberEnd = 1987
        
        for no in numberStart...numberEnd{
            if(ViewController.isNotPrime(number: no)){
                print(no)
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    class func isNotPrime ( number target: Int ) -> Bool
    {
        var divisor = 2
        
        if target < 2 { // 1跟2是質數…
            return true
        }

        while divisor < (target/2)  { // 就除到自己的一半就結束了(∵number = 2 * number/2)
            if target % divisor == 0 { // 除的盡就不是質數
                return true
            }
            divisor += 1
        }
        return false
    }
}
