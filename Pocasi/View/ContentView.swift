//
//  ContentView.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 10.04.2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
   @StateObject private var contentModel = ContentViewModel()
    
    var body: some View{
        NavigationView{
            Map(coordinateRegion: $contentModel.mapView, annotationItems: contentModel.locations) {
                location in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    NavigationLink {
                        DetailView(location: location)
                    } label: {
                        VStack{
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.red)
                            Text(location.name)
                                .foregroundColor(.primary)
                                .font(.caption)
                        }
                    }

                }
            }
            
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


