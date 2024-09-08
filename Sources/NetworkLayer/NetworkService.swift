//
//  NetworkService.swift
//  
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation

public protocol NetworkService {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

