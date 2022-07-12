import UIKit
import Combine

struct Point {
    let x: Int
    let y: Int
}

/*
 MapKeyPath란?
 - Map과 keyPath가 결합됨
 */

let publisher = PassthroughSubject<Point, Never>()

publisher
    .map(\.x, \.y)
    .sink { x, y in
        print("x is value: \(x), y is value: \(y)")
    }

publisher.send(Point(x: 1, y: 2))

/* 출력 결과
 x is value: 1, y is value: 2
 */
