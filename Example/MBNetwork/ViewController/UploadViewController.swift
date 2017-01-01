//
//  UploadViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 01/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork
import AlamofireObjectMapper
import Alamofire

class UploadViewController: UIViewController, MBRequestable {

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

    @IBAction func uploadPressed(_ sender: Any) {
        self.upload(UploadForm(), load: MBLoadType.default(container: self), error:MBBaseError(), alert:MBAlertType.alertController(container: self)) { (response:DataResponse<WeatherResponse>) in
        }
    }
}
