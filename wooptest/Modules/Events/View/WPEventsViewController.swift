//
//  HomeViewController.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
//
import MapKit
import UIKit
import AVFoundation
import CRNotifications

private var eventsCell = "EventCell"

class WPEventsViewController: UITableViewController {
    // MARK: - Proprietes
    var presenter: WPEventsPresenter?
    var events: [WPEvent] = []
    
    // MARK: - @IBOutlets
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        view.startLoader()
        presenter?.fetchEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: eventsCell, for: indexPath) as! WPEventTableViewCell
        cell.event = event
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        presenter?.clickOnShowEventDetail(event: event)
    }
}

// MARK: Extension - Events View Protocol
extension WPEventsViewController: WPEventsViewProtocol {
    func showEvents(_ events: [WPEvent]) {
        view.stopLoader()
        self.events = events
        tableView.reloadData()
    }
    
    func showError() {
        CRNotifications.showNotification(type: CRNotifications.error, title: "Ops!", message: "Não foi possível carregar os eventos. Tente novamente mais tarde.", dismissDelay: 3)
    }
}