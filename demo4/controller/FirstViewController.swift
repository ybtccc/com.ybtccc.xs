//
//  FirstViewController.swift
//  demo4
//
//  Created by ybtccc on 2018/12/16.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SBPullToRefresh

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cellIdentifier = "xiaoshuo"
    var moreList :[Xiaoshuo]! = []
    var page = 1
    var userId = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.es.addPullToRefresh { [unowned self] in
            /// 在这里做刷新相关事件
            self.refresh(isRefresh : true)
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
            self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
//        self.tableView.es.addInfiniteScrolling {
//            [unowned self] in
//            /// 在这里做加载更多相关事件
//            self.refresh()
//            self.tableView.es.stopLoadingMore()
//            self.tableView.es.noticeNoMoreData()
//        }
        self.login()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        print("first controller 初始化完成")
        // Do any additional setup after loading the view.
    }
    
    func login(){
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        print("uuid:"+(uuid ?? " "))
        HttpClientUtil.get(url: "http://api.ybtccc.com/register?uuid="+uuid!,callback: { (resp:User?)in
            if(resp != nil){
                self.userId = resp!.id ?? 0
                self.refresh()
            }
        })
    }
    
    func refresh(isRefresh:Bool = false){
        if(isRefresh){
            self.page = 1
        }
        print("page",self.page)
        HttpClientUtil.getList(url: "http://api.ybtccc.com/farvirate?userId="+String(self.userId),callback: { (resp:[Xiaoshuo]?)in
            if(resp != nil){
                if(isRefresh){
                    self.moreList = resp
                }else{
                    self.moreList = self.moreList + resp!
                }
                self.page += 1
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        cell?.detailTextLabel?.textColor = UIColor.gray
        
        let item = moreList[indexPath.row]
        let img_url = item.img?.removingPercentEncoding
        cell?.imageView?.af_setImage(withURL: URL(string: img_url!)!,placeholderImage:UIImage(named: "default"))
        cell?.textLabel?.text = (item.name!)
        cell?.detailTextLabel?.text = (item.author!)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        print(cell?.textLabel?.text ?? "nil")
        let detail:DetailViewController = UIStoryboard(name: "Detail",bundle: nil).instantiateInitialViewController() as! DetailViewController
        detail.xiaoshuo = self.moreList[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
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
