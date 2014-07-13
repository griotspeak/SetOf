//
//  SetOf.swift
//  SetOf
//
//  Created by TJ Usiyan on 7/10/14.
//  Copyright (c) 2014 ButtonsAndLights. All rights reserved.
//

import Foundation

class SetOf<T: Hashable> {
    var dict: Dictionary<T, Bool> = Dictionary<T, Bool>()
    
    convenience init(_ values:T...) {
        self.init(values)
    }
    init(_ values:[T]) {
        for value in values {
            self.add(value)
        }
    }
    
    subscript(j: T) -> Bool {
        if dict[j] {
            return true
        }
        else {
            return false
            }
    }
    
    func allObjects() -> [T] {
        return Array(dict.keys)
    }
    
    var count:Int {
    get {
        return allObjects().count
    }
    }
}

extension SetOf {
    func map<U>(transform:(T)->U) -> SetOf<U> {
        allObjects()
        let newObjects = allObjects().map(transform)
        return SetOf<U>(allObjects().map(transform))
    }
}

extension SetOf {
    func add(k: T) {
        dict[k] = true
    }
    
    func remove(k: T) {
        dict[k] = nil
    }
}

extension SetOf : Hashable {
    var hashValue:Int {
    get {
        return 1 &+ Array(dict.keys).reduce(0) {
            $0.hashValue ^ $1.hashValue
        }
    }
    }
}

extension SetOf : Sequence {
    func generate() -> IndexingGenerator<Array<T>> {
        return allObjects().generate()
    }
}

extension SetOf : Printable, DebugPrintable {
    var description: String {
    get {
            return allObjects().description
    }
    }
    
    var debugDescription: String {
        return "SetOf : \(allObjects().debugDescription)"
    }
}


extension SetOf { // operations
    func union(other:SetOf<T>) -> SetOf<T>{
        var newSet = SetOf<T>()
        
        
        for value in self {
            newSet.add(value)
        }
        
        for value in other {
            newSet.add(value)
        }
        
        return newSet
    }
    
    func intersect(other:SetOf<T>) -> SetOf<T>{
        var newSet = SetOf<T>()
        
        
        for value in self {
            if other[value] {
                newSet.add(value)
            }
        }
        return newSet
    }
    
    func minus(other:SetOf<T>) -> SetOf<T>{
        var newSet = SetOf<T>()
        
        for value in self {
            if !other[value] {
                newSet.add(value)
            }
        }
        return newSet
    }
}

// new set

extension SetOf {
    func setByAddingElement(element:T) -> SetOf<T> {
        var array = allObjects()
        array += element
        return SetOf<T>(array)
    }
    
    func setByAddingElementsOf(other:SetOf<T>) -> SetOf<T> {
        return SetOf<T>(allObjects() + other.allObjects())
    }
    func setByAddingElementsOf(other:Array<T>) -> SetOf<T> {
        let newSet = self
        for (value) in other {
            newSet.add(value)
        }
        return newSet
    }
    
}

// comparisons
extension SetOf {
    func isSubsetOfSet(other:SetOf<T>) -> Bool {
        
        for value in self {
            if !other[value]{
                return false
            }
        }
        
        return true
    }
    
    func isSupersetOfSet(other:SetOf<T>) -> Bool {
        
        for value in other {
            if !dict[value] {
                return false
            }
        }
        return true
    }
}

@infix func == <T:Hashable>(first:SetOf<T>, second:SetOf<T>) -> Bool {
    return first.dict == second.dict
}

extension SetOf {
    var powerSet:SetOf<SetOf<T>> {
    get {
        var pSet:SetOf<SetOf<T>> = SetOf<SetOf<T>>(SetOf<T>()) // seed with empty set
        for value:T in self.allObjects() {
            pSet = pSet.setByAddingElementsOf(pSet.map({$0.setByAddingElement(value)}))
            pSet.add(SetOf<T>(value))
        }
        return pSet
    }
    }
}
// reflectable

//extension SetOf : Reflectable {
//    struct SetOfMirror<T:Hashable where T:Reflectable> {
//        init(value:SetOf<T>) {
//            self._value = value
//            self.orderedObjects = _value.allObjects()
//        }
//        let _value:SetOf<T>
//        let orderedObjects:[T]
//
//        var value:Any { get { return _value } }
//        var valueType:Any.Type { get { return _value.dynamicType } }
//
//        var objectIdentifier:ObjectIdentifier? {
//        get {
//            return .None
//        }
//        }
//
//        var count:Int { get { return _value.count } }
//        subscript (i:Int) -> (String, Mirror) {
//            return ("[\(i)]", orderedObjects[i].getMirror())
//        }
//    }
//    
//}
