//
//  MockEventsInteractor.swift
//  wooptestTests
//
//  Created by Guilherme Leite Colares on 29/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation
@testable import wooptest

class MockEventsInteractor: WPEventsInteractorInputProtocol {
    var presenter: WPEventsInteractorOutputProtcol?
    var service: WPEventsServiceInputProtocol?
    
    var fetchEventsCalled = false
    
    func fetchEvents() {
        fetchEventsCalled = true
    }
}
