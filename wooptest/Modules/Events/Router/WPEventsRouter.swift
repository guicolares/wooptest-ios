//
//  WPEventsRouter.swift
//  Woop Test
//
//  Created by Guilherme Leite Colares on 25/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
//
import UIKit
class WPEventsRouter: WPEventsRouterProtocol {
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: "Events", bundle: nil)
    }
    
    func build() -> UIViewController {
        let interactor = WPEventsInteractor()
        let presenter = WPEventsPresenter()
        let router = WPEventsRouter()
        let service = WPEventsService()
        
        guard let nvc = storyboard.instantiateViewController(withIdentifier: "EventsNavigationViewController") as? UINavigationController,
            let viewController = nvc.topViewController as? WPEventsViewController else {
            fatalError()
        }
        
        viewController.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.service = service
        service.eventsServiceHandler = interactor
        return nvc
    }
    
    func showDetail(from view: WPEventsViewProtocol, eventSelected: WPEvent) {
        guard let sourceVC = view as? UIViewController else {
            return
        }
        
        let destinationVC = WPEventDetailRouter().build(eventSelected: eventSelected)
        
        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
