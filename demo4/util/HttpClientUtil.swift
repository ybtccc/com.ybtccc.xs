//
//  HttpClientUtil.swift
//  demo4
//
//  Created by ybtccc on 2018/12/19.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import Toast_Swift

class HttpClientUtil{
    
    static func get<T :HandyJSON>(url :String,callback : @escaping(T?)->Void){
        Alamofire.request(url).responseData { response in
            if response.result.isSuccess {
                if let data = response.result.value,let utf8Text = String(data: data, encoding: .utf8) {
                    if let responseModel = Result<T>.deserialize(from: utf8Text) {
                        if(responseModel.code == "00"){
                            callback(responseModel.data)
                        }else{
                            print(responseModel.msg ?? "接口出错了")
                        }
                    }
                }
            }else{
                print("网络错误")
            }

        }
    }
    
    static func getList<T :HandyJSON>(url :String,callback : @escaping([T]?)->Void){
        Alamofire.request(url).responseData { response in
            if response.result.isSuccess {
                if let data = response.result.value,let utf8Text = String(data: data, encoding: .utf8) {
                    if let responseModel = ResultList<T>.deserialize(from: utf8Text) {
                        if(responseModel.code == "00"){
                            callback(responseModel.data)
                        }else{
                            print(responseModel.msg ?? "接口出错了")
                        }
                    }
                }
            }else{
                print("网络错误")
            }
            
        }
    }
}
