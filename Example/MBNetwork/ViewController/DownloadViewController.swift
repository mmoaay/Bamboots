//
//  DownloadViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 01/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork
import SnapKit
import Alamofire

class DownloadViewController: UIViewController, MBRequestable {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.download(ImageDownloadForm()).responseData { (response:DownloadResponse<Data>) in
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
