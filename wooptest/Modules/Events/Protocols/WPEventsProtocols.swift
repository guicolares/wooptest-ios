//
//  WPEventsProtocols.swift
//  Woop
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import UIKit
import CoreLocation

protocol WPEventsViewProtocol: class {
    var presenter: WPEventsPresenter? { get set }
    
    //PRESENTER -> VIEW
    func showEvents(_ events: [WPEvent])
    
    func showError()
}

protocol WPEventsPresenterProtocol: class {
    var view: WPEventsViewProtocol? { get set }
    var interactor: WPEventsInteractorInputProtocol? { get set }
    var router: WPEventsRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func clickOnShowEventDetail(event: WPEvent)
    func fetchEvents()

}

protocol WPEventsInteractorInputProtocol: class {
    var presenter: WPEventsInteractorOutputProtcol? { get set }
    var service: WPEventsServiceInputProtocol? { get set }
    
    //PRESENTER -> INTERECTOR
    func fetchEvents()
}

protocol WPEventsInteractorOutputProtcol: class {
    var view: WPEventsViewProtocol? { get set }
    
    //INTERECTOR -> PRESENTER
    func didFetchEvents(_ events: [WPEvent])
    
    func onError()
}

protocol WPEventsServiceInputProtocol: class {
    var eventsServiceHandler: WPEventsServiceOutputProtocol? { get set }
    
    func fetchEvents()
}

protocol WPEventsServiceOutputProtocol: class {
    func didFetchEvents(events: [WPEvent])
    func onError()
}

protocol WPEventsRouterProtocol: class {
    //PRESENTER -> ROUTER
    func build() -> UIViewController
    func showDetail(from view: WPEventsViewProtocol)
    
}
