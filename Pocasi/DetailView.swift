//
//  DetailView.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 11.04.2023.
//

import SwiftUI


struct DetailView: View {
    @State private var weatherResultCurrent: WeatherMain?
    @State private var weatherResultForecast: WeatherForecast?
    let location: Locations
    let icon = [
        "01d": "sun.max.fill",
        "01n": "sun.max.fill",
        "02d": "cloud.sun.fill",
        "02n": "cloud.sun.fill",
        "03d": "cloud.fill",
        "03n": "cloud.fill",
        "04d": "smoke.fill",
        "04n": "smoke.fill",
        "09d": "cloud.sun.rain.fill",
        "09n": "cloud.sun.rain.fill",
        "10d": "cloud.heavyrain.fill",
        "10n": "cloud.heavyrain.fill",
        "11d": "cloud.bolt.fill",
        "11n": "cloud.bolt.fill",
        "13d": "cloud.snow.fill",
        "13n": "cloud.snow.fill",
        "50d": "text.alingcenter",
        "50n": "text.alingcenter"
        
    ]
    
    var czkDescription: String {
        switch weatherResultCurrent?.weather.first?.main {
        case "Clear":
            return "Jasno"
        case "Clouds":
            return "Oblačno"
        case "Thunderstorm":
            return "Bouřka"
        case "Drizzle":
            return "Mrholení"
        case "Rain":
            return "Déšť"
        case "Snow":
            return "Sněžení"
        default:
            return "..."
            
        }
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("\(Date.now, format: .dateTime.day().month().year())")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                Text(czkDescription)
                    .font(.system(size: 35))
                    .padding(.bottom, -30)
                
                Text("\(Int(weatherResultCurrent?.main.temp ?? 0))°C")
                    .font(.system(size: 65))
                    .fontWeight(.black)
                
                Text("Pocitová teplota \(Int(weatherResultCurrent?.main.feels_like ?? 0))°C")
                    .padding(.bottom, 50)
                    .padding(.top, -40)
                    .foregroundColor(.gray)
                
                if let day = weatherResultForecast?.list {
                    ForEach(day, id: \.dt) { day in
                        
                        HStack{
                            Text("\(dayWeek(day.dt))")
                                .frame(width: 110, alignment: .leading)
                            
                            Spacer()
                
        
                            Image(systemName: icon[day.weather.first!.icon] ?? "exclamationmark.square")
                                .symbolRenderingMode(.multicolor)
                            
                            
                            Spacer()
                            
                            Text("\(Int(day.main.temp))°C")
                                .frame(width: 60, alignment: .trailing)
                        }
                        .padding(.bottom, 3)
                        Divider()
                    }
                }
                
            }
        }
        .padding(20)
        .navigationTitle(location.name)
            .onAppear{
                dataDownload(lat: location.latitude, lon: location.longitude)
            }
    }
    func dataDownload(lat: Double, lon: Double){
    
        let urlStringWeather = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIkey.appID)&units=metric"
        let url = URL(string: urlStringWeather)!
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
                weatherResultCurrent = json
            }
            
        }
        
        task.resume()
        
        let urlStringWeather2 = "https://api.openweathermap.org/data/2.5/forecast/?lat=\(lat)&lon=\(lon)&appid=\(APIkey.appID)&units=metric"
        let url2 = URL(string: urlStringWeather2)!
        let task2 = URLSession.shared.dataTask(with: url2) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Missing data!")
                return
            }

            if let json = try? JSONDecoder().decode(WeatherForecast.self, from: data){
                weatherResultForecast = json
            }

        }
        task2.resume()
    }
    func dayWeek(_ num: Int) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm")
        let jsonDate = Date(timeIntervalSince1970: TimeInterval(num))
        let dateString = formatter.string(from: jsonDate).capitalized
        return dateString
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Locations(name: "Ostrava", latitude: 49.850985, longitude: 18.305372)
        DetailView(location: bs)
    }
}
