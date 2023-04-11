//
//  Locations.swift
//  Pocasi
//
//  Created by Ondřej Hadraba on 11.04.2023.
//

import Foundation

struct Locations: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
