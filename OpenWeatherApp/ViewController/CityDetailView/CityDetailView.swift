//
//  CityDetailView.swift
//  OpenWeatherApp
//
//  Created by Vishal Patel on 07/11/17.
//  Copyright © 2017 Vishal Patel. All rights reserved.
//

import UIKit

class CityDetailView: UIViewController {
    var cityData:City!
    
    @IBOutlet var lblCurrentTemp: UILabel!
    @IBOutlet var lblMaxTemp: UILabel!
    @IBOutlet var lblMinTemp: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = cityData?.name
 
        if let temp = cityData.temp{
            lblCurrentTemp!.text = String(temp)
        }
        
        if let tempMax = cityData.tempMax{
            lblMaxTemp!.text = String(tempMax)
        }
        
        if let tempMin = cityData.tempMin{
            lblMinTemp!.text = String(tempMin)
        }
        
        if let humidity = cityData.humidity{
            lblHumidity!.text = String(humidity)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
