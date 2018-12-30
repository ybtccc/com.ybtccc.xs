//
//  DateUtil.swift
//  demo4
//
//  Created by ybtccc on 2018/12/17.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import Foundation

class DateUtil{
    static func format(date :Date = Date(),format :String = "yyy-MM-dd HH:mm:ss") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: date)
        return str
    }
    
    static func parse(str :String,format :String = "yyy-MM-dd HH:mm:ss") -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: str)
        return date!
    }
}
