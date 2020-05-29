//
//  WPEventDetailPresenter.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
import Foundation

class WPEventDetailPresenter: WPEventDetailPresenterProtocol {
    weak var view: WPEventDetailViewProtocol?
    
    var interactor: WPEventDetailInteractorInputProtocol?
    var router: WPEventDetailRouterProtocol?

    func fetchEventDetail() {
        interactor?.fetchEventDetail()
    }
    
    func makeCheckin(name: String, email: String) {
        interactor?.makeCheckin(name: name, email: email)
    }
}

extension WPEventDetailPresenter: WPEventDetailInteractorOutputProtcol {
    
    func didFetchEventDetail(_ event: WPEventDetail) {
        view?.showEventDetail(event)
    }
    
    func didCheckin() {
        view?.showCheckinSuccess()
    }
   
    func onError() {
        view?.showError()
    }
    
    func onErrorCheckin() {
        view?.showCheckinError()
    }
}
