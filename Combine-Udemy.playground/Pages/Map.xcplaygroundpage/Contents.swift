import Combine
import UIKit
/*
 Map 이란?
 - 시퀀스의 개수만큼 반복
 */

let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

// 1. publisher 생성
let publisher = [123, 45, 678].publisher

publisher
    // 2. 시퀀스의 요소 개수 만큼 반복
    .map {
        formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""}
    // 3. 출력
    .sink {
        print($0)
    }

/* 출력 결과
 one hundred twenty-three
 forty-five
 six hundred seventy-eight
 */
