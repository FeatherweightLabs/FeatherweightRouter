import XCTest
@testable import FeatherweightRouter

class RouterTests: XCTestCase {

    struct DummyPresenter {
        let name: String
    }

    typealias TestRouter = Router<DummyPresenter>
    typealias TestRouterDelegate = RouterDelegate<DummyPresenter>

    var testName: String!
    var dummyPresenter: DummyPresenter!
    var dummyDelegate: TestRouterDelegate!
    var testRouter: TestRouter!

    override func setUp() {
        super.setUp()
        testName = String(arc4random_uniform(100))
        dummyPresenter = DummyPresenter(name: testName)
        dummyDelegate = RouterDelegate(getPresenter: { self.dummyPresenter })
        testRouter = Router(delegate: dummyDelegate)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreation() {
        XCTAssertEqual(testRouter.presenter.name, testName)
    }

}
