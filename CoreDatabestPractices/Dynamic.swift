//
//  Dynamic.swift
//  CoreDatabestPractices
//
//  Created by Inficare Pvt. Ltd. on 18/06/2018.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation
import UIKit

typealias Listener<T> = (T) -> Void

class Dynamic<T> {
    var value: T {
        didSet {
            for bondBox in bonds {
                bondBox.bond?.listener(value)
            }
        }
    }
    
    var bonds: [BondBox<T>] = []
    
    init(_ v: T) {
        value = v
    }
    
    
}

class Bond<T> {
    var listener: Listener<T>
    
    init(_ listener: @escaping Listener<T>) {
        self.listener = listener
    }
    
    func bind(_ dynamic: Dynamic<T>) {
        dynamic.bonds.append(BondBox(self))
    }
}

class ArrayBond<T>: Bond<Array<T>> {
    var insertListener: (([Int]) -> Void)?
    var removeListener: (([Int], [T]) -> Void)?
    var updateListener: (([Int]) -> Void)?
}


class BondBox<T> {
    weak var bond: Bond<T>?
    init(_ b: Bond<T>) { bond = b }
}

private var handle: UInt8 = 0;

extension UILabel: Bondable {
    var textBond: Bond<String> {
        if let b: Any = objc_getAssociatedObject(self, &handle) {
            return b as! Bond<String>
        } else {
            let b = Bond<String>() { [unowned self] v in self.text = v }
            objc_setAssociatedObject(self, &handle, b, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return b
        }
    }
    
    var designatedBond: Bond<String> {
        return self.textBond
    }
    
}

infix operator ->>
func ->> <T>(left: Dynamic<T>, right: Bond<T>) {
    right.bind(left)
}

func ->> <T, U: Bondable>(left: Dynamic<T>, right: U) where U.BondType == T {
    left ->> right.designatedBond
}

func map<T, U>(_ dynamic: Dynamic<T>, _ f: (T) -> U) -> Dynamic<U> {
    let fs = f(dynamic.value)
    return Dynamic<U>.init(fs)
}

protocol Bondable {
    associatedtype BondType
    var designatedBond: Bond<BondType> { get }
}


