import Fluent
import Plot
import Vapor

struct PackageController {
    
    func show(req: Request) throws -> EventLoopFuture<HTML> {
        guard
            let owner = req.parameters.get("owner"),
            let repository = req.parameters.get("repository")
        else {
            return req.eventLoop.future(error: Abort(.notFound))
        }
        return Package.query(on: req.db, owner: owner, repository: repository)
            .map(PackageShow.Model.init(package:))
            .unwrap(or: Abort(.notFound))
            .map { PackageShow.View(path: req.url.path, model: $0).document() }
    }

    func builds(req: Request) throws -> EventLoopFuture<HTML> {
        let model = BuildIndex.Model.mock
        return req.eventLoop.future(BuildIndex.View(path: req.url.path, model: model).document())
    }

}
