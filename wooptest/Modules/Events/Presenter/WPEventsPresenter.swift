//
//  HomePresenter.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation

class WPEventsPresenter: WPEventsPresenterProtocol {
    weak var view: WPEventsViewProtocol?
    
    var interactor: WPEventsInteractorInputProtocol?
    var router: WPEventsRouterProtocol?
    
    // MARK: - Functions
    func clickOnShowEventDetail(event: WPEvent) {
        
    }
    
    func fetchEvents() {
        interactor?.fetchEvents()
    }
}

extension WPEventsPresenter: WPEventsInteractorOutputProtcol {
    
    func didFetchEvents(_ events: [WPEvent]) {
        view?.showEvents(events)
    }
    
    func onError() {
        view?.showError()
    }
    
}
