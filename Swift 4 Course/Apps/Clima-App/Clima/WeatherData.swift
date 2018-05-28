//
//  Weather.swift
//  Clima
//
//  Created by Rodolfo Queiroz on 2018-05-27.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class WeatherData {
    var main: String
    var icon: String
    var description: String
    var id: Int
    
    init(id: Int, main: String, icon: String, description: String) {
        self.id = id
        self.main = main
        self.icon = icon
        self.description = description
    }
}
