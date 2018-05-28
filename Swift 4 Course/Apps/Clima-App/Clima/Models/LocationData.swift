//
//  LocationData.swift
//  Clima
//
//  Created by Rodolfo Queiroz on 2018-05-27.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class LocationData {
    let city: String
    let latitude: Float
    let longitude: Float
    
    init(city: String, latitude: Float, longitude: Float) {
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
}
