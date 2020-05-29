//
//  MockEventsView.swift
//  wooptestTests
//
//  Created by Guilherme Leite Colares on 29/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
import Foundation
@testable import wooptest

class MockEventsView: WPEventsViewProtocol {
    var presenter: WPEventsPresenter?
    var showErrorAlert = false
    var didShowEvents = false
    
    func showEvents(_ events: [WPEvent]) {
        didShowEvents = true
    }
    
    func showError() {
        showErrorAlert = true
    }
}
