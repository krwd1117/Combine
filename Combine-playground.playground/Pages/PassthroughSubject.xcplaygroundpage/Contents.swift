import Foundation
import Combine

/*
 Subject란?
 - send(_:)를 통해 stream에 값을 주입할 수 있는 publisher
 
 PassthroughSubject란?
 - subscriber에게 element를 broadcast하는 subject
 
 CurrentValueSubject란?
 - PassthroughSubject와 달리 초기값과 최근에 발행된 element에 대한 buffer를 갖는다
 */

// MARK: - PassthroughSubject

// 1. String과 Never 타입의 PassthroughSubject 객체 생성
let subject = PassthroughSubject<String, Never>()

// 2. sink를 이용해 subscription1 생성
let subscription1 = subject.sink { completion in
    print("Received completion(1)", completion)
} receiveValue: { value in
    print("Received value(1)", value)
}

// 3. sink를 이용해 subscription2 생성
let subscription2 = subject.sink { completion in
    print("Received completion(2)", completion)
} receiveValue: { value in
    print("Received value(2)", value)
}

// 4. 외부에서 값 주입
subject.send("안녕")
subject.send("반가워")

/* 출력 결과
 Received value(1) 안녕
 Received value(2) 안녕
 Received value(1) 반가워
 Received value(2) 반가워
 */

// 5. 구독 취소
subscription1.cancel()

// 6. 다른 값 주입
subject.send("Still there?")

/* 출력 결과
 Received value(1) 안녕
 Received value(2) 안녕
 Received value(1) 반가워
 Received value(2) 반가워
 
 Received value(2) Still there?
 */

// 7. finished 라는 완료 이벤트 주입
subject.send(completion: .finished)

// 8. 새로운 값 주입
subject.send("How about another one?")

/* 출력 결과
 Received value(2) 안녕
 Received value(1) 안녕
 Received value(2) 반가워
 Received value(1) 반가워
 Received value(2) Still there?
 Received completion(2) finished
 */
