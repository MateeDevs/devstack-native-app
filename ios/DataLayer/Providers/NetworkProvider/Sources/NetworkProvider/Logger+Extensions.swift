//
//  Created by Petr Chmelar on 05.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import OSLog

extension Logger {
    static func log(request: URLRequest) {
        var requestLog = "\n-------------------------->\n"
        requestLog += "➡️ \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")\n"
        if let body = request.httpBody {
            requestLog += "\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        Logger(subsystem: Bundle.main.bundleIdentifier ?? "-", category: "NetworkProvider").info("\(requestLog)")
    }
    
    static func log(response: URLResponse, data: Data) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        var responseLog = "\n<--------------------------\n"
        responseLog += "⬅️ \(httpResponse.url?.absoluteString ?? "")\n"
        responseLog += (200...299).contains(httpResponse.statusCode) ? "✅" : "❌"
        responseLog += " Status Code: \(httpResponse.statusCode)\n"
        responseLog += "\(String(data: data, encoding: .utf8) ?? "")\n"
        Logger(subsystem: Bundle.main.bundleIdentifier ?? "-", category: "NetworkProvider").info("\(responseLog)")
    }
}
