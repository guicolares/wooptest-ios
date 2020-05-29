//
//  WPEventDetailRouter.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation

import UIKit
class WPEventDetailRouter: WPEventDetailRouterProtocol {
    var storyboard: UIStoryboard {
        return UIStoryboard(name: "EventDetail", bundle: nil)
    }
    
    func build(eventSelected: WPEvent) -> UIViewController {
        let interactor = WPEventDetailInteractor()
        interactor.eventSelectedId = eventSelected.id
        
        let presenter = WPEventDetailPresenter()
        let router = WPEventDetailRouter()
        let service = WPEventDetailService()
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailTableViewController") as? WPEventDetailTableViewController else {
            fatalError()
        }
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.service = service
        service.eventDetailServiceHandler = interactor
        return viewController
    }
    
    func showDetail(from view: WPEventsViewProtocol, eventSelected: WPEvent) {
        
        
    }
    
        
}
