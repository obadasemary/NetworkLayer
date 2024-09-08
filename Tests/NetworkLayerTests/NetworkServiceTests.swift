import XCTest
@testable import NetworkLayer

final class NetworkServiceTests: XCTestCase {
    
    // System Under Test
    var sut: URLSessionNetworkService!
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = URLSessionNetworkService(session: session)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNetworkService_WhenGivenValidResponse_ReturnsExpectedData() async throws {
        let expectedData = "{\"name\": \"Obada\"}".data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectedData)
        }
        
        let endpoint = MockEndpoint()
        
        let result: MockResponse = try await sut.request(
            endpoint: endpoint,
            responseModel: MockResponse.self
        )
        
        XCTAssertEqual(result.name, "Obada")
    }
}
