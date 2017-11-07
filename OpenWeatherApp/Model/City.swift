//
//  City.swift
//  OpenWeatherApp
//
//  Created by Vishal Patel on 07/11/17.
//  Copyright © 2017 Vishal Patel. All rights reserved.
//

import UIKit

class City: NSObject {
    
    var name:String!
    
    var temp:Float!
    var tempMax:Float!
    var tempMin:Float!
    var humidity:Float!
        
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        
        if let mainData = dictionary["main"] as? [String:Any]{
            temp = mainData["temp"] as? Float
            tempMax = mainData["temp_max"] as? Float
            tempMin = mainData["temp_min"] as? Float
            humidity = mainData["humidity"] as? Float
        }
    }
}
