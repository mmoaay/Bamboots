//
//  HomeViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 15/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            self.performSegue(withIdentifier: "fromHomeToSerialize", sender: nil)
            break
        case 2:
            self.performSegue(withIdentifier: "fromHomeToLoad", sender: nil)
            break
        case 3:
            self.performSegue(withIdentifier: "fromHomeToTable", sender: nil)
            break
        case 4:
            self.performSegue(withIdentifier: "fromHomeToProgress", sender: nil)
            break;
        default:
            break
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
