import XCTest
@testable import FeatherweightRouter

class RouterStackTests: XCTestCase {

    enum Presentable {
        case none, invalid
        case presentable, route, child1, child2
    }

    typealias TestRouter = Router<Presentable, Presentable>

    var router: TestRouter!
    var child = Presentable.none
    var children = [Presentable]()

    override func setUp() {
        super.setUp()

        child = Presentable.none
        children = [Presentable]()

        router = TestRouter(Presenter(
            getPresentable: { .presentable },
            setChild: { self.child = $0 },
            setChildren: { self.children = $0 }))
            .stack([
                TestRouter(Presenter(getPresentable: { .child1 }))
                    .route(predicate: { $0 == .child1 }),
                TestRouter(Presenter(getPresentable: { .child2 }))
                    .route(predicate: { $0 == .child2 }),
                ])
    }

    override func tearDown() {
        router = nil
        child = .none
        children = []
        super.tearDown()
    }

    func testHandlesRoute() {
        XCTAssertFalse(router.handlesRoute(.presentable))
        XCTAssert(router.handlesRoute(.child1))
        XCTAssert(router.handlesRoute(.child2))
    }

    func testSetRouteInvalid() {
        XCTAssert(router.setRoute(.presentable))
        XCTAssertEqual(child, Presentable.none)
        XCTAssertEqual(children, [Presentable]())
    }

    func testSetPresenterChildNeverCalled() {
        XCTAssert(router.setRoute(.child1))
        XCTAssertEqual(child, Presentable.none)
        XCTAssertEqual(children, [Presentable.child1])
    }

    func testSetRouteValid() {
        XCTAssert(router.setRoute(.child2))
        XCTAssertEqual(children, [Presentable.child2])
    }
}
