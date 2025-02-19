//
//  TestLocationSearchService.swift
//  FootprintsTests
//
//  Created by Jill Allan on 10/10/2024.
//

import Testing
@testable import Footprints

struct TestLocationSearchService {

    @Test func testLocationSearchServie_whenSearchForLocationFromString_returnsListOfLocations() async throws {
        let locationSearchService = await LocationSuggestionSearch()
        let locations = try await locationSearchService.fetchLocationSuggestions(for: "London")
        _ = locations.map({ completion in
            print("\(completion) \n")
        })
        #expect(locations.count > 0)
    }
    
    @Test func testLocationSearchServie_whenSearchForLocationFromStringLondon_returnsLocationsLondon() async throws {
        let locationSearchService = await LocationSuggestionSearch()
        let locations = try await locationSearchService.fetchLocationSuggestions(for: "London")
        let locationTitle = try #require(locations.first?.title)
        print(locationTitle)
        #expect(locationTitle.contains("London"))
    }

}
