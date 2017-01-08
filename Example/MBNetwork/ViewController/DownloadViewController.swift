//
//  DownloadViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 01/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork
import Alamofire

class DownloadViewController: UIViewController, MBRequestable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progress: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func download(_ sender: Any) {
        let load = LoadConfig(container: imageView, mask:MBEyeLoading())

        self.download(ImageDownloadForm()).load(load: load).progress(progress: progress)
            .responseData { (response: DownloadResponse<Data>) in
            switch response.result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
                break
            case .failure:
                break
            }
        }
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
}
