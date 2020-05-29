//
//  CoreLocation+Extension.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import CoreLocation

extension CLLocationManager {

    func locationServiceAuthorized(_ completion: @escaping (_ authorized: Bool) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                completion(false)
            case .authorizedAlways, .authorizedWhenInUse:
                completion(true)
            @unknown default:
                completion(false)
            }
        }
        completion(false)
    }

}
