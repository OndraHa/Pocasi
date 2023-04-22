//
//  DetailView.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 11.04.2023.
//

import SwiftUI


struct DetailView: View {
    @StateObject private var detailModel = DetailViewModel()
    @State var forecastB = 0
    
    
    let location: Locations
   
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("\(Date.now, format: .dateTime.day().month().year())")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                Text(detailModel.czkDescription)
                    .font(.system(size: 35))
                    .padding(.bottom, -30)
                
                Text("\(Int(detailModel.weatherResultCurrent?.main.temp ?? 0))°C")
                    .font(.system(size: 65))
                    .fontWeight(.black)
                
                Text("Pocitová teplota \(Int(detailModel.weatherResultCurrent?.main.feels_like ?? 0))°C")
                    .padding(.bottom, 50)
                    .padding(.top, -40)
                    .foregroundColor(.gray)
                
                
                
//                if forecastB == 0 {
//                    var daysF = days.filter {detailModel.dayWeek($0.dt).contains("")}
//                }else {
//                     var daysF = days
//                }
                
               
                Picker("Typ předpovědi", selection: $forecastB) {
                                Text("3h předpověď").tag(0)
                                Text("Denní předpověď").tag(1)
                            }
                            .pickerStyle(.segmented)
                            .padding(5)
                
                
                if forecastB == 1{
                    if let days = detailModel.weatherResultForecast?.list.filter{detailModel.dayWeek($0.dt).contains("11:00 Dop.")} {
                        
                        ForEach(days, id: \.dt) { day in
                            
                            HStack{
                                Text("\(detailModel.dayWeek(day.dt))")
                                    .frame(width: 110, alignment: .leading)
                                
                                Spacer()
                                
                                
                                Image(systemName: detailModel.icon[day.weather.first!.icon] ?? "exclamationmark.square")
                                    .symbolRenderingMode(.multicolor)
                                
                                
                                Spacer()
                                
                                Text("\(Int(day.main.temp))°C")
                                    .frame(width: 60, alignment: .trailing)
                            }
                            .padding(.bottom, 3)
                            Divider()
                        }
                    }
                    
                }else{
                    if let days = detailModel.weatherResultForecast?.list {
                        
                        ForEach(days, id: \.dt) { day in
                            
                            HStack{
                                Text("\(detailModel.dayWeek(day.dt))")
                                    .frame(width: 110, alignment: .leading)
                                
                                Spacer()
                                
                                
                                Image(systemName: detailModel.icon[day.weather.first!.icon] ?? "exclamationmark.square")
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
        }
        .padding(20)
        .navigationTitle(location.name)
            .onAppear{
                detailModel.dataDownload(lat: location.latitude, lon: location.longitude)
            }
    }
   
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Locations(name: "Ostrava", latitude: 49.850985, longitude: 18.305372)
        DetailView(location: bs)
    }
}
