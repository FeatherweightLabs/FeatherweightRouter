import XCTest
@testable import FeatherweightRouter

class CachedPresenterTests: XCTestCase {

    typealias TestPresenter = Presenter<ViewController>

    class ViewController {
        init() {}
    }

    func testCreation() {
        var callCount = 0
        let presenter: TestPresenter = cachedPresenter { () -> ViewController in
            callCount += 1
            return ViewController()
        }

        XCTAssertEqual(callCount, 0)
        var x: ViewController! = presenter.presentable
        XCTAssertEqual(callCount, 1)
        var y: ViewController! = presenter.presentable
        XCTAssertEqual(callCount, 1)
        XCTAssert(x === y)

        x = nil
        y = nil

        x = presenter.presentable
        XCTAssertEqual(callCount, 2)
        y = presenter.presentable
        XCTAssertEqual(callCount, 2)
        XCTAssert(x === y)
    }

}
