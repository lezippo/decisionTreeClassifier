//
//  NodeModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

class Node {
    
    var data: [[Double]]?
    var children: [Double: Node]?
    var splitOn: Int?
    var predClass: Double?
    var isLeaf: Bool
    
    init(data: [[Double]]? = nil, children: [Double: Node]? = nil, splitOn: Int? = nil, predClass: Double? = nil, isLeaf: Bool = false) {
        
        self.data = data
        self.children = children
        self.splitOn = splitOn
        self.predClass = predClass
        self.isLeaf = isLeaf
        
    }
    
    
}
