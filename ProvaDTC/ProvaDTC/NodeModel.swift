//
//  NodeModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

class Node {
    
    var data: [[Double]]?
    var children: [String: Node]?
    var splitOn: Int?
    var predClass: String?
    var isLeaf: Bool
    
    init(data: [[Double]]? = nil, children: [String: Node]? = nil, splitOn: Int? = nil, predClass: String? = nil, isLeaf: Bool = false) {
        self.data = data
        self.children = children
        self.splitOn = splitOn
        self.predClass = predClass
        self.isLeaf = isLeaf
    }
    
    
}
