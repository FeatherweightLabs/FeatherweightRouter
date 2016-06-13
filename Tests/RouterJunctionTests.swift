import XCTest
@testable import FeatherweightRouter

class RouterJunctionTests: XCTestCase {

    enum Presentable {
        case None, Router, Junction1, Junction2, NestedChild
    }

    typealias TestRouter = Router<Presentable, Presentable>

    var router: TestRouter!
    var junction1: TestRouter!
    var junction2: TestRouter!
    var child = Presentable.None
    var children = [Presentable]()

    override func setUp() {
        super.setUp()
        let nestedChild = TestRouter(Presenter(getPresentable: { .NestedChild }))
            .route(predicate: { $0 == .NestedChild })
        junction1 = TestRouter(Presenter(getPresentable: { .Junction1 }))
            .route(predicate: { $0 == .Junction1 }, children: [nestedChild])
        junction2 = TestRouter(Presenter(getPresentable: { .Junction2 }))
            .route(predicate: { $0 == .Junction2 })

        child = Presentable.None
        children = [Presentable]()

        router = TestRouter(Presenter(
            getPresentable: { .Router },
            setChild: { self.child = $0 },
            setChildren: { self.children = $0 }))
            .junction([junction1, junction2])
    }

    func testOnlyHandlesChildRoutes() {
        XCTAssert(router.handlesRoute(.Junction1))
        XCTAssert(router.handlesRoute(.Junction2))
        XCTAssert(router.handlesRoute(.NestedChild))
        XCTAssertFalse(router.handlesRoute(.Router))
        XCTAssertFalse(router.handlesRoute(.None))
    }

    func testHandlesRouteDoesntCallPresenters() {
        XCTAssert(router.handlesRoute(.NestedChild))

        XCTAssert(router.presentable == .Router)
        XCTAssert(child == .None)
        XCTAssert(children == [])
    }

    func testSetRoute() {
        for path: Presentable in [.Junction1, .Junction2] {
            XCTAssert(router.setRoute(path))
            XCTAssert(child == path)
            XCTAssert(children == [.Junction1, .Junction2])
        }
    }

    func testSetNestedRoute() {
        XCTAssert(router.setRoute(.NestedChild))
        XCTAssert(child == .Junction1)
        XCTAssert(children == [.Junction1, .Junction2])
    }

    func testSetRouteWithUnhandledRoutes() {
        XCTAssertFalse(router.setRoute(.Router))
        XCTAssertFalse(router.setRoute(.None))
    }

    func testSetRouteAlwaysCallsSetChildren() {
        XCTAssertFalse(router.setRoute(.Router))
        XCTAssert(child == .None)
        XCTAssert(children == [.Junction1, .Junction2])
    }

}
