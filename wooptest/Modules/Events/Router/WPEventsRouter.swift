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
    
    func showDetail(from view: WPEventsViewProtocol) {
        
    }
    
        
}

//
//class HomeRouter: HomeRouterProtocol {
//    var storyboard: UIStoryboard {
//        return UIStoryboard(name: "Home", bundle: nil)
//    }
//    
//    func build() -> UIViewController {
//        let interector = HomeInteractor()
//        let presenter = HomePresenter()
//        let router = HomeRouter()
//        let service = HomeService()
//        
//        guard let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as? HomeViewController else {
//            fatalError()
//        }
//        
//        viewController.presenter = presenter
//        presenter.router = router
//        presenter.interactor = interector
//        presenter.view = viewController
//        interector.presenter = presenter
//        interector.service = service
//        service.homeServiceHandler = interector
//        return viewController
//    }
//    
//    func logout(from view: HomeViewProtocol) {
//        guard let sourceVC = view as? UIViewController else {
//            return
//        }
//        
//        let destinationVC = LoginRouter().build()
//        
//        destinationVC.modalTransitionStyle = .coverVertical
//        destinationVC.view.frame =  sourceVC.view.window!.rootViewController!.view.frame
//        destinationVC.view.layoutIfNeeded()
//
//        UIView.transition(with: sourceVC.view.window!, duration: 0.5, options: .transitionFlipFromBottom, animations: {
//           sourceVC.view.window!.rootViewController = destinationVC
//        }, completion: nil)
//        
//    }
//}
