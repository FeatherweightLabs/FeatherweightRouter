import XCTest
@testable import FeatherweightRouter

class RouterRouteTests: XCTestCase {

    enum Presentable {
        case none, invalid
        case presentable, route, child1, child2, nestedChild
    }

    typealias TestRouter = Router<Presentable, Presentable>

    var route: TestRouter!
    var child = Presentable.none
    var children = [Presentable]()

    override func setUp() {
        super.setUp()

        child = Presentable.none
        children = [Presentable]()

        route = TestRouter(Presenter(
            getPresentable: { .presentable },
            setChild: { self.child = $0 },
            setChildren: { self.children = $0 }))

            .route(predicate: { $0 == .route }, children: [

                TestRouter(Presenter(getPresentable: { .child1 }))
                    .route(predicate: { $0 == .child1 }),

                TestRouter(Presenter(getPresentable: { .child2 }))
                    .route(predicate: { $0 == .child2 }, children: [

                        TestRouter(Presenter(getPresentable: { .nestedChild }))
                            .route(predicate: { $0 == .nestedChild }),
                        ]),
                ])
    }

    override func tearDown() {
        route = nil
        child = .none
        children = []
        super.tearDown()
    }

    func testHandlesRoutes() {
        XCTAssertFalse(route.handlesRoute(.none))
        XCTAssertFalse(route.handlesRoute(.invalid))
        XCTAssert(route.handlesRoute(.route))
        XCTAssert(route.handlesRoute(.child1))
        XCTAssert(route.handlesRoute(.child2))
        XCTAssert(route.handlesRoute(.nestedChild))
    }

    func testSetRouteDoesNothing() {
        XCTAssertFalse(route.setRoute(.invalid))
        XCTAssertEqual(child, Presentable.none)
        XCTAssertEqual(children, [Presentable]())
    }

    func testGetStack() {
        let testValues: [(Presentable, [Presentable])] = [
            (.route, [.presentable]),
            (.child1, [.presentable, .child1]),
            (.child2, [.presentable, .child2]),
            (.nestedChild, [.presentable, .child2, .nestedChild]),
        ]
        for (path, stack) in testValues {
            XCTAssertEqual(route.getStack(path)!, stack)
        }
    }
}
