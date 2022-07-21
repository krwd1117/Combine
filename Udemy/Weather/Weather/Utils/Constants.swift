//
//  Constants.swift
//  Weather
//
//  Created by Jeongwan Kim on 2022/07/21.
//

import Foundation

struct Constants {
    
    struct URLs {
        static func weather(city: String) -> String {
            "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=07c19f8b04264f1bf6aeb840a5f8e47d&units=imperial"
        }
        // celsius = metric
        
    }
    
    
}
