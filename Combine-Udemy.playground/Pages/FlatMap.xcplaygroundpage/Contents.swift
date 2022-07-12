import UIKit
import Combine

struct School {
    let name: String
    let noOfStudents: CurrentValueSubject<Int, Never>
    
    init(name: String, noOfStudents: Int) {
        self.name = name
        self.noOfStudents = CurrentValueSubject(noOfStudents)
    }
}

let citySchool = School(name: "Fountain Head School", noOfStudents: 100)
let school = CurrentValueSubject<School, Never>(citySchool)

//school.sink { print($0) }

/* 출력 결과
 School(name: "Fountain Head School", noOfStudents: Combine.CurrentValueSubject<Swift.Int, Swift.Never>)
 */

let townSchool = School(name: "Town Schood", noOfStudents: 45)

school.value = townSchool

/* 출력 결과
 School(name: "Fountain Head School", noOfStudents: Combine.CurrentValueSubject<Swift.Int, Swift.Never>)
 School(name: "Town Schood", noOfStudents: Combine.CurrentValueSubject<Swift.Int, Swift.Never>)
 */

//school
//    .flatMap { $0.noOfStudents }
//    .sink { print($0) }


