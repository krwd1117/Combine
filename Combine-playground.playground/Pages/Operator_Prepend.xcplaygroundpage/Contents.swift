import Foundation
import Combine

/*
 Operator란?
 - publisher가 방출하는 값을 결합한다.
 
 https://sujinnaljin.medium.com/combine-combining-operators-6c5d39d90327
 */

// MARK: Prepend(Sequence)

// 1. 3과 4를 방출하는 publisher
let publisher = [3, 4].publisher

publisher
    // 2. prepend를 통해 publisher의 고유 값 '앞'에 1과 2를 붙여준다.
    .prepend(1, 2)
    // 3. prepend를 통해 '앞'에 -1, 0 을 붙여준다.
    .prepend(-1, 0)
    .sink { print($0) }

/* 출력 결과
 -1 //
 0 // 
 1
 2
 3
 4
 */

let publisher2 = [5, 6, 7].publisher
publisher2
    .prepend([3, 4])
    .prepend(Set(1...2))
    .prepend(stride(from: 6, to: 11, by: 2))
    .sink { print($0) }

/* 출력 결과
 6 // stride
 8 // stride
 10 // stride
 2 // Set 이므로 순서 보장 X
 1 // Set 이므로 순서 보장 X
 3 // prepend
 4 // prepend
 5
 6
 7
 */

// MARK: - Prepend(Publisher)

// 1. 2개의 publisher를 만든다
let publisher3 = [3, 4].publisher
let publisher4 = [1, 2].publisher

// 2. publisher를 결합한다.
publisher3
    .prepend(publisher4)
    .sink { print($0) }

/* 출력 결과
 1
 2
 3
 4
publisher4가 완료된 이후에 publisher3가 방출된다.
 */
