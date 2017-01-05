//
//  InformableViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 05/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork

class InformableViewController: UIViewController, MBRequestable {

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

    @IBAction func load(_ sender: Any) {
        request(WeatherForm()).inform(error: WeatherInformError(), inform: MBMessageType.alertController(title: "Notice", message: "Load successfully", actions: [UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)], container: self))
    }
}
