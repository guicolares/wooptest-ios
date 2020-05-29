//
//  WPEventsService.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation
import Alamofire

class WPEventDetailService: WPEventDetailServiceInputProtocol {
    var eventDetailServiceHandler: WPEventDetailServiceOutputProtocol?
    
    // MARK: - Enums
    
    enum CustomURL: String {
        case events = "events/"
        case checkin = "checkin"
    }
    
    // MARK: - Functions
    
    func fetchDetailBy(id: String) {
        let url = baseURL + CustomURL.events.rawValue + id
        AF.request(url, method: .get).responseData { (response) in
            switch response.result {
            case let .success(data):
                do {
                    let event = try JSONDecoder().decode(WPEventDetail.self, from: data)
                    self.eventDetailServiceHandler?.didFetchDetail(event: event)
                } catch {
                    self.eventDetailServiceHandler?.onError()
                }
            case .failure(_):
                self.eventDetailServiceHandler?.onError()
            }
        }
    }
    
    func makeCheckin(payload: WPMakeCheckinPayload) {
        let url = baseURL + CustomURL.checkin.rawValue
        
        AF.request(url,
                   method: .post,
                   parameters: payload,
                   encoder: JSONParameterEncoder.default ).response { (response) in
                    //@todo always error ?
                    if response.response?.statusCode == 200 {
                        self.eventDetailServiceHandler?.checkinSuccess()
                    } else {
                        self.eventDetailServiceHandler?.onErrorCheckin()
                    }
        }
    }
}
