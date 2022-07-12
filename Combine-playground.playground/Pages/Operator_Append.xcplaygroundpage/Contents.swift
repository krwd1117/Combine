import Combine
import Foundation

// MARK: - Append(Sequence)

// 1. 값을 방출하는 publisher
let publisher = [3, 4].publisher

// 2. append로 값을 붙여줌
publisher
    .append([5, 6])
    .sink(receiveValue: {print($0)})

// MARK: - Append(Publisher)

// 1. 두개의 publisher를 생성
let publisher2 = [1, 2].publisher
let publisher3 = [3, 4].publisher

// 2. publisher3을 publisher2에 추가
publisher2
    .append(publisher3)
    .sink(receiveValue: {print($0)})
