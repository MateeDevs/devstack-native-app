import DevstackKmpShared

public extension ErrorResult {
    
    var asError: Swift.Error {
        switch self {
        // AuthError
        // case is KMMSharedDomain.AuthError.Unauthorized: return AuthError.unauthorized
        // case is KMMSharedDomain.AuthError.InvalidCredentials: return AuthError.invalidCredentials

        // CommonError
        case is DevstackKmpShared.CommonError.NoNetworkConnection: return CommonError.noNetworkConnection
        default: return CommonError.unknownError
        }
    }
}
