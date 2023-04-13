//
//  ContentViewModel.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 13.04.2023.
//

import Foundation
import MapKit

class ContentViewModel: ObservableObject {
    @Published var mapView = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.743706, longitude: 15.339102), span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    let locations = [
    Locations(name: "Ostrava", latitude: 49.850985, longitude: 18.305372),
    Locations(name: "Praha", latitude: 50.083494, longitude: 14.422015),
    Locations(name: "Seninka", latitude: 49.273094, longitude: 17.964949),
    Locations(name: "Kvetoslavov", latitude: 48.056509, longitude: 17.351368)
    ]
}
