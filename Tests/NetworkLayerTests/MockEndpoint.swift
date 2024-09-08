//
//  MockEndpoint.swift
//
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation
@testable import NetworkLayer

struct MockEndpoint: Endpoint {
    var path: String = "https://mockapi.com/user"
    var method: String = "GET"
    var headers: [String: String]? = nil
    var parameters: [String: Any]? = nil
    var body: Data? = nil
}
