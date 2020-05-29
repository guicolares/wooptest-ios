//
//  WPEventDetailProtocols.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation

protocol WPEventDetailViewProtocol: class {
    var presenter: WPEventDetailPresenter? { get set }
    
    //PRESENTER -> VIEW
    func showEventDetail(_ event: WPEventDetail)
    func showCheckinSuccess()
    func showError()
    func showCheckinError()
}

protocol WPEventDetailPresenterProtocol: class {
    var view: WPEventDetailViewProtocol? { get set }
    var interactor: WPEventDetailInteractorInputProtocol? { get set }
    var router: WPEventDetailRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func fetchEventDetail()
    func makeCheckin( name: String, email: String )
}

protocol WPEventDetailInteractorInputProtocol: class {
    var presenter: WPEventDetailInteractorOutputProtcol? { get set }
    var service: WPEventDetailServiceInputProtocol? { get set }
    
    //PRESENTER -> INTERECTOR
    func fetchEventDetail()
    func makeCheckin(name: String, email: String)
}

protocol WPEventDetailInteractorOutputProtcol: class {
    var view: WPEventDetailViewProtocol? { get set }
    
    //INTERECTOR -> PRESENTER
    func didFetchEventDetail(_ event: WPEventDetail)
    func didCheckin()
    
    func onError()
    func onErrorCheckin()
}

protocol WPEventDetailServiceInputProtocol: class {
    var eventDetailServiceHandler: WPEventDetailServiceOutputProtocol? { get set }
    
    func fetchDetailBy(id: String)
    func makeCheckin(payload: WPMakeCheckinPayload)
}

protocol WPEventDetailServiceOutputProtocol: class {
    func didFetchDetail(event: WPEventDetail)
    func checkinSuccess()
    func onError()
    func onErrorCheckin()
}

protocol WPEventDetailRouterProtocol: class {
    //PRESENTER -> ROUTER
    func build(eventSelected: WPEvent) -> UIViewController
    
}
