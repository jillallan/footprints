//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 03/09/2024.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    var tripList: Namespace.ID
    @State private var aspectRatio: CGFloat = 0
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.deviceType) private var deviceType

    var body: some View {
        let _ = print(aspectRatio)

        VStack {
            Map()
//            Text("\(trip.title)")
//                .foregroundStyle(Color.white)
        }
        .if(verticalSizeClass == .regular && horizontalSizeClass == .compact) { map in
            map.safeAreaInset(edge: .bottom) {
                StepView(trip: trip)
                    .frame(height: 400)
            }
        }
        .if(verticalSizeClass == .regular && horizontalSizeClass == .regular) { map in
            map.safeAreaInset(edge: .trailing) {
                StepView(trip: trip)
                    .frame(width: 400)
            }
        }
        .if(verticalSizeClass == .compact && horizontalSizeClass == .compact) { map in
            map.safeAreaInset(edge: .trailing) {
                StepView(trip: trip)
                    .frame(width: 400)
            }
        }
        .navigationTitle(trip.title)
#if !os(macOS)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarVisibility(deviceType == .pad ? .visible : .hidden, for: .tabBar)
#elseif os(macOS)
    .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
#endif
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .date)
        }
        .onGeometryChange(for: CGRect.self) { proxy in
            proxy.frame(in: .global)
        } action: { newValue in
            aspectRatio = newValue.width / newValue.height
        }



#if os(macOS)
        .navigationTransition(.automatic)
#else
        .navigationTransition(.zoom(sourceID: trip.id, in: tripList))
#endif
        
    }
}

#Preview(traits: .previewData) {
    @Previewable @Namespace var namespace

    TabView {
        Tab("Trips", systemImage: "suitcase") {
            NavigationStack {
                TripDetailView(trip: .bedminsterToBeijing, tripList: namespace)
            }
        }
    }
    .tabViewStyle(.sidebarAdaptable)

}
