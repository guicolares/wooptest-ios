//
//  WPEventDetailViewController.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit
import CRNotifications

class WPEventDetailTableViewController: UITableViewController {
    // MARK: - Proprietes
    var event: WPEventDetail?
    var presenter: WPEventDetailPresenter?
   
    
    // MARK: - @IBOutlets
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEventDetail()
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = event {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: WPBannerTableViewCell.identifier, for: indexPath) as! WPBannerTableViewCell
            cell.urlBanner = event.image
            return cell
            
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: WPTitleTableViewCell.identifier, for: indexPath) as! WPTitleTableViewCell
            cell.lblDay.text = "\(event.dateObj.day)"
            cell.lblMonth.text = event.dateObj.monthName(.short)
            cell.lblTitle.text = event.title
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: WPDescriptionTableViewCell.identifier, for: indexPath) as! WPDescriptionTableViewCell
            cell.lblDescription.text = event.description
            return cell
        case .checkin:
            let cell = tableView.dequeueReusableCell(withIdentifier: WPCheckinTableViewCell.identifier, for: indexPath) as! WPCheckinTableViewCell
            cell.checkinButton.addTarget(self, action: #selector(checkinAction), for: .touchUpInside)
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
        let alertFormController = UIAlertController(title: "Só algumas informações!", message: "Calma, só precisamos do seu e-mail e nome para colocar na lista do evento", preferredStyle: .alert)
        alertFormController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Nome"
            nameTextField.keyboardType = .alphabet
        }
        
        alertFormController.addTextField { (nameTextField) in
            nameTextField.placeholder = "E-mail"
            nameTextField.keyboardType = .emailAddress
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertFormController.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (action) in
            let name = alertFormController.textFields!.first!.text!
            let email = alertFormController.textFields!.last!.text!
            
            self.view.startLoader()
            self.presenter?.makeCheckin(name: name, email: email)
        }
        alertFormController.addAction(confirmAction)
        present(alertFormController, animated: true, completion: nil)
        
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
        CRNotifications.showNotification(type: CRNotifications.success, title: "Check-in realizado!", message: "Não esqueça do seu evento! Esperamos por você", dismissDelay: 5)
    }
    
    func showError() {
        CRNotifications.showNotification(type: CRNotifications.error, title: "Ops", message: "Encontramos algum problema no nosso servidor, por favor, tente novamente mais tarde", dismissDelay: 5)
    }
    
    func showCheckinError() {
        self.view.stopLoader()
        CRNotifications.showNotification(type: CRNotifications.error, title: "Deu problema no seu check-In !", message: "Por favor, tente novamente mais tarde.", dismissDelay: 5)
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
