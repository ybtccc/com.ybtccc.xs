//
//  DetailViewController.swift
//  demo4
//
//  Created by ybtccc on 2018/12/17.
//  Copyright © 2018 ybtccc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    var xiaoshuo:Xiaoshuo!
    
    @IBOutlet weak var panal: UIVisualEffectView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var submit: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
//    @IBOutlet weak var content: UITextView!
    var page = 1
    var moreList :[Chapter]! = []
    var cellIdentifier = "chapter"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.img.af_setImage(withURL: URL(string: self.xiaoshuo.img!)!,placeholderImage:UIImage(named: "default"))
        self.bgView.af_setImage(withURL: URL(string: self.xiaoshuo.img!)!,placeholderImage:UIImage(named: "default"))
        self.name.text = self.xiaoshuo.name
        self.author.text = self.xiaoshuo.author
        self.submit.text = self.xiaoshuo.submit_time
        self.summary.text = self.xiaoshuo.summary
//        print(self.content.text,self.xiaoshuo.summary ?? " nil")
        
        self.panal.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        self.panal.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.tableView.es.addPullToRefresh { [unowned self] in
            /// 在这里做刷新相关事件
            self.refresh(isRefresh : true)
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
            self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
        self.refresh()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        print("detail init")
        // Do any additional setup after loading the view.
    }
    
    
    func refresh(isRefresh:Bool = false){
        if(isRefresh){
            self.page = 1
        }
        print("page",self.page)
        HttpClientUtil.getList(url: "http://api.ybtccc.com/chapter?xiaoshuoId="+String(self.xiaoshuo.id!),callback: { (resp:[Chapter]?)in
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
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
        }
        cell?.detailTextLabel?.textColor = UIColor.gray
        
        let item = moreList[indexPath.row]
        cell?.textLabel?.text = (item.name!)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        print(cell?.textLabel?.text ?? "nil")
        let detail:ReadViewController = UIStoryboard(name: "Read",bundle: nil).instantiateInitialViewController() as! ReadViewController
        detail.chapter = moreList[indexPath.row]
        detail.title = cell?.textLabel?.text
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
