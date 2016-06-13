import XCTest
@testable import FeatherweightRouter

class RouterRouteTests: XCTestCase {

    enum Presentable {
        case None, Invalid
        case Presentable, Route, Child1, Child2, NestedChild
    }

    typealias TestRouter = Router<Presentable, Presentable>

    var route: TestRouter!
    var child = Presentable.None
    var children = [Presentable]()

    override func setUp() {
        super.setUp()

        child = Presentable.None
        children = [Presentable]()

        route = TestRouter(Presenter(
            getPresentable: { .Presentable },
            setChild: { self.child = $0 },
            setChildren: { self.children = $0 }))

            .route(predicate: { $0 == .Route }, children: [

                TestRouter(Presenter(getPresentable: { .Child1 }))
                    .route(predicate: { $0 == .Child1 }),

                TestRouter(Presenter(getPresentable: { .Child2 }))
                    .route(predicate: { $0 == .Child2 }, children: [

                        TestRouter(Presenter(getPresentable: { .NestedChild }))
                            .route(predicate: { $0 == .NestedChild }),
                        ]),
                ])
    }

    override func tearDown() {
        route = nil
        child = .None
        children = []
        super.tearDown()
    }

    func testHandlesRoutes() {
        XCTAssertFalse(route.handlesRoute(.None))
        XCTAssertFalse(route.handlesRoute(.Invalid))
        XCTAssert(route.handlesRoute(.Route))
        XCTAssert(route.handlesRoute(.Child1))
        XCTAssert(route.handlesRoute(.Child2))
        XCTAssert(route.handlesRoute(.NestedChild))
    }

    func testSetRouteDoesNothing() {
        XCTAssertFalse(route.setRoute(.Invalid))
        XCTAssertEqual(child, Presentable.None)
        XCTAssertEqual(children, [Presentable]())
    }

    func testGetStack() {
        let testValues: [(Presentable, [Presentable])] = [
            (.Route, [.Presentable]),
            (.Child1, [.Presentable, .Child1]),
            (.Child2, [.Presentable, .Child2]),
            (.NestedChild, [.Presentable, .Child2, .NestedChild]),
        ]
        for (path, stack) in testValues {
            XCTAssertEqual(route.getStack(path)!, stack)
        }
    }
}
