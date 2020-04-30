//
//  Dam.swift
//  Niveles de Embalses
//
//  Created by JRo....... on 9/14/15.
//  Copyright (c) 2015 Javier Rosado. All rights reserved.
//
import UIKit
import Foundation

class Dam {
    var dam: String?
    var dif: String?
    var average: String?
    var optimun: String?
    init(damData: [String: AnyObject]) {
        if let n = damData["damName"] as? String {
            dam = n
        }
        if let a = damData["difference"] as? String {
            dif = a
        }
        if let p = damData["average"] as? String {
            average = p
        }
        if let o = damData["optimun"] as? String {
            optimun = o
        }
    }
    
    var damColor: UIColor {
        if dam == "sell" {
            return UIColor.blackColor()
        }
        return UIColor.whiteColor()
    }
    
    var difLabelBgColor: UIColor {
        var result:UIColor = UIColor(red: 0.22, green: 0.33, blue: 0.53, alpha: 1.0)
        if difValue() == 1 {
            result =  UIColor.greenColor()
        } else if difValue() == 2 {
            result = UIColor.redColor()
        }
        return result
    }
    
    var difLabeltextColor: UIColor {
        if difValue() == 1 {
            return UIColor.grayColor()
        } else if difValue() == 2 {
            return UIColor.whiteColor()
        }
        return UIColor.whiteColor()
    }
    
    func difValue ()-> Int{
        let text = dif!.stringByReplacingOccurrencesOfString("Diferencia: ", withString: "")
        let la = (String(stringInterpolationSegment: text) as NSString).floatValue
        var result: Int
        if la > 0 {
            result = 1
        }else if la < 0 {
            result = 2
        }else{
            result = 3
        }
        return result
    }

}
