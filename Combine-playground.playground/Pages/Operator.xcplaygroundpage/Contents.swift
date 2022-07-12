import Foundation
import Combine

/*
 Operator란?
 - publisher가 방출하는 값을 결합한다.
 */

// 1. 3과 4를 방출하는 publisher
let publisher = [3, 4].publisher

publisher
    // 2. prepend를 통해 publisher의 고유 값 앞에 1과 2를 붙여준다.
    .prepend(1, 2)
    // 3. prepend를 통해 -1, 0 을 붙여준다.
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
