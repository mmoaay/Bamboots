//
//  ViewController.swift
//  MBNetwork
//
//  Created by mmoaay on 07/06/2016.
//  Copyright (c) 2016 mmoaay. All rights reserved.
//

import UIKit
import MBNetwork

extension ViewController {
    fileprivate func initTableView() {
        let tableHeaderView = MBTableHeaderView.shared.getView()
        tableHeaderView?.frame = CGRect(x: 0, y: 0, width: SCREEN_SIZE.width, height: SCREEN_SIZE.width)
        self.tableView.tableHeaderView = tableHeaderView

        tableView.parallelHeaderView = headerImage
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(format: "Section %d", section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier : String = "cellIdentifier"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = String(format: "Cell %d", indexPath.row)
        cell?.detailTextLabel?.text = "Watch out!!! Something AWESOME is coming~~~"
        return cell!
    }
}

class ViewController: UIViewController, MBRequestable{
    
//    var loading: UIView = UIView()
    @IBOutlet weak var tableView: MBParallelHeaderTableView!
    @IBOutlet weak var headerImage: UIImageView!
    
    let SCREEN_SIZE = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func load(_ sender: AnyObject) {
        
        // 遮罩 NavigationController 的加载
//        send(BaiduGeoCoderForm(), load: MBLoadType.Default(container: self.navigationController!.view))
        // 遮罩 ViewController 的加载
//        send(BaiduGeoCoderForm(), load:MBLoadType.default(container: view))
        
        // 没有加载
//        send(BaiduGeoCoderForm())
        
        // 自定义加载
        let load = MBLoadConfig(id: "LOAD_CUSTOM", mask: MBLoading.loading(), container: self.view, insets: UIEdgeInsetsMake(100, 0, 0, 0))
        send(BaiduGeoCoderForm(), load: load)
    }
    
    @IBAction func loadTable(_ sender: AnyObject) {
        let load = MBLoadConfig(id:"LOAD_TABLE", container:self.tableView, insets: UIEdgeInsetsMake(SCREEN_SIZE.width - self.tableView.contentOffset.y > 0 ? SCREEN_SIZE.width - self.tableView.contentOffset.y : 0, 0, 0, 0))
        send(BaiduGeoCoderForm(), load: load)
        send(BaiduGeoCoderForm(), load: load)
    }
}

