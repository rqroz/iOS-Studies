//
//  Car.swift
//  Classes and Objects
//
//  Created by Rodolfo Queiroz on 2018-05-27.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import Foundation

enum CarType {
    case sedan
    case coupe
    case hatchBack
}

class Car {
    
    var colour : String = "Black"
    let numberOfSeats : Int = 5
    var carType : CarType = .sedan
    
    init(){}
    
    convenience init(colour: String) {
        self.init()
        self.colour = colour
    }
    
    func drive(){
        print("Car is moving...")
    }
}
