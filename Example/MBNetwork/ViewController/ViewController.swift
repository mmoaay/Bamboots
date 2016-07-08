//
//  ViewController.swift
//  MBNetwork
//
//  Created by mmoaay on 07/06/2016.
//  Copyright (c) 2016 mmoaay. All rights reserved.
//

import UIKit
import MBNetwork

class ViewController: UIViewController, MBRequestable, MBLoadable{
    
//    var loading: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func load(sender: AnyObject) {
        send(BaiduGeoCoderForm(), loadType: .DEFAULT)
    }
}

