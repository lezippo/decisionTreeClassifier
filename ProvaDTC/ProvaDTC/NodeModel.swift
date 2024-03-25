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

class TreeNode {
    
    var data: [Float]?
    var feature_idx: Int
    
    var children: [String: TreeNode]?
    //Dizionario in cui ho le key di tipo String e i dati di tipo TreeNode: ogni nodo ha un dizionario di figli. Quindi cerchiamo la key del figlio, non il pointer. In questo modo non sono ordinati, abbiamo solo la "relazione" di parentela
    
    var isLeaf: Bool
    var predClass: String?
    
    init(data: [Float]? = nil, feature_idx: Int, children: [String: TreeNode]? = nil, isLeaf: Bool = false, predClass: String? = nil) {
        self.data = data
        self.feature_idx = feature_idx
        self.children = children
        self.isLeaf = isLeaf
        self.predClass = predClass
    }
    
    
    
}



