//
//  SeismicData.swift
//  Clima
//
//  Created by Rodolfo Queiroz on 2018-05-27.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class SeismicData {
    var sunset: Int
    var sunrise: Int
    var country: String
    
    var id: Int = -1
    var type: Int = -1
    var message: String = ""
    
    init(sunset: Int, sunrise: Int, country: String) {
        self.sunset = sunset
        self.sunrise = sunrise
        self.country = country
    }
}
