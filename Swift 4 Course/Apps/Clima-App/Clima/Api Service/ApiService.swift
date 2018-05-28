//
//  ApiModel.swift
//  Clima
//
//  Created by Rodolfo Queiroz on 2018-05-27.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    static let shared = ApiService()
    
    fileprivate let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate let APP_ID = "e8e499039e58bfbd20ceb278e00ad113"
    
    func getWeatherData(parameters: [String: String], handler: @escaping (DataResponse<Any>) -> Void) {
        var params = parameters
        params["appid"] = APP_ID
        
        Alamofire.request(WEATHER_URL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: handler)
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    func generateWeatherDataFromJSON(_ json: JSON) -> WeatherData? {
        guard let main = json["main"].string, let icon = json["icon"].string, let desc = json["description"].string, let id = json["id"].int else {
            print("Could not resolve necessary data for WeatherData object...")
            return nil
        }
        
        return WeatherData(id: id, main: main, icon: icon, description: desc)
    }
    func generateWeatherFromJSON(_ json: JSON) -> WeatherInfo? {
        guard let weatherData = generateWeatherDataFromJSON(json["weather"][0]) else { return nil }
        guard let cityName = json["name"].string, let lat = json["coord"]["lat"].float, let lon = json["coord"]["lon"].float else {
            print("Could not resolve necessary data for location object...")
            return nil
        }
        guard let temperature = json["main"]["temp"].float, let humidity = json["main"]["humidity"].int else {
            print("Could not resolve temperature or humidity...")
            return nil
        }
        
        let location = LocationData(city: cityName, latitude: lat, longitude: lon)
        let celciusTemp: Int = Int(temperature - 273.15)
        return WeatherInfo(weather: weatherData, location: location, temperature: celciusTemp, humidity: humidity)
    }
}
