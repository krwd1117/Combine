//
//  ViewController.swift
//  Weather
//
//  Created by Jeongwan Kim on 2022/07/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private let webService = WebService()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupPublishers()
        
        /*
         // cancellabel이 있어야 실행을 한다. urlSession의 resume같은 느낌인듯?
         // AnyCancellable을 해줘야 메모리 누수가 발생하지 않음
         cancellable = webService.fetchWeather(city: "Seoul")
         // catch 는 에러 발생시 어떤 행위를 할것인지 설정한다.
         // 여기서는 에러 발생시 Just를 통해 Weather의 plceHolder를 방출한다.
         .catch { _ in Just(Weather.placeHolder) }
         .map { weather in
         // optional 풀기
         if let temp = weather.temp {
         return "\(temp)°F"
         } else {
         return "날씨 오류"
         }
         // on에 해당하는 요소에 to를 주입한다.
         }.assign(to: \.text, on: temperatureLabel)
         */
        
    }
    
    /// 텍스트 필드의 값이 변경됨을 감지해야 하므로
    /// NotificationCenter를 통해 publisher를 생성한다.
    private func setupPublishers() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
        
        
        // nil은 필요 없으므로 compactMap
        cancellable = publisher.compactMap {
            // UITextField의 값을 감지하므로 UITextField로 캐스팅
            ($0.object as! UITextField).text?
            // 공백을 포함할 수도 있으므로 addingPercentEncoding을 사용한다.
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            // 입력 즉시 반응하는 것이 아닌, 입력 후 일정 시간 뒤 메서드를 실행시키기 위해 사용
        }.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .flatMap { city in
                return self.webService.fetchWeather(city: city)
//                    // 오류가 발생하면 빈 값을 반환
//                    .catch { _ in Empty() }
                    // 오류가 발생하면 Weather의 placeHolder 반환
                    .catch { _ in Just(Weather.placeHolder) }
                    // 성공시 반환받은 날씨 모델
                    .map { $0 }
        }.sink {
            
            guard let temp = $0.temp else {
                return self.temperatureLabel.text = ""
            }
            
            self.temperatureLabel.text = "\(temp)°F"
        }
    }
}

