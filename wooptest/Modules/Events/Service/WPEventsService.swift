//
//  HomeService.swift
//  ContacttoSOS
//
//  Created by Guilherme Leite Colares on 23/03/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation
import Alamofire

class WPEventsService: WPEventsServiceInputProtocol {
    var eventsServiceHandler: WPEventsServiceOutputProtocol?
    
    // MARK: - Enums
    
    enum CustomURL: String {
        case events
    }
    
    // MARK: - Functions
    
    func fetchEvents() {
        let url = baseURL + CustomURL.events.rawValue
        AF.request(url, method: .get).responseData { (response) in
            switch response.result {
                
            case let .success(data):
                do {
                    let events = try JSONDecoder().decode([WPEvent].self, from: data)
                    self.eventsServiceHandler?.didFetchEvents(events: events)
                } catch {
                    self.eventsServiceHandler?.onError()
                }
            case .failure(_):
                self.eventsServiceHandler?.onError()
            }
        }
    }
}
