//
//  HomeViewController.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
//
import CoreLocation
import UIKit
import CRNotifications

private var eventsCell = "EventCell"

class WPEventsViewController: UITableViewController {
    // MARK: - Proprietes
    var presenter: WPEventsPresenter?
    var events: [WPEvent] = []
    var locationManager = CLLocationManager()
    
    // MARK: - @IBOutlets
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        checkLocationAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self,
            action: #selector(resetFetchEvents(_:)),
            for: UIControl.Event.valueChanged
        )
        
        fetchEvents()
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: eventsCell, for: indexPath) as? WPEventTableViewCell else {
            fatalError()
        }
        cell.event = event
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        presenter?.clickOnShowEventDetail(event: event)
    }
    
    // MARK: - Private Functions
    
    private func fetchEvents() {
        view.startLoader()
        presenter?.fetchEvents()
    }
    
    @objc private func resetFetchEvents(_ sender: Any? = nil) {
        self.fetchEvents()
    }
   
    // MARK: - Location management
    private func checkLocationAuthorizationStatus() {
        locationManager.locationServiceAuthorized { authorized in
            if authorized {
                self.locationManager.startUpdatingLocation()
            } else {
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
}

// MARK: Extension - Events View Protocol
extension WPEventsViewController: WPEventsViewProtocol {
    func showEvents(_ events: [WPEvent]) {
        view.stopLoader()
        refreshControl?.endRefreshing()
        self.events = events
        tableView.reloadData()
    }
    
    func showError() {
        view.stopLoader()
        CRNotifications.showNotification(
            type: CRNotifications.error,
            title: "Ops!",
            message: "Não foi possível carregar os eventos. Tente novamente mais tarde.",
            dismissDelay: 3
        )
    }
}
