//
//  WPEventsInterector.swift
//  Woop Test
//
//  Created by Guilherme Leite Colares on 25/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
//
import Foundation
class WPEventsInteractor: WPEventsInteractorInputProtocol {
    weak var presenter: WPEventsInteractorOutputProtcol?
    
    var service: WPEventsServiceInputProtocol?
    
    var events: [WPEvent] = []
    
    func fetchEvents() {
        service?.fetchEvents()
    }
}

extension WPEventsInteractor: WPEventsServiceOutputProtocol {
    
    func didFetchEvents(events: [WPEvent]) {
        self.events = events
        presenter?.didFetchEvents(events)
    }
    
    func onError() {
        presenter?.onError()
    }
}
