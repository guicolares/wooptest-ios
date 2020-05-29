//
//  EventsInteractorTests.swift
//  wooptestTests
//
//  Created by Guilherme Leite Colares on 29/05/20.
//  Copyright © 2020 Guilherme Leite Colares. All rights reserved.
//
import XCTest
@testable import wooptest

class EventsInteractorTests: XCTestCase {
    var interactor: WPEventsInteractor!
    var output: MockEventsInteractorOutput!
    var serviceData: MockEventsService!
    
    override func setUp() {
        interactor = WPEventsInteractor()
        output = MockEventsInteractorOutput()
        serviceData = MockEventsService()
        serviceData.eventsServiceHandler = interactor
        interactor.service = serviceData
        interactor.presenter = output
    }

    func testEventsFetchSuccess() {
        serviceData.eventsToReturn = generateEventsData()
        let expectedEventsCount = 10

        interactor.fetchEvents()

        XCTAssertTrue(output.eventsDidFetchCalled)
        XCTAssertEqual(output.eventsDidFetchCalledWith.count, expectedEventsCount)
    }

    func testEventsFetchFail() {
        serviceData.shouldReturnError = true
        
        interactor.fetchEvents()

        XCTAssertFalse(output.eventsDidFetchCalled)
        XCTAssertTrue(output.eventsFailToFetchCalled)
    }

    func testEvents() {
        serviceData.eventsToReturn = generateEventsData()
        interactor.fetchEvents()
       
        for index in 0..<4 {
            XCTAssertEqual(interactor.events[index].id, String(index))
        }
    }
    
    private func generateEventsData() -> [WPEvent] {
        var events: [WPEvent] = []
        
        for index in 0..<10 {
            let event = WPEvent(
                people: [],
                date: 1534784400000,
                description: "description \(index)",
                image: "\(index).png",
                longitude: -51.2146267,
                latitude: -30.0392981,
                price: 50,
                title: "title \(index)",
                id: "\(index)",
                cupons: []
            )
            events.append(event)
            
        }
        
        return events
    }
}
