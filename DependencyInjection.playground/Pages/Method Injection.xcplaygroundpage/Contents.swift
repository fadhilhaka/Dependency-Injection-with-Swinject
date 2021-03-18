enum CourseName: String {
    case androidDevelopment, iOSDevelopment, webDevelopment
}

enum Skill: String {
    case swift, kotlin, javascript
}
struct Course {
    let name: CourseName
    let skill: Skill
}

protocol Development {
    func getCourses() -> [Course]
}

class Improvement: Development {
    let companyCourses: [Course] = [Course(name: .androidDevelopment, skill: .kotlin),
                                    Course(name: .iOSDevelopment, skill: .swift),
                                    Course(name: .webDevelopment, skill: .javascript)]
    
    func getCourses() -> [Course] {
        companyCourses
    }
}

class Engineer {
    var skills: Set<String> = []

    func learnCourse(from name: CourseName, using improvement: Development) {
        let course = improvement.getCourses().filter { $0.name == name }.first!
        skills.insert((course.skill.rawValue))
    }
}

class Injector {
    static func provideImprovement() -> Development {
        return Improvement()
    }
}

let fadhil = Engineer()
    fadhil.learnCourse(from: .webDevelopment, using: Injector.provideImprovement())
