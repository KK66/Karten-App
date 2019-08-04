//
//  NewLocationDelegate.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 20.03.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Foundation

protocol NewLocationDelegate {
    
    func newLocationAdded(name: String, lat: Double, long: Double)
}
