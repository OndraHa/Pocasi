//
//  ContentView.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 10.04.2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapView = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.743706, longitude: 15.339102), span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    var body: some View{
        
    Map(coordinateRegion: $mapView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//https://api.openweathermap.org/data/3.0/onecall?lat=49.8209&lon=18.2625&exclude=minutely,hourly,alerts&appid=5a5769988061d2a4b575a39b6c9e3a99&units=metric
