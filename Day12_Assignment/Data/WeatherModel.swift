//
//  WeatherModel.swift
//  Day12_Assignment
//
//  Created by Rayaheen Mseri on 17/09/1446 AH.
//

import SwiftUI

struct WeatherModel: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main: Codable {
    let temp : Double
}

struct Weather: Codable {
    let description : String
    let icon : String
}
