import Swinject

final class AppInjector {

    static let shared = AppInjector.resolved()
    static var container = Container()
    static var assemblies: [Assembly] = []

    private static func resolved() -> Resolver {
        let assembler = Assembler(self.assemblies, container: self.container)
        return assembler.resolver
    }
}
