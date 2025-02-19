//
//  CLLocationCoordinate2D.swift
//  Footprints
//
//  Created by Jill Allan on 27/09/2024.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

extension CLLocationCoordinate2D: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let coordinate = try container.decode(CLLocationCoordinate2D.self)
        self = coordinate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
    }
}

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D: @retroactive Comparable {
    public static func <(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude < rhs.latitude && lhs.longitude < rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    static func defaultCoordinate() -> Self {
        CLLocationCoordinate2D(latitude: 51.5, longitude: 0)
    }

    static func calculateCentre(of coordinates: [CLLocationCoordinate2D]) -> Self {
        let latitude = Double.midRange(of: coordinates.map(\.latitude)) ?? 0.0
        let longitude = Double.midRange(of: coordinates.map(\.longitude)) ?? 0.0
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func calculateRegion(metersSpan: Double) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: self, latitudinalMeters: 50, longitudinalMeters: 50)
        
    }
}

extension CLLocationCoordinate2D {
    init(from coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

extension CLLocationCoordinate2D {
    var region: MKCoordinateRegion {
        let Span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        return MKCoordinateRegion(center: self, span: Span)
    }
    
    var mapCameraPosition: MapCameraPosition {
        MapCameraPosition.region(region)
    }
}
