//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class WeatherInfo {
    var humidity: Int
    var temperature: Int
    var location: LocationData
    var weather: WeatherData
    
    var minTemperature: Int?
    var maxTemperature: Int?
    var pressure: Float?
    var windData: WindData?
    
    var weatherIconName: String = ""
    
    init(weather: WeatherData, location: LocationData, temperature: Int, humidity: Int) {
        self.weather = weather
        self.location = location
        self.temperature = temperature
        self.humidity = humidity
    }
    
    
    //This method turns a condition code into the name of the weather condition image
    func currentWeatherIcon() -> String {
        switch (weather.id) {
            case 0...300 :
                return "tstorm1"
            case 301...500 :
                return "light_rain"
            case 501...600 :
                return "shower3"
            case 601...700 :
                return "snow4"
            case 701...771 :
                return "fog"
            case 772...799 :
                return "tstorm3"
            case 800 :
                return "sunny"
            case 801...804 :
                return "cloudy2"
            case 900...903, 905...1000  :
                return "tstorm3"
            case 903 :
                return "snow5"
            case 904 :
                return "sunny"
            default :
                return "dunno"
        }
    }
}
