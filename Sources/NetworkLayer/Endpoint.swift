//
//  Endpoint.swift
//
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
}

