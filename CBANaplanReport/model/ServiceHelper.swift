//
//  ServiceHelper.swift
// This is copied and modified from
// https://github.com/cweatureapps/IntroWorkshop.iOS

import Foundation

typealias JSON = [String: Any]

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}

enum ServiceURLs: String {
    case login = "Login.json"
    case getTestResults = "GetTestResults.json"
    case getStudents = "GetStudents.json"
}
protocol ServiceHelper {
    typealias RequestCompletion = (Result<JSON, ServiceError>) -> Void

    /// Make a request to the backend.
    func request(urlString: String, param: String?, completion: @escaping RequestCompletion)
}

extension ServiceHelper {
    func adjustUrl(urlString: String, withParam param: String) -> String {
        let lastDotRange = urlString.range(of: ".", options: .backwards)
        return urlString.substring(to: lastDotRange!.lowerBound) + param + urlString.substring(from: lastDotRange!.lowerBound)
    }
}

/// Factory that returns the ServiceHelper to use.
class ServiceHelperFactory {
    static func makeServiceHelper() -> ServiceHelper  {
        return StubServiceHelper()
    }
}

enum ServiceError: Error {
    case general
    case loadingFailed(String)
}

/// Service Helper which loads JSON stub response from a file.
class StubServiceHelper: ServiceHelper {

    private enum Constants {
        static let delay = 0.3
    }

    /// Loads a stub JSON file asynchronously from disk as if it were a backend response.
    /// Filename is based on convention, should be named the same as last part after the slash.
    func request(urlString: String, param: String?, completion: @escaping ServiceHelper.RequestCompletion) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.delay) {
            do {
                let adjustedUrlString = param == nil ? urlString : self.adjustUrl(urlString: urlString, withParam: param!)
                let fileName = adjustedUrlString
                let response = try self.loadJSONDictionary(from: fileName)
                completion(.success(response))
            } catch (let error) {
                let serviceError = ServiceError.loadingFailed(error.localizedDescription)
                completion(.failure(serviceError))
            }
        }
    }

    /// Loads a file from disk as a dictionary
    private func loadJSONDictionary(from filename: String) throws -> JSON {
        let splitFilename = filename.components(separatedBy: ".")
        if let filepath = Bundle(for: StubServiceHelper.self).path(forResource: splitFilename[0], ofType: splitFilename[1]),
            let jsonString = try? String(contentsOfFile: filepath, encoding: .utf8),
            let jsonData = jsonString.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let result = jsonObject as? JSON {
            return result
        } else {
            throw ServiceError.loadingFailed("Could not load or parse the file")
        }
    }
}
