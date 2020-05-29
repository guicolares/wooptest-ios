import Foundation
import  CoreLocation
import SwiftDate

// MARK: - FDFuelStation
struct WPEvent: Codable {
    let people: [WPPerson]
    let date: Int
    let description: String
    let image: String
    let longitude, latitude, price: Double
    let title, id: String
    let cupons: [WPCupon]
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
        
    }
    
    var dateObj: Date {
        return Date(milliseconds: date)
        
    }

    enum CodingKeys: String, CodingKey {
        case people, date
        case description
        case image, longitude, latitude, price, title, id, cupons
    }
}

// MARK: - Cupon
struct WPCupon: Codable {
    let id, eventID: String
    let discount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case eventID = "eventId"
        case discount
    }
}

// MARK: - Person
struct WPPerson: Codable {
    let id, eventID, name, picture: String

    enum CodingKeys: String, CodingKey {
        case id
        case eventID = "eventId"
        case name, picture
    }
}
