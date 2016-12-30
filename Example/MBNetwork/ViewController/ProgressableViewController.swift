//
//  ProgressableViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 26/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork
import Alamofire
import SnapKit

class ProgressableViewController: UIViewController, MBRequestable {
    @IBOutlet weak var progress: UIProgressView!

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func load(_ sender: Any) {
        self.download(ImageDownloadForm(), load: MBLoadType.none).progress(progress: progress).responseData { (response:DownloadResponse<Data>) in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                self.imageView.snp.updateConstraints({ (make:ConstraintMaker) in
                    make.width.equalTo(self.imageView.snp.height).multipliedBy(image!.size.width/image!.size.height)
                })
                self.imageView.image = image
                break
            case .failure:
                break
            }
        }
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
