import XCTest
@testable import FeatherweightRouter

class RouterTests: XCTestCase {

//    struct DummyPresenter {
//        let name: String
//    }
//
//    enum Endpoint {
//        case Value1, Value2
//    }
//
//    typealias TestRouter = Router<DummyPresenter, Endpoint>
//    typealias TestPresenter = Presenter<DummyPresenter>
//
//    var testName: String!
//    var dummyPresentable: DummyPresenter!
//    var dummyPresenter: TestPresenter!
//    var testRouter: TestRouter!
//
//    override func setUp() {
//        super.setUp()
//        testName = String(arc4random_uniform(100))
//        dummyPresentable = DummyPresenter(name: testName)
//        dummyPresenter = Presenter(getPresentable: { self.dummyPresentable })
//        testRouter = Router(dummyPresenter)
//    }
//
//    override func tearDown() {
//        super.tearDown()
//    }
//
//    func testCreation() {
//        XCTAssertEqual(testRouter.presentable.name, testName)
//    }

    func testNils() {
        let viewController = "VIEW_CONTROLLER"
        let router = Router<String, String>(
            Presenter(getPresentable: { viewController }))
        XCTAssertEqual(router.presentable, viewController)
        XCTAssertEqual(router.setRoute(""), false)
        XCTAssertEqual(router.handlesRoute(""), false)
        XCTAssertNil(router.getStack(""))
    }

    func testInitValues() {
        let viewController = "VIEW_CONTROLLER"
        let value1 = "VALUE1"
        let value2 = "VALUE2"
        let value3 = "VALUE3"
        let result3 = "RESULT3"

        let router = Router<String, String>(
            Presenter(getPresentable: { viewController }),
            handlesRoute: { $0 == value1 },
            setRoute: { $0 == value2 },
            getStack: { $0 == value3 ? [result3] : nil })


        XCTAssertEqual(router.presentable, viewController)
        XCTAssertEqual(router.setRoute(""), false)
        XCTAssertEqual(router.handlesRoute(""), false)
        XCTAssertEqual(router.getStack(value3)!, [result3])
        XCTAssertNil(router.getStack(""))
    }
}
