import DevstackKmpShared

public extension ErrorResult {
    var asError: Swift.Error { KMMError(from: self) }
}
