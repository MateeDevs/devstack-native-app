import KMPShared

public struct KmmLocalizedError: Swift.Error {
    public let errorResult: ErrorResult?
    /// Returns localized message based on shared error string
    public let localizedMessage: String
    
    public init(errorResult: ErrorResult?, localizedMessage: String) {
        self.errorResult = errorResult
        self.localizedMessage = localizedMessage
    }
}

public extension Swift.Error {
    var kmmErrorResult: ErrorResult? {
        switch self{
        case let error as KmmLocalizedError:
            return error.errorResult
        default:
            return nil
        }
    }
    
    /// Returns localized message based on shared error string. If Error is not KmmLocalizedError - it will returns localizedDescription as usual
    var localizedMessage: String {
        switch self{
        case let error as KmmLocalizedError:
            return error.localizedMessage
        default:
            return self.localizedDescription
        }
    }
}
