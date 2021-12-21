//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation
import os.log

/// Predefined OSLog categories
/// Idea taken from [AckeeCZ iOS-MVVM-ProjectTemplate](https://github.com/AckeeCZ/iOS-MVVM-ProjectTemplate)
public enum LoggerCategory {
    case app, networking, lifecycle
    
    /// OSLogs for predefined categories
    public var log: OSLog {
        switch self {
        case .app: return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: "App")
        case .networking: return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: "Networking")
        case .lifecycle: return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: "Lifecycle")
        }
    }
}

/// Wrapper for os_log function
/// Idea taken from [Unified Logging Wrapper](https://gist.github.com/smosko/6b8c161a7ae092e7b72e891a5050deaa)
public struct Logger {
    
    private static func log(_ message: StaticString, _ args: [CVarArg], category: LoggerCategory, type: OSLogType) {
        // The Swift overlay of os_log prevents from accepting an unbounded number of args
        // Related issue: http://www.openradar.me/33203955
        switch args.count {
        case 5: os_log(message, log: category.log, type: type, args[0], args[1], args[2], args[3], args[4])
        case 4: os_log(message, log: category.log, type: type, args[0], args[1], args[2], args[3])
        case 3: os_log(message, log: category.log, type: type, args[0], args[1], args[2])
        case 2: os_log(message, log: category.log, type: type, args[0], args[1])
        case 1: os_log(message, log: category.log, type: type, args[0])
        case 0: os_log(message, log: category.log, type: type)
        default: os_log("Can't log message. Wrong number of arguments!", log: category.log, type: type)
        }
    }
    
    /// Log OSLogType.default message
    public static func `default`(_ message: StaticString, _ args: CVarArg..., category: LoggerCategory) {
        log(message, args, category: category, type: .default)
    }
    
    /// Log OSLogType.info message
    public static func info(_ message: StaticString, _ args: CVarArg..., category: LoggerCategory) {
        log(message, args, category: category, type: .info)
    }
    
    /// Log OSLogType.debug message
    public static func debug(_ message: StaticString, _ args: CVarArg..., category: LoggerCategory) {
        log(message, args, category: category, type: .debug)
    }
    
    /// Log OSLogType.error message
    public static func error(_ message: StaticString, _ args: CVarArg..., category: LoggerCategory) {
        log(message, args, category: category, type: .error)
    }
    
    /// Log OSLogType.fault message
    public static func fault(_ message: StaticString, _ args: CVarArg..., category: LoggerCategory) {
        log(message, args, category: category, type: .fault)
    }
}
