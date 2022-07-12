import Combine
import Foundation

/*
 collect 란?
 - 시퀀스를 수집하고 배열로 반환한다.
 */

// 1. publisher 생성
let publisher = ["A", "B", "C", "D"].publisher

publisher
    // 2. 시퀀스를 수집하여 배열로 반환
    .collect()
    // 3. 출력
    .sink {
    print($0)
}

/* 출력 결과
 ["A", "B", "C", "D"]
 */

publisher
    // 2. 몇개의 요소로 한개의 배열로 만들건지
    .collect(3)
    // 3. 출력
    .sink {
    print($0)
}

/* 출력 결과
 ["A", "B", "C"]
 ["D"]
 */
