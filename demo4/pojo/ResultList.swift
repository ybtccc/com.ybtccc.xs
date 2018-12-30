//
//  ResultList.swift
//  demo4
//
//  Created by ybtccc on 2018/12/22.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import Foundation
import HandyJSON

class ResultList<T: HandyJSON>: HandyJSON {
    var code: String? // 服务端返回码
    var msg:String?
    var data: [T]? // 具体的data的格式和业务相关，故用泛型定义
    
    public required init() {}
}
