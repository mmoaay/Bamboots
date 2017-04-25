//
//  LoadableViewController.swift
//  Bamboots
//
//  Created by ZhengYidong on 19/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Bamboots

class LoadableViewController: UIViewController, Requestable {

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
        let load = LoadConfig(
            container: view, mask:EyeLoading(),
            inset: UIEdgeInsets(
                top: 15 + 64,
                left: 15,
                bottom: UIScreen.main.bounds.height - 64 - (44 * 5 + 15 + 15 * 4),
                right: 15
            )
        )
        request(WeatherForm()).load(load: load)
    }

    @IBAction func loadViewController(_ sender: AnyObject) {
        request(WeatherForm()).load(load: LoadType.default(container: self))
    }

    @IBAction func loadNavigationController(_ sender: AnyObject) {
        request(WeatherForm()).load(load: LoadType.default(container: self.navigationController!))
    }

    @IBAction func loadButton(_ sender: AnyObject) {
        if let trySender = sender as? Loadable {
            request(WeatherForm()).load(load: trySender)
        }
    }

    @IBAction func loadRoundButton(_ sender: Any) {
        if let trySender = sender as? Loadable {
            request(WeatherForm()).load(load: trySender)
        }
    }

    @IBAction func loadCircleButton(_ sender: Any) {
        if let trySender = sender as? Loadable {
            request(WeatherForm()).load(load: trySender)
        }
    }
}
