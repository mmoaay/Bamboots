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
        loadCustom(NSObject())
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
        let load = LoadConfig(container: view, mask:MBEyeLoading(), inset: UIEdgeInsetsMake(30+64, 15, UIScreen.main.bounds.height-64-(44*4+30+15*3), 15))
        request(WeatherForm()).load(load:load)
    }
    
    @IBAction func loadViewController(_ sender: AnyObject) {
        request(WeatherForm()).load(load:MBLoadType.default(container: view))
    }
    
    @IBAction func loadNavigationController(_ sender: AnyObject) {
        request(WeatherForm()).load(load: MBLoadType.default(container: navigationController!.view))
    }
    
    @IBAction func loadButton(_ sender: AnyObject) {
        request(WeatherForm()).load(load: button)
    }
}
