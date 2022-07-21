//
//  WebService.swift
//  Weather
//
//  Created by Jeongwan Kim on 2022/07/21.
//

import Foundation
import Combine

class WebService {
    
    func fetchWeather(city: String) -> AnyPublisher<Weather, Error>  {
        
        guard let url = URL(string: Constants.URLs.weather(city: city)) else {
            fatalError("URL 오류")
        }
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//        }.resume()
        
        return URLSession.shared.dataTaskPublisher(for: url)
            // URLSession을 통해 가져온 데이터
            .map { $0.data }
            // 가져온 데이터를 디코딩
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            // 디코딩한 값
            .map { $0.main }
            // 메인 쓰레드에서 받아라
            .receive(on: RunLoop.main)
            // erase 필수
            .eraseToAnyPublisher()
    }
}
