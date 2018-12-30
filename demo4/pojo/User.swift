//
//  User.swift
//  demo4
//
//  Created by ybtccc on 2018/12/23.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import Foundation
import HandyJSON

class User :HandyJSON{
    
    var id:Int?
    var name:String?
    var uuid:String?
    var create_time:Date?
        required init(){}
}
