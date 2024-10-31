//
//  LocationSearch.swift
//  Footprints
//
//  Created by Jill Allan on 20/10/2024.
//

import SwiftUI

struct LocationSearch: View {
    let step: Step?
    
    var body: some View {
        if let step {
            Form {
                Section {
                    Text(step.stepTitle)
                } header: {
                    Text("Name")
                }
                Section {
                    Text(step.placemark?.pointOfInterestCategory ?? "No placemark")
                } header: {
                    Text("Category")
                }
                Section {
                    Text(step.placemark?.firstLineOfAddress ?? "No placemark")
                    Text(step.placemark?.localitySublocality ?? "No placemark")
                    Text(step.placemark?.administrativeAreaSubAdministrativeArea ?? "No placemark")
                    Text(step.placemark?.postalCode ?? "No placemark")
                } header: {
                    Text("Address")
                }
                Section {
                    Text(step.placemark?.country ?? "No placemark")
                } header: {
                    Text("Country")
                }
                Section {
                    Text(step.placemark?.areaOfInterest ?? "No placemark")
                } header: {
                    Text("Area of interest")
                }
                Section {
                    Text(step.placemark?.geography ?? "No placemark")
                } header: {
                    Text("Area of interest")
                }
            }
        }
    }
}

#Preview("St Johns Lane", traits: .previewData) {
    LocationSearch(step: .stJohnsLane)
}

#Preview("Atomium", traits: .previewData) {
    LocationSearch(step: .atomium)
}

#Preview("everest", traits: .previewData) {
    LocationSearch(step: .everestBaseCamp)
}

#Preview("Statue of Liberty", traits: .previewData) {
    LocationSearch(step: .statueOfLiberty)
}

#Preview("Bedminster Station", traits: .previewData) {
    LocationSearch(step: .bedminsterStation)
}

#Preview("Temple meads", traits: .previewData) {
    LocationSearch(step: .templeMeads)
}

#Preview("New step", traits: .previewData) {
    LocationSearch(step: .atomium)
}