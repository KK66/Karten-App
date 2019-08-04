//
//  MapHelper.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 20.03.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Foundation
import MapKit

class MapHelper {
    
    class func getTitleFor(placemark: CLPlacemark) -> String {
        
        var strasse = ""
        if let street = placemark.thoroughfare {
            strasse = street
        }
        
        var ort = ""
        if let city = placemark.subAdministrativeArea {
            ort = city
        }
        
        return "\(strasse), \(ort)"
    }
    
    class func processSearchRequest(queryString: String, mapView: MKMapView) {
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = queryString
        
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (response, error) in
            
            guard let response = response else {
                print("leere Response")
                return
            }
            
            let center = response.boundingRegion.center
            let resultAnnotation = MKPointAnnotation()
            resultAnnotation.title = queryString
            resultAnnotation.coordinate = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
            
            let pinAnnotation = MKPinAnnotationView(annotation: resultAnnotation, reuseIdentifier: nil)
            mapView.centerCoordinate = resultAnnotation.coordinate
            
            if let tmpAnnotation = pinAnnotation.annotation {
                mapView.addAnnotation(tmpAnnotation)
            }
        }
    }
}
