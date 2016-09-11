import XCTest
@testable import FeatherweightRouter

class RouterJunctionTests: XCTestCase {

    enum Presentable {
        case none, router, junction1, junction2, nestedChild
    }

    typealias TestRouter = Router<Presentable, Presentable>

    var router: TestRouter!
    var junction1: TestRouter!
    var junction2: TestRouter!
    var child = Presentable.none
    var children = [Presentable]()

    override func setUp() {
        super.setUp()
        let nestedChild = TestRouter(Presenter(getPresentable: { .nestedChild }))
            .route(predicate: { $0 == .nestedChild })
        junction1 = TestRouter(Presenter(getPresentable: { .junction1 }))
            .route(predicate: { $0 == .junction1 }, children: [nestedChild])
        junction2 = TestRouter(Presenter(getPresentable: { .junction2 }))
            .route(predicate: { $0 == .junction2 })

        child = Presentable.none
        children = [Presentable]()

        router = TestRouter(Presenter(
            getPresentable: { .router },
            setChild: { self.child = $0 },
            setChildren: { self.children = $0 }))
            .junction([junction1, junction2])
    }

    func testOnlyHandlesChildRoutes() {
        XCTAssert(router.handlesRoute(.junction1))
        XCTAssert(router.handlesRoute(.junction2))
        XCTAssert(router.handlesRoute(.nestedChild))
        XCTAssertFalse(router.handlesRoute(.router))
        XCTAssertFalse(router.handlesRoute(.none))
    }

    func testHandlesRouteDoesntCallPresenters() {
        XCTAssert(router.handlesRoute(.nestedChild))

        XCTAssert(router.presentable == .router)
        XCTAssert(child == .none)
        XCTAssert(children == [])
    }

    func testSetRoute() {
        for path: Presentable in [.junction1, .junction2] {
            XCTAssert(router.setRoute(path))
            XCTAssert(child == path)
            XCTAssert(children == [.junction1, .junction2])
        }
    }

    func testSetNestedRoute() {
        XCTAssert(router.setRoute(.nestedChild))
        XCTAssert(child == .junction1)
        XCTAssert(children == [.junction1, .junction2])
    }

    func testSetRouteWithUnhandledRoutes() {
        XCTAssertFalse(router.setRoute(.router))
        XCTAssertFalse(router.setRoute(.none))
    }

    func testSetRouteAlwaysCallsSetChildren() {
        XCTAssertFalse(router.setRoute(.router))
        XCTAssert(child == .none)
        XCTAssert(children == [.junction1, .junction2])
    }

}
