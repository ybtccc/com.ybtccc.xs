//
//  ReadViewController.swift
//  demo4
//
//  Created by ybtccc on 2018/12/23.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import UIKit
import WebKit


class ReadViewController: UIViewController {

    var chapter:Chapter!
    var content:Content?
    var template:String = "<!DOCTYPE html><html><head><title></title><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'></head><body>{{content}}</body></html>"
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    
        // Do any additional setup after loading the view.
    }
    
    func refresh(){
        HttpClientUtil.get(url: "http://api.ybtccc.com/content?chapterId="+String(self.chapter.id!),callback: { (resp:Content?)in
            self.content = resp
            let val = self.template.replacingOccurrences(of: "{{content}}", with: (self.content?.content ?? "随便看看"))
            self.webview.loadHTMLString(val, baseURL: nil)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
