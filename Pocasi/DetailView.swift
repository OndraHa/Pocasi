//
//  DetailView.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 11.04.2023.
//

import SwiftUI


struct DetailView: View {
    @State private var weatherResult: WeatherMain?
    let location: Locations
    var body: some View {
        Text(location.name)
        Text("\(location.latitude)")
        Text("\(location.longitude)")
        Text("\(weatherResult?.current.temp ?? 0.0)")
            .onAppear{
                dataDownload(lat: location.latitude, lon: location.longitude)
            }
    }
    func dataDownload(lat: Double, lon: Double){
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,alerts&appid=\(APIkey.appID)&units=metric"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Missing data!")
                return
            }
            
            if let json = try? JSONDecoder().decode(WeatherMain.self, from: data){
                weatherResult = json
            }
            
        }
        task.resume()
    }
        
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Locations(name: "Ostrava", latitude: 49.850985, longitude: 18.305372)
        DetailView(location: bs)
    }
}
