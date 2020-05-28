//
//  RequestLocationPermissionViewController.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 01/04/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit

class RequestLocationPermissionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOnGoSettings(_ sender: UIButton) {
        guard let settingsUrl = URL(string:
            UIApplication.openSettingsURLString) else {
               return
        }

       if UIApplication.shared.canOpenURL(settingsUrl) {
           UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
               print("Settings opened: \(success)") // Prints true
           })
       }
    }
    
    public static func initiate() -> RequestLocationPermissionViewController {
        let main = UIStoryboard(name: "Home", bundle: nil)
        guard let locationServiceVC = main.instantiateViewController(
            withIdentifier: "RequestLocationPermission") as? RequestLocationPermissionViewController else {
                fatalError()
        }
        locationServiceVC.modalPresentationStyle = .fullScreen
        
        return locationServiceVC
    }
}
