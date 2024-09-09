//
//  URLSessionNetworkService.swift
//
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
}

public class URLSessionNetworkService {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

extension URLSessionNetworkService: NetworkService {
    
    public func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}

