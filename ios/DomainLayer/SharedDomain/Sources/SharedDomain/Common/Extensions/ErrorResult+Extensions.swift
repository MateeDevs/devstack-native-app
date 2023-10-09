import DevstackKmpShared

public extension ErrorResult {
    
    var asError: Swift.Error {
        switch self {
        // CommonError
        case is DevstackKmpShared.CommonError.NoNetworkConnection: CommonError.noNetworkConnection
        default: CommonError.unknownError
        }
    }
}
