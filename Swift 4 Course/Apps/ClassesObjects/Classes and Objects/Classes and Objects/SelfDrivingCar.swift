//
//  SelfDrivingCar.swift
//  Classes and Objects
//
//  Created by Rodolfo Queiroz on 2018-05-27.
//  Copyright © 2018 Rodolfo Queiroz. All rights reserved.
//

import Foundation

class SelfDrivingCar: Car {
    var destination: String?
    
    override func drive() {
        super.drive()
        
        if let dest = destination {
            print("Driving towards \(dest)")
        }
    }
}
