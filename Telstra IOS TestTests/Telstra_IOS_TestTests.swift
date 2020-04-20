//
//  Telstra_IOS_TestTests.swift
//  Telstra IOS TestTests
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import XCTest
@testable import Telstra_IOS_Test

class Telstra_IOS_TestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // Mock by subclassing the original class
    class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void
        init(closure: @escaping () -> Void) {
            self.closure = closure
        }
        override func resume() {
            closure()
        }
    }
    
    /// Data Task is mocked to return the desired data
    class URLSessionMock: URLSession {
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var data: Data?
        var error: Error?
        override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
            let data = self.data
            let error = self.error
            return URLSessionDataTaskMock {
                completionHandler(data, nil, error)
            }
        }
    }
    
    // MARK:- Telstra Image Downloader Test Class
    class ImgDownloaderTests: XCTestCase {
        func testGetImageFor() {
            // Setup test objects
            let session = URLSessionMock()
            let manager = ImgDownloader(session: session)
            let data = Data( [0, 1, 0, 1])
            session.data = data
            let url = URL(fileURLWithPath: "url")
            var result: Data?
            manager.getDownloadImage(path: url.absoluteString) { (data) in
                result = data
            }
            XCTAssertEqual(result, data)
        }
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
