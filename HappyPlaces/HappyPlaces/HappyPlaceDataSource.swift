//
//  HappyPlaceDataSource.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 24/08/16.
//  Copyright © 2016 Kilian Kellermann. All rights reserved.
//

import Foundation

protocol HappyPlaceDataSource {
    
    func getPlaces() -> [HappyPlace]
    func getPlace(for index: Int) -> HappyPlace
    func insertPlace(happyPlace: HappyPlace)
    func getRandomPlace() -> HappyPlace
}
