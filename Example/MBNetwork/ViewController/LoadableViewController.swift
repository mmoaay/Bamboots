//
//  LoadableViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 19/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork

class LoadableViewController: UIViewController, MBRequestable {
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loadCustom(_ sender: AnyObject) {
        let load = MBLoadConfig(container: self.view, inset: UIEdgeInsetsMake(200, 0, 0, 0))
        request(BaiduGeoCoderForm(), load: load)
    }
    
    @IBAction func loadDefault(_ sender: AnyObject) {
        request(BaiduGeoCoderForm(), load:MBLoadType.default(container: view))
    }
    
    @IBAction func loadNav(_ sender: AnyObject) {
        request(BaiduGeoCoderForm(), load: MBLoadType.default(container: self.navigationController!.view))
        request(BaiduGeoCoderForm(), load:MBLoadType.none)
    }
    
    @IBAction func loadButton(_ sender: AnyObject) {
        request(BaiduGeoCoderForm(), load: button)
    }
}
