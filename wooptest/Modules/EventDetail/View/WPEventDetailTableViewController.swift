//
//  WPEventDetailViewController.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit
import CRNotifications
import MapKit

class WPEventDetailTableViewController: UITableViewController {
    // MARK: - Proprietes
    var event: WPEventDetail?
    var presenter: WPEventDetailPresenter?
   
    // MARK: - @IBOutlets
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showBarButtonItems()
        fetchEventDetail()
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if event != nil {
            return TableViewCellType.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let event = event else {
            return UITableViewCell() // could be a special cell
        }
        
        switch TableViewCellType(rawValue: indexPath.row) {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WPBannerTableViewCell.identifier,
                for: indexPath) as? WPBannerTableViewCell else {
                fatalError()
            }
            cell.urlBanner = event.image
            return cell
            
        case .title:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WPTitleTableViewCell.identifier,
                for: indexPath) as? WPTitleTableViewCell else {
                fatalError()
            }
            
            cell.lblDay.text = "\(event.dateObj.day)"
            cell.lblMonth.text = event.dateObj.monthName(.short)
            cell.lblTitle.text = event.title
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WPDescriptionTableViewCell.identifier,
                for: indexPath) as? WPDescriptionTableViewCell else {
                fatalError()
            }
            cell.lblDescription.text = event.description
            return cell
        case .checkin:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WPCheckinTableViewCell.identifier,
                for: indexPath) as? WPCheckinTableViewCell else {
                fatalError()
            }
            cell.checkinButton.addTarget(self, action: #selector(checkinAction), for: .touchUpInside)
            return cell
        case .map:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WPMapTableViewCell.identifier,
                for: indexPath) as? WPMapTableViewCell else {
                fatalError()
            }
            cell.location = event.location
            return cell
        default: break
            
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Private Functions
    private func fetchEventDetail() {
        view.startLoader()
        presenter?.fetchEventDetail()
    }
    
    @objc private func checkinAction(sender: UIButton!) {
        let alertFormController = UIAlertController(
            title: "Só algumas informações!",
            message: "Calma, só precisamos do seu e-mail e nome para colocar na lista do evento",
            preferredStyle: .alert
        )
        alertFormController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Nome"
            nameTextField.becomeFirstResponder()
            nameTextField.keyboardType = .alphabet
        }
        
        alertFormController.addTextField { (nameTextField) in
            nameTextField.placeholder = "E-mail"
            nameTextField.keyboardType = .emailAddress
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertFormController.addAction(cancelAction)
        let confirmAction = UIAlertAction(
        title: "Confirmar",
        style: .default) { (_) in
            let name = alertFormController.textFields!.first!.text!
            let email = alertFormController.textFields!.last!.text!
            
            self.view.startLoader()
            self.presenter?.makeCheckin(name: name, email: email)
        }
        alertFormController.addAction(confirmAction)
        present(alertFormController, animated: true, completion: nil)
    }
    
    // MARK: - Bar Button Items
    func showBarButtonItems() {
        let btnLocation = UIButton(type: .custom)
        btnLocation.setImage(UIImage(named: "location"), for: .normal)
        btnLocation.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnLocation.addTarget(self, action: #selector(tapOnHowToGoEvent), for: .touchUpInside)
        let itemLocationItem = UIBarButtonItem(customView: btnLocation)
    
        let btnShare = UIButton(type: .custom)
        btnShare.setImage(UIImage(named: "share"), for: .normal)
        btnShare.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        btnShare.addTarget(self, action: #selector(tapOnShare), for: .touchUpInside)
        let itemSharetem = UIBarButtonItem(customView: btnShare)
        
        navigationItem.setRightBarButtonItems([itemSharetem, itemLocationItem], animated: true)
    }
    
    // MARK: - Bar Button Items Actions
    @objc private func tapOnShare() {
        guard let event = event else {
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [event.title], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc private func tapOnHowToGoEvent() {
        guard let event = event else {
            return
        }
        
        let eventLatitude = event.location.coordinate.latitude
        let eventLongitude = event.location.coordinate.longitude
        
        let locationAlertController = UIAlertController(
            title: "Escolha uma opção: ",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        if UIApplication.shared.canOpenURL( URL(string:"waze://")! ) {
            let wazeAction = UIAlertAction(title: "Waze", style: .default) { (_) in
                UIApplication.shared.open(URL(
                    string: "waze://?ll=\(eventLatitude),\(eventLongitude)&navigate=yes")!,
                    options: [:],
                    completionHandler: nil
                )
            }
            locationAlertController.addAction(wazeAction)
        }
        
        if UIApplication.shared.canOpenURL( URL(string:"comgooglemaps://")! ) {
            let googleAction = UIAlertAction(title: "Google Maps", style: .default) { (_) in
                UIApplication.shared.open(URL(
                    string: "comgooglemaps://?center=\(eventLatitude),\(eventLongitude)&zoom=14&views=traffic")!,
                    options: [:],
                    completionHandler: nil
                )
            }
            locationAlertController.addAction(googleAction)
        }
        
        let mapsAction = UIAlertAction(title: "Maps", style: .default) { (_) in
            let mapItem = MKMapItem(placemark: MKPlacemark(
                coordinate: event.location.coordinate,
                addressDictionary:nil)
            )
            mapItem.name = event.title
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
        locationAlertController.addAction(mapsAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        locationAlertController.addAction(cancelAction)
        self.present(locationAlertController, animated: true, completion: nil)
    }
    
}

// MARK: Extension - Event Detail View Protocol
extension WPEventDetailTableViewController: WPEventDetailViewProtocol {
    
    func showEventDetail(_ event: WPEventDetail) {
        self.event = event
        view.stopLoader()
        tableView.reloadData()
    }
    
    func showCheckinSuccess() {
        CRNotifications.showNotification(
            type: CRNotifications.success,
            title: "Check-in realizado!",
            message: "Não esqueça do seu evento! Esperamos por você", dismissDelay: 5
        )
    }
    
    func showError() {
        CRNotifications.showNotification(
            type: CRNotifications.error,
            title: "Ops",
            message: "Encontramos algum problema no nosso servidor, por favor, tente novamente mais tarde",
            dismissDelay: 5
        )
    }
    
    func showCheckinError() {
        self.view.stopLoader()
        CRNotifications.showNotification(
            type: CRNotifications.error,
            title: "Deu problema no seu check-In !",
            message: "Por favor, tente novamente mais tarde.",
            dismissDelay: 5
        )
    }
    
    func showCheckinInvalidForm(message: String) {
        view.stopLoader()
        CRNotifications.showNotification(
            type: CRNotifications.error,
            title: "Peraí, isso é constrangedor!",
            message: "\(message)",
            dismissDelay: 5
        )
    }
}

private enum TableViewCellType: Int {
    case banner
    case title
    case checkin
    case map
    case description
    
    static let count: Int = {
        var max: Int = 0
        while let _ = TableViewCellType(rawValue: max) { max += 1 }
        return max
    }()
}
