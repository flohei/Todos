import XCTest

import todosTests

var tests = [XCTestCaseEntry]()
tests += todosTests.allTests()
XCTMain(tests)
