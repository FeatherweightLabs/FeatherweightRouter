/**
 Creates a lazy wrapper around a presenter creation function that wraps presenter scope, but does
 not get created until invoked.

 `(() -> Presentable) -> Presenter<Presentable>`

 - parameter createPresentable: callable that returns the presentable item

 - returns: Presenter<Presentable>
 */
public func cachedPresenter<ViewController: AnyObject>(
    _ createPresentable: @escaping () -> ViewController)
    -> Presenter<ViewController> {

        weak var presentable: ViewController? = nil

        func maybeCachedPresentable() -> ViewController {
            if let cachedPresentable = presentable {
                return cachedPresentable
            }

            let newPresentable = createPresentable()
            presentable = newPresentable
            return newPresentable
        }

        return Presenter(getPresentable: maybeCachedPresentable)
}
