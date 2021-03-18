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
    var selfGrowth: Development?
    var skills: Set<String> = []

    func learnCourse(from name: CourseName) {
        let course = selfGrowth?.getCourses().filter { $0.name == name }.first!
        skills.insert((course?.skill.rawValue)!)
    }
}

class Injector {
    static func provideImprovement() -> Development {
        return Improvement()
    }
}

let fadhil = Engineer()
    fadhil.selfGrowth = Injector.provideImprovement()
    fadhil.learnCourse(from: .webDevelopment)
