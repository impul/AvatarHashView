//
//  CryptoTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Impulse. All rights reserved.
//

import XCTest
@testable import AvatarHashView

class CryptoTests: XCTestCase {
    // https://passwordsgenerator.net/sha256-hash-generator/
    func testSha256() {
        let data = Data("Test".utf8)
        XCTAssertEqual(data.sha256.hex, "532eaabd9574880dbf76b9b8cc00832c20a6ec113d682299550d7a6e0f345e25")
    }
    
    // http://string-functions.com/hex-string.aspx
    func testHex() {
        let data = Data("Test".utf8)
        XCTAssertEqual(data.hex, "54657374")
    }
}

