import XCTest
@testable import FeatherweightRouter

class PresenterTests: XCTestCase {

    enum MockViewController {
        case parent
        case child
        case other
    }

    func testGetPresentable() {
        let value = "returnValue1"
        let presenter = Presenter(getPresentable: { value })
        XCTAssertEqual(presenter.getPresentable(), value)
    }

    func testSetChild() {
        let expected = "EXPECTED"
        var actual = ""

        let presenter = Presenter(
            getPresentable: { "" },
            setChild: { actual = $0 },
            setChildren: { _ in })

        presenter.set(expected)
        XCTAssertEqual(actual, expected)
    }

    func testSetChildren() {
        let expected = ["EXPECTED"]
        var actual = [String]()

        let presenter = Presenter(
            getPresentable: { "" },
            setChild: nil,
            setChildren: { actual = $0 })

        presenter.set(expected)
        XCTAssertEqual(actual, expected)
    }
}
