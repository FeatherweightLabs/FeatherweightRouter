import XCTest
@testable import FeatherweightRouter

class RouterTests: XCTestCase {

    struct DummyPresenter {
        let name: String
    }

    typealias TestRouter = Router<DummyPresenter>
    typealias TestPresenter = Presenter<DummyPresenter>

    var testName: String!
    var dummyPresentable: DummyPresenter!
    var dummyPresenter: TestPresenter!
    var testRouter: TestRouter!

    override func setUp() {
        super.setUp()
        testName = String(arc4random_uniform(100))
        dummyPresentable = DummyPresenter(name: testName)
        dummyPresenter = Presenter(getPresentable: { self.dummyPresentable })
        testRouter = Router(dummyPresenter)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreation() {
        XCTAssertEqual(testRouter.presentable.name, testName)
    }
}
