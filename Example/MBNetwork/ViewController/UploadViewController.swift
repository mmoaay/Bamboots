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
    @IBOutlet var button: UIButton!

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
        let alert = UIAlertController(title: "Notice", message: "Upload successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        let completion: ((UploadRequest) -> Void)? = { upload in
            upload.load(load: self.button).inform(
                error: BaseError(),
                inform: alert
            )
        }
        self.upload(UploadMultiFormDataForm(), completion: completion)
    }
}
