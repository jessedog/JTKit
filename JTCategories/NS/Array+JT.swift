//
//  Array+JT.swift
//  BasicProject
//
//  Created by Sheng Long Tan on 06/03/2017.
//  Copyright © 2017 TSL. All rights reserved.
//

import Foundation

extension Array {
    
    ///累加，并保留合并时每一步的结果
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
    ///是否所有元素都满足条件
    func all(_ matching: (Element) throws -> Bool)rethrows -> Bool {
        
        return try !contains{try !matching($0)}
    }
    
    ///是否没有元素满足条件
    func none(_ matching: (Element) throws -> Bool)rethrows -> Bool {
        
        return try !contains(where: matching)
    }
    
    ///计算满足条件的元素个数
    func count(where predicate: (Element) throws -> Bool)rethrows -> Int {
        
        var count:Int = 0
        for element in self where try predicate(element) {
            count += 1
        }
        return count
    }
    
    ///返回一个包含满足某个标准的所有元素的索引的列表
    func indices(where predicate: (Element) throws -> Bool)rethrows -> [Int] {
        var indices = [Int]()
        for (index, item) in enumerated() where try predicate(item) {
            indices.append(index)
        }
        return indices
    }
    
    ///去掉不满足条件的item，一旦发现一个item能满足条件则终止匹配
    func drop(while predicate: (Element) throws -> Bool)rethrows -> [Iterator.Element] {
        var array = self
        for (index, item) in enumerated() {
            if try predicate(item) {
                break
            } else {
                array.remove(at: index)
            }
        }
        return array
    }
    
    ///去不满足条件的item，一旦发现一个item能不能满足条件则终止匹配
    func prefix(while predicate: (Element) throws -> Bool)rethrows -> [Iterator.Element] {
        var array = self
        for (index, item) in enumerated() {
            if try predicate(item) {
                array.remove(at: index)
            } else {
                break
            }
        }
        return array
    }
    
}

extension Array where Element : Equatable {
    
    ///删除指定元素
    mutating func remove(of item: Element) {
        if let index = self.index(of: item) {
            remove(at: index)
        }
    }
}
