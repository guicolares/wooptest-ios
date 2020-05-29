//
//  WPEventDetailInteractor.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation
class WPEventDetailInteractor: WPEventDetailInteractorInputProtocol {
    weak var presenter: WPEventDetailInteractorOutputProtcol?
    var service: WPEventDetailServiceInputProtocol?
    
    var eventSelectedId: String!
    
    func fetchEventDetail() {
        service?.fetchDetailBy(id: eventSelectedId)
    }
    
    func makeCheckin(name: String, email: String) {
        let payload = WPMakeCheckinPayload(
            eventId: eventSelectedId,
            name: name,
            email: email
        )
        
        service?.makeCheckin(payload: payload)
    }
    
    
   
}

extension WPEventDetailInteractor: WPEventDetailServiceOutputProtocol {
    
    func didFetchDetail(event: WPEventDetail) {
        presenter?.didFetchEventDetail(event)
    }
    
    func checkinSuccess() {
        presenter?.didCheckin()
    }
    
    func onError() {
        presenter?.onError()
    }
    
    func onErrorCheckin() {
        presenter?.onErrorCheckin()
    }
}

