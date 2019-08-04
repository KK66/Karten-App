//
//  ArrayRessource.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 24/08/16.
//  Copyright © 2016 Kilian Kellermann. All rights reserved.
//

import Foundation

class ArrayRessource: HappyPlaceDataSource {
    
    var places = [HappyPlace]()
    
    init() {
        let farup = HappyPlace(name: "Fårup Sommerland", lat: 57.2682684, long: 9.6503442)
        places.append(farup)
    }
    
    func getPlaces() -> [HappyPlace] {
        return places
    }
    
    func getPlace(for index: Int) -> HappyPlace {
        return places[index]
    }
    
    func insertPlace(happyPlace: HappyPlace) {
        self.places.append(happyPlace)
    }
    
    func getRandomPlace() -> HappyPlace {
        let index = Int(arc4random_uniform(UInt32(places.count)))
        return places[index]
    }
}
