//
//  WPEventAnnotation.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import MapKit

class WPEventAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
       // self.title = title.localized()
        self.title = ""
        self.subtitle = ""
        self.coordinate = coordinate
        super.init()
    }
}
