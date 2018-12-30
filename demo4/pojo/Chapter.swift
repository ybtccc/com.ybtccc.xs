//
//  Chapter.swift
//  demo4
//
//  Created by ybtccc on 2018/12/23.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import Foundation
import HandyJSON

class Chapter:HandyJSON{

    var id:Int?
    var sort:Int64?
    var name:String?
    var create_time:Date?
    var update_time:Date?
    required init(){}
}
