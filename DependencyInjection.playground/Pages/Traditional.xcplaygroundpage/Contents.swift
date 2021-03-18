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

class Improvement {
    let companyCourses: [Course] = [Course(name: .androidDevelopment, skill: .kotlin),
                                    Course(name: .iOSDevelopment, skill: .swift),
                                    Course(name: .webDevelopment, skill: .javascript)]
    
    func getCourses() -> [Course] {
        companyCourses
    }
}

class Engineer {
    let selfGrowth = Improvement()
    var skills: Set<String> = []

    func learnCourse(from name: CourseName) {
        let course = selfGrowth.getCourses().filter { $0.name == name }.first!
        skills.insert(course.skill.rawValue)
    }
}

let fadhil = Engineer()
    fadhil.learnCourse(from: .androidDevelopment)
