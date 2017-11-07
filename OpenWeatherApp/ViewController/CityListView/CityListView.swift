//
//  CityListView.swift
//  OpenWeatherApp
//
//  Created by Vishal Patel on 06/11/17.
//  Copyright © 2017 Vishal Patel. All rights reserved.
//

import UIKit

class CityListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var tblCity: UITableView!
    var arrCityData = [City]()
    var citySelected:City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCity.tableFooterView = UIView()
        activity.alpha = 0;
        
        getCityTemperature()
    }

    func getCityTemperature()
    {
        activity.startAnimating()
        tblCity.alpha = 0;
        UIView.animate(withDuration: 0.25) {
            self.activity.alpha = 1;
        }
        let arrCityIDs = ["4163971","2147714","2174003"]
        
        let dispatchGroup = DispatchGroup()
        
        for cityId in arrCityIDs {
            let todoEndpoint: String = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&units=metric&APPID=552ea9c0596a4842fe5010974b658e51"
            guard let urlService = URL(string: todoEndpoint) else {
                print("Error: cannot create URL")
                return
            }
            let urlRequest = URLRequest(url: urlService)
            
            // set up the session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            dispatchGroup.enter()
            
            // make the request
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                
                if error != nil{
                    print("Error -> \(String(describing: error))")
                    dispatchGroup.leave()
                    return
                }
                
                do {
                    let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
                    if ((someDictionaryFromJSON["cod"] as! NSInteger) == 200)
                    {
                        let city = City(fromDictionary: someDictionaryFromJSON)
                        self.arrCityData.append(city)
                    }else{
                        print("error")
                    }
                    dispatchGroup.leave()
                } catch {
                    print("Error -> \(error)")
                    dispatchGroup.leave()
                }
            }
            task.resume()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.tblCity.reloadData()
            
            self.activity.stopAnimating()
            UIView.animate(withDuration: 0.25) {
                self.activity.alpha = 0;
                self.tblCity.alpha = 1;
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let city = arrCityData[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = "Current Temp: \(String(describing: city.temp!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citySelected = arrCityData[indexPath.row]
        performSegue(withIdentifier: "showCityDetail", sender: nil)
    }
    // MARK: -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityDetail"{
            let vc = segue.destination as! CityDetailView
            vc.cityData = citySelected
        }
    }
}
