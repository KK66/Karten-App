//
//  DetailViewController.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 24/08/16.
//  Copyright © 2016 Kilian Kellermann. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var currentPlace: HappyPlace?
    var locationManager: CLLocationManager
    
    @IBOutlet weak var mapView: MKMapView!
    
    var masterView: NewLocationDelegate? {
        get {
            let navCtrl = self.splitViewController?.viewControllers.first as! UINavigationController
            return navCtrl.viewControllers.first as! MasterTableViewController
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(DetailViewController.newLocation))
        
        gesture.minimumPressDuration = 2
        mapView.addGestureRecognizer(gesture)
    }
    
    @objc func newLocation(_ gestureRecognizer: UIGestureRecognizer) {
        
        guard gestureRecognizer.state == .began else {
            return
        }
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) {
            (placemarks, error) in
            
            guard let mark = placemarks?.first else {
                return
            }
            
            let title = MapHelper.getTitleFor(placemark: mark)
            
            if let delegate = self.masterView {
                delegate.newLocationAdded(name: title, lat: coordinates.latitude, long: coordinates.longitude)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = title
                
                self.mapView.addAnnotation(annotation)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentPlace = currentPlace else {
            return
        }
        
        let location = CLLocationCoordinate2DMake(currentPlace.lat, currentPlace.long)
        
        //
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
        
        //
        let annotation = MKPointAnnotation()
        annotation.title = currentPlace.name
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        title = currentPlace.name
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        let searchCtrl = UISearchController(searchResultsController: nil)
        searchCtrl.hidesNavigationBarDuringPresentation = false
        searchCtrl.searchBar.delegate = self
        present(searchCtrl, animated: true, completion: nil)
    }

    @IBAction func locationTapped(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.startUpdatingLocation()
        
        let newLocation = locations.first
        guard let coordination = newLocation?.coordinate else {
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordination.latitude, longitude: coordination.longitude)
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        mapView.centerCoordinate = annotation.coordinate
        
        guard let tmpAnnotation = pinAnnotation.annotation else {
            return
        }
        
        mapView.addAnnotation(tmpAnnotation)
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        if mapView.annotations.count > 0 {
            for annotation in mapView.annotations {
                mapView.removeAnnotation(annotation)
            }
        }
        
        //
        guard let queryString = searchBar.text else {
            return
        }
        
        MapHelper.processSearchRequest(queryString: queryString, mapView: mapView)
    }
}
