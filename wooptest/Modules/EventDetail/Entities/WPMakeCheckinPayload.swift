//
//  WPMakeCheckin.swift
//  wooptest
//
//  Created by Guilherme Leite Colares on 28/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//

import Foundation

// MARK: - WPMakeCheckin
struct WPMakeCheckinPayload: Encodable {
    let eventId: String
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case eventId, name, email
    }
}
