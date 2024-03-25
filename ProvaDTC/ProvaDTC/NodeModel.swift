//
//  NodeModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

//class TreeNode():
//    def __init__(self, data, feature_idx, feature_val, prediction_probs, information_gain) -> None:
//        self.data = data
//        self.feature_idx = feature_idx
//        self.feature_val = feature_val
//        self.prediction_probs = prediction_probs
//        self.information_gain = information_gain
//        self.left = None
//        self.right = None

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
