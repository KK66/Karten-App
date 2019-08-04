//
//  HappyPlace.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 24/08/16.
//  Copyright © 2016 Kilian Kellermann. All rights reserved.
//

import Foundation

class HappyPlace {
    var name: String
    let lat: Double
    let long: Double
    
    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}
