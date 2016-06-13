import XCTest
@testable import FeatherweightRouter

class RouterStackTests: XCTestCase {

    enum Presentable {
        case None, Invalid
        case Presentable, Route, Child1, Child2
    }

    typealias TestRouter = Router<Presentable, Presentable>

    var router: TestRouter!
    var child = Presentable.None
    var children = [Presentable]()

    override func setUp() {
        super.setUp()

        child = Presentable.None
        children = [Presentable]()

        router = TestRouter(Presenter(
            getPresentable: { .Presentable },
            setChild: { self.child = $0 },
            setChildren: { self.children = $0 }))
            .stack([
                TestRouter(Presenter(getPresentable: { .Child1 }))
                    .route(predicate: { $0 == .Child1 }),
                TestRouter(Presenter(getPresentable: { .Child2 }))
                    .route(predicate: { $0 == .Child2 }),
                ])
    }

    override func tearDown() {
        router = nil
        child = .None
        children = []
        super.tearDown()
    }

    func testHandlesRoute() {
        XCTAssertFalse(router.handlesRoute(.Presentable))
        XCTAssert(router.handlesRoute(.Child1))
        XCTAssert(router.handlesRoute(.Child2))
    }

    func testSetRouteInvalid() {
        XCTAssert(router.setRoute(.Presentable))
        XCTAssertEqual(child, Presentable.None)
        XCTAssertEqual(children, [Presentable]())
    }

    func testSetPresenterChildNeverCalled() {
        XCTAssert(router.setRoute(.Child1))
        XCTAssertEqual(child, Presentable.None)
        XCTAssertEqual(children, [Presentable.Child1])
    }

    func testSetRouteValid() {
        XCTAssert(router.setRoute(.Child2))
        XCTAssertEqual(children, [Presentable.Child2])
    }
}
