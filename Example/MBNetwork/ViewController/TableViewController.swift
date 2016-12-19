//
//  ViewController.swift
//  MBNetwork
//
//  Created by mmoaay on 07/06/2016.
//  Copyright (c) 2016 mmoaay. All rights reserved.
//

import UIKit
import MBNetwork

extension TableViewController{
    fileprivate func initTableView() {
        let tableHeaderView = MBTableHeaderView.shared.getView()
        tableHeaderView?.frame = CGRect(x: 0, y: 0, width: SCREEN_SIZE.width, height: SCREEN_SIZE.width)
        tableView.tableHeaderView = tableHeaderView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = String(format: "Cell %d", indexPath.row)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(format: "Section %d", section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath)
        request(BaiduGeoCoderForm(), load:MBLoadType.default(container: cell!))
    }
}

class TableViewController: UITableViewController, MBRequestable{
    
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
        
        let load = MBLoadConfig(container:self.tableView, inset: UIEdgeInsetsMake(SCREEN_SIZE.width - self.tableView.contentOffset.y > 0 ? SCREEN_SIZE.width - self.tableView.contentOffset.y : 0, 0, 0, 0))
        request(BaiduGeoCoderForm(), load: load)
        
        // 遮罩 NavigationController 的加载
//        request(BaiduGeoCoderForm(), load: MBLoadType.default(container: self.navigationController!.view))
        
        // 遮罩 ViewController 的加载
//        request(BaiduGeoCoderForm(), load:MBLoadType.default(container: view))
        
        // 没有加载
//        request(BaiduGeoCoderForm())
        
        // 自定义加载
//        let load = MBLoadConfig(container: self.view, inset: UIEdgeInsetsMake(100, 0, 0, 0))
//        request(BaiduGeoCoderForm(), load: loadButton)
    }
}

