//
//  URLSessionNetworkService.swift
//
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation

public class URLSessionNetworkService: NetworkService {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.path) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}

