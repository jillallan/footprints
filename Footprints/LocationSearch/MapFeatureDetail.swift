//
//  MapItemDetail.swift
//  Footprints
//
//  Created by Jill Allan on 04/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct MapFeatureDetail: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MapFeatureDetail.self)
    )
    
    @State private var loadingState = LoadingState.loading
    @State private var mapItem: MKMapItem?
    let mapFeature: MapFeature
    
    var body: some View {
        NavigationStack {
            VStack {
                switch loadingState {
                case .empty:
                    EmptyView()
                case .loading:
                    MapItemLoadingView(title: mapFeature.title ?? "Location")
                        .navigationTitle(mapFeature.title ?? "Location")
                case .success:
                    if let mapItem {
                        MapItemSuccessView(mapItem: mapItem)
                            
                    }
                    
                case .failed:
                    MapItemFailedView()
                }
            }
            .navigationTitle(mapItem?.name ?? "No name")
            
        }
        .onAppear {
            Task {
                mapItem = await fetchMapItem(for: mapFeature)
            }
        }
        .onChange(of: mapFeature) {
            Task {
                mapItem = await fetchMapItem(for: mapFeature)
            }
        }
    }
    
    func fetchMapItem(for mapFeature: MapFeature) async -> MKMapItem? {
        let request = MKMapItemRequest(feature: mapFeature)
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await request.mapItem
            loadingState = .success
        } catch let error {
            logger.error("Getting map item from identifier failed. Error: \(error.localizedDescription)")
            loadingState = .failed
        }
        return mapItem
    }
}

//#Preview {
//    MapItemDetail()
//}