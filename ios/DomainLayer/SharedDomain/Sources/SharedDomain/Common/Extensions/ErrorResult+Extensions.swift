import DevstackKmpShared

public extension ErrorResult {
    
    var asError: Swift.Error {
        switch self {
        // CommonError
        case is DevstackKmpShared.CommonError.NoNetworkConnection: return CommonError.noNetworkConnection
        default: return CommonError.unknownError
        }
    }
}
