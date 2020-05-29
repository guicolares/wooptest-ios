//
//  MockEventsInteractor.swift
//  wooptestTests
//
//  Created by Guilherme Leite Colares on 29/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
import Foundation
@testable import wooptest

class MockEventsInteractorOutput: WPEventsInteractorOutputProtcol {
    var view: WPEventsViewProtocol?
    
    var eventsDidFetchCalled = false
    var eventsDidFetchCalledWith: [WPEvent] = []
    
    var eventsFailToFetchCalled = false
    var eventsFailToFetchCalledWith = ""
    
    func didFetchEvents(_ events: [WPEvent]) {
        eventsDidFetchCalled = true
        eventsDidFetchCalledWith = events
    }
    
    func onError() {
        eventsFailToFetchCalled = true
    }
}
