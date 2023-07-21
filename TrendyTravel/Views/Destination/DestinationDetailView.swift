//
//  DestinationDetailView.swift
//  TrendyTravel
//
//  Created by Jonathan Duong on 17/07/2023.
//

import SwiftUI
import MapKit

struct DestinationDetailView: View {
    @ObservedObject var vm: DestinationViewModel
    let destination: Destination
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = true
    
    init(destination: Destination) {
        self.destination = destination
        self.region = MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.07, longitudeDelta: 0.07))
        self.vm = .init()
    }
    
    func activityImages(destination: Destination) -> [String] {
        var images: [String] = []
        guard let activities = destination.activities else { return [] }
        for activity in activities {
            images.append(activity.imageName)
        }
        return images
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            CarouselHeaderView(images: activityImages(destination: destination))
                .frame(height: 250)
            HStack {
                VStack(alignment: .leading) {
                    Text(destination.city)
                        .font(.system(size: 18, weight: .bold))
                    Text(destination.country)
                }
                Spacer()
                HStack {
                    ForEach(0..<5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
            }
            .padding(.horizontal)
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Button(action: {
                    isShowingAttractions.toggle()
                }) {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                        .font(.system(size: 12, weight: .semibold))
                }
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
            }
            .padding()
            if let activities = self.destination.activities {
                Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? activities : []) { activity in
                    MapAnnotation(coordinate: .init(latitude: activity.latitude, longitude: activity.longitude)) {
                        NavigationLink {
                            ActivityDetailsView(selectedActivity: activity)
                        } label: {
                            CustomMapAnnotation(activity: activity)
                        }
                    }
                }
                .frame(height: 300)
            }
        }
        .navigationBarTitle(destination.city, displayMode: .inline)
    }
}

struct PopularDestinationsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationDetailView(destination: .init(id: 0, country: "", city: "", imageName: "", latitude: 0.0, longitude: 0.0, activities: []))
    }
}
