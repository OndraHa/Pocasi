//
//  DetailView.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 11.04.2023.
//

import SwiftUI

struct DetailView: View {
    let location: Locations
    var body: some View {
        Text(location.name)
        Text("\(location.latitude)")
        Text("\(location.longitude)")
    }
    func dataDownload(lat: Double, lon: Double){
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,alerts&appid=\(APIkey.appID)&units=metric"
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Locations(name: "Ostrava", latitude: 49.850985, longitude: 18.305372)
        DetailView(location: bs)
    }
}
