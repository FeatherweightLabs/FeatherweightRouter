extension Array {

    /**
     Returns the first non-nil result passed through the predicate

     - parameter predicate: Closure that accepts an element and return an optional value

     - returns: The first non-nil value returned by the predicate, else nil
     */
    func pickFirst<T>(predicate: Element -> T?) -> T? {
        for item in self {
            if let result = predicate(item) {
                return result
            }
        }
        return nil
    }
}
