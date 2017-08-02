//
//  Dictionary+JT.swift
//  BasicProject
//
//  Created by Sheng Long Tan on 06/03/2017.
//  Copyright © 2017 TSL. All rights reserved.
//

import Foundation

extension Dictionary {
    ///合并字典
    mutating func merge<S>(_ other: S)
        where S:Sequence, S.Iterator.Element == (key: Key, value: Value) {
            for (k, v) in other {
                self[k] = v
            }
    }
    
    ///用一个键值对序列来创建字典
    init<S:Sequence>(_ sequence:S)
        where S.Iterator.Element == (key: Key, value: Value) {
            self = [:]
            self.merge(sequence)
    }
    
    ///对value进行map
    func mapValues<NewValue>(transform:(Value) -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>(map { (key, value) in
            return (key, transform(value))
        })
    }
    
}

