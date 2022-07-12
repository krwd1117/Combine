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

// MARK: - CurrentValueSubject

// 여러 subscription을 저장하 수 있음
// 저장된 subscription들은 해당 set이 해제될 때 자동으로 취소됨
var subscrptions = Set<AnyCancellable>()

// 1. Int와 Never를 갖는 CurrentValueSubject 생성
// 1-1. CurrentValueSubject는 초기값 필수
let subject = CurrentValueSubject<Int, Never>(0)

// 2. sink를 통해 subject를 구독
// Failure type이 Never이므로 receiveCompletion 생략 가능
subject
    .sink(receiveValue: { print($0) })
    // PassthroughSubject 에서 처리했던 .cancel()의 역할
    .store(in: &subscrptions)

subject.send(1)
subject.send(2)
print(subject.value)

/* 출력 결과
 0 // 초기 값
 1 // subject.send(1)
 2 // subject.send(2)
 2 // subject.value
 */

subject.value = 3
/*
 0
 1
 2
 2
 3 // 직접 주입한 값
 */

// 완료 이벤트 발행
subject.send(completion: .finished)
