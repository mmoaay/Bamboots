//
//  LoadableTableViewController.swift
//  MBNetwork
//
//  Created by mmoaay on 07/06/2016.
//  Copyright (c) 2016 mmoaay. All rights reserved.
//

import UIKit
import MBNetwork

extension LoadableTableViewController{
    fileprivate func initTableView() {
        let tableHeaderView = TableHeaderView.shared.getView()
        tableHeaderView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        tableView.tableHeaderView = tableHeaderView
        
        refresh.attributedTitle = NSAttributedString(string: "Loadable UIRefreshControl")
        refresh.addTarget(self, action: #selector(LoadableTableViewController.refresh(refresh:)), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    func refresh(refresh: UIRefreshControl) {
        request(WeatherForm()).load(load: refresh)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadableCell", for: indexPath)
        cell.textLabel?.text = String(format: "Show mask on UITableViewCell", indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath)
        request(WeatherForm()).load(load: cell!)
    }
}

class LoadableTableViewController: UITableViewController, MBRequestable{

    let refresh = UIRefreshControl()
    
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
        let load = LoadConfig(container:self.tableView, mask: MBActivityIndicator(), inset: UIEdgeInsetsMake(UIScreen.main.bounds.width - self.tableView.contentOffset.y > 0 ? UIScreen.main.bounds.width - self.tableView.contentOffset.y : 0, 0, 0, 0))
        request(WeatherForm()).load(load: load)
    }
}

