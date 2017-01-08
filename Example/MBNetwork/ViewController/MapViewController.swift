//
//  MapViewController.swift
//  MBNetwork
//
//  Created by ZhengYidong on 29/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import MBNetwork
import Alamofire
import AlamofireObjectMapper

extension MapViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerializableCell", for: indexPath)

        if let _ = weatherResponse {
            let threeDayForecast = weatherResponse!.threeDayForecast!
            let forecast = threeDayForecast[indexPath.row]

            cell.textLabel?.text = forecast.day
            cell.detailTextLabel?.text = forecast.conditions! + " - " +  String(forecast.temperature!) + "℃"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = weatherResponse {
            return weatherResponse!.threeDayForecast!.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let _ = weatherResponse {
            return weatherResponse!.location
        } else {
            return nil
        }
    }
}

class MapViewController: UITableViewController, MBRequestable {

    var weatherResponse: WeatherResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        load()
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

    private func load() {
        request(WeatherForm()).responseObject(keyPath: "data") { (response: DataResponse<WeatherResponse>) in
            if let value = response.result.value {
                self.weatherResponse = value
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func load(_ sender: Any) {
        load()
    }
}
