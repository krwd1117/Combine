//
//  Weather.swift
//  Weather
//
//  Created by Jeongwan Kim on 2022/07/21.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {

    let temp: Double?
    let humidity: Double?
    
    // 날씨를 가져올 수 없는 경우(도시 이름을 잘못 입력했거나..)에 nil을 표시해주기 위해 사용
    static var placeHolder: Weather {
        Weather(temp: nil, humidity: nil)
    }
    
}

//{
//  "coord": {
//    "lon": -122.08,
//    "lat": 37.39
//  },
//  "weather": [
//    {
//      "id": 800,
//      "main": "Clear",
//      "description": "clear sky",
//      "icon": "01d"
//    }
//  ],
//  "base": "stations",
//  "main": {
//    "temp": 282.55,
//    "feels_like": 281.86,
//    "temp_min": 280.37,
//    "temp_max": 284.26,
//    "pressure": 1023,
//    "humidity": 100
//  },
//  "visibility": 10000,
//  "wind": {
//    "speed": 1.5,
//    "deg": 350
//  },
//  "clouds": {
//    "all": 1
//  },
//  "dt": 1560350645,
//  "sys": {
//    "type": 1,
//    "id": 5122,
//    "message": 0.0139,
//    "country": "US",
//    "sunrise": 1560343627,
//    "sunset": 1560396563
//  },
//  "timezone": -25200,
//  "id": 420006353,
//  "name": "Mountain View",
//  "cod": 200
//  }

