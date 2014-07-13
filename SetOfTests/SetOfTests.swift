//
//  SetOfTests.swift
//  SetOfTests
//
//  Created by TJ Usiyan on 7/10/14.
//  Copyright (c) 2014 ButtonsAndLights. All rights reserved.
//

import UIKit
import XCTest
import SetOf

class SetOfTests: XCTestCase {
    
    func testUnion() {
        XCTAssertEqual(SetOf<Int>(1, 2).union(SetOf<Int>(2, 3)), SetOf<Int>(1,2,3))
    }
    
    func testUnionWithEmptySet() {
        let setWithEmptySet = SetOf<SetOf<Int>>(SetOf<Int>())
        let setWithOneElement = SetOf<SetOf<Int>>(SetOf<Int>(1))
        let expectedSet = SetOf<SetOf<Int>>(SetOf<Int>(), SetOf<Int>(1))
        
        XCTAssertEqual(setWithEmptySet.union(setWithOneElement), expectedSet)
    }
    
    
    func testIntersect() {
        XCTAssertEqual(SetOf<Int>(1, 2).intersect(SetOf<Int>(2, 3)), SetOf<Int>(2))
    }
    
    func testMinus() {
        XCTAssertEqual(SetOf<Int>(1, 2).minus(SetOf<Int>(2, 3)), SetOf<Int>(1))
    }
    
    func testSetByAddingElementsOf() {
        XCTAssertEqual(SetOf<Int>(1, 2).setByAddingElementsOf(SetOf<Int>(3)), SetOf<Int>(1, 2, 3))
    }
    
    func testIsSubsetOfSet() {
        let threeSet = SetOf<Int>(1, 2, 3)
        XCTAssertTrue(SetOf<Int>(2).isSubsetOfSet(threeSet))
        XCTAssertFalse(SetOf<Int>(4).isSubsetOfSet(threeSet))
    }
    
    func testIsSupersetOfSet() {
        XCTAssertTrue(SetOf<Int>(1, 2, 3).isSupersetOfSet(SetOf<Int>(2)))
        XCTAssertFalse(SetOf<Int>(1, 2, 3).isSupersetOfSet(SetOf<Int>(6)))
    }
    
    func testHashValue() {
        XCTAssertEqual(SetOf<Int>(1, 2).hashValue, SetOf<Int>(2, 1).hashValue)
        XCTAssertEqual(SetOf<Int>(3, 1, 2).hashValue, SetOf<Int>(2, 3, 1).hashValue)
        XCTAssertNotEqual(SetOf<Int>(2).hashValue, SetOf<Int>(2, 1).hashValue)
    }
    
    func testMap() {
        XCTAssertEqual(SetOf<Int>(1, 2, 3).map {$0 + 3}, SetOf<Int>(4, 5, 6))
    }
    
    func testDescription() {
        XCTAssertEqual(SetOf<Int>().description, "[]")
        XCTAssertEqual(SetOf<Int>(1).description, "[1]")
    }
    
    func testDebugDescription() {
        XCTAssertEqual(SetOf<Int>().debugDescription, "SetOf : []")
        XCTAssertEqual(SetOf<Int>(1).debugDescription, "SetOf : [1]")
        
    }
    func testDescriptionWithEmptySetInSetOfSets() {
        let set = SetOf<SetOf<Int>>(SetOf<Int>(), SetOf<Int>(1))
        let desc = set.description
        XCTAssertTrue((desc == "[[], [1]]") || (desc == "[[1], []]"))
    }
    

    
    func testPowerSet() {
        let emptyPowerSet = SetOf<SetOf<Int>>(SetOf<Int>())
        let onePowerSet = SetOf<SetOf<Int>>(
                                            SetOf<Int>(),
                                            SetOf<Int>(1))
        let twoPowerSet = SetOf<SetOf<Int>>(
                                            SetOf<Int>(),
                                            SetOf<Int>(1),
                                            SetOf<Int>(2),
                                            SetOf<Int>(1, 2))
        
        let threePowerSet = SetOf<SetOf<Int>>(
                                              SetOf<Int>(),
                                              SetOf<Int>(1),
                                              SetOf<Int>(2),
                                              SetOf<Int>(1, 2),
                                              SetOf<Int>(3),
                                              SetOf<Int>(1, 3),
                                              SetOf<Int>(2, 3),
                                              SetOf<Int>(1, 2, 3))

        XCTAssertEqual(SetOf<Int>().powerSet, emptyPowerSet)
        XCTAssertEqual(SetOf<Int>(1).powerSet, onePowerSet)
        XCTAssertEqual(SetOf<Int>(1, 2).powerSet, twoPowerSet)
        XCTAssertEqual(SetOf<Int>(1, 2, 3).powerSet, threePowerSet)
    }
}
