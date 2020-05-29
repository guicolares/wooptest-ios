//
//  WPMapTableViewCell.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit
import MapKit

class WPMapTableViewCell: UITableViewCell {
    
    // MARK: - Proprietes
    var location: CLLocation! {
        didSet {
            loadLocation()
        }
    }
    
    // MARK: - @IBOutlets
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var lblDistance: UILabel!
    
    // MARK: - Private Functions
    private func loadLocation() {
        let coordinateReigon = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 200,
            longitudinalMeters: 200
        )
        mapView.setRegion(coordinateReigon, animated: true)
        let annotation = WPEventAnnotation(coordinate: location.coordinate)
        mapView.addAnnotation(annotation)
        
        //compare user location
        lblDistance.text = "--"
        if let userLocation = mapView.userLocation.location {
            let distance = location.distance(from: userLocation)
            lblDistance.text = "\( Int(distance / 1000)) km"
        }
    }
}

// MARK: - MapViewDeletage
extension WPMapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? WPEventAnnotation {
            let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pinAnnotation.animatesDrop = true
            pinAnnotation.pinTintColor = UIColor.brown
            pinAnnotation.isDraggable = false
            pinAnnotation.isEnabled = false
            return pinAnnotation
        }
        
        return nil
    }
}
