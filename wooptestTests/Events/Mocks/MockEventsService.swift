//
//  MockEventsService.swift
//  wooptestTests
//
//  Created by Guilherme Leite Colares on 29/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation
@testable import wooptest

class MockEventsService: WPEventsServiceInputProtocol {
    var eventsServiceHandler: WPEventsServiceOutputProtocol?
    
    var eventsToReturn: [WPEvent] = []
    var shouldReturnError = false
    
    func fetchEvents() {
        if !shouldReturnError {
            eventsServiceHandler?.didFetchEvents(events: eventsToReturn)
        } else {
            eventsServiceHandler?.onError()
        }
    }
}
