//
//  NodeModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

class Node {
    
    /*
        Represents a node in a decision tree.
    */
    
    // The data associated with the node.
    var data: [[Double]]?
    
    // Child nodes associated with this node.
    var children: [Double: Node]?
    
    // The index used for splitting the data at this node.
    var splitOn: Int?
    
    // The predicted class at this node.
    var predClass: Double?
    
    // A flag indicating whether this node is a leaf node.
    var isLeaf: Bool
    
    /*
        Initializes a new node.
     
        - Parameters:
            - data: The data associated with the node. Default is nil.
            - children: Child nodes associated with this node. Default is nil.
            - splitOn: The index used for splitting the data at this node. Default is nil.
            - predClass: The predicted class at this node. Default is nil.
            - isLeaf: A flag indicating whether this node is a leaf node. Default is false.
    */
    init(data: [[Double]]? = nil, children: [Double: Node]? = nil, splitOn: Int? = nil, predClass: Double? = nil, isLeaf: Bool = false) {
        
        self.data = data
        self.children = children
        self.splitOn = splitOn
        self.predClass = predClass
        self.isLeaf = isLeaf
        
    }
    
}

