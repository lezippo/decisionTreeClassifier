//
//  ClassifierModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

class DecisionTreeClassifier {
    
    var root: Node
    
    init(root: Node) {
        self.root = root
    }
    
    func calculate_entropy (Y: [Double]) -> Double {
        
        let labels_counts = Y.unique()
        let total_instances = Double(Y.count)
        
        var entropy = 0.0
        

        for label_count in labels_counts {
            
            entropy += Double(label_count.1) / total_instances * log2(1 / ((Double(label_count.1) / total_instances)))
            
        }
        
        return entropy
    }
    
    func split_on_feature (data: [[Double]], feat_index: Int) -> ([Double : Node], Double) {
        
        let feature_values = data.map { $0[feat_index] }
        let unique_values = feature_values.unique()
        
        var split_nodes = [Double: Node]() //dizionario di key double e dato Node
        var weighted_entropy = 0.0
        let total_instances = data.count
        var node = Node()
        var node_entropy = 0.0
        var partition_y = [Double] ()
        var partition = [[Double]]()
        
        for (unique_value, _) in unique_values {
            
            partition = data.filter { ($0[feat_index] ) == unique_value }
            node = Node(data: partition)
            split_nodes[unique_value] = node
            partition_y = get_y(data: partition)
            
            node_entropy = calculate_entropy(Y: partition_y)
            weighted_entropy += (Double(partition.count) / Double(total_instances)) * node_entropy
            
            partition.removeAll()
            
        }
        
        print(split_nodes)
        
        return (split_nodes, weighted_entropy)
    }
    
    
    func get_y(data: [[Double]]) -> [Double] {

        let y = data.map { $0.last ?? 0 }
        
        return y
        
    }
    
    func meet_criteria (node: Node) -> Bool {
        // DA TESTARE
        let y = get_y(data: node.data ?? [])
        
        if calculate_entropy(Y: y) == 0 {
            
            return true
            
        } else {
            
            return false
            
        }
        
    }
    
    func get_pred_class(Y: [Double]) -> Double {
        // DA TESTARE
        var labels = [Double]()
        var labels_counts = [Int]()
        for tupla in Y.unique() {
            labels.append(tupla.0)
            labels_counts.append(tupla.1)
        }
        
        guard let index = labels_counts.max() else { return 0 } // ????????????????????
        
        if index == 0 {
            return labels[index]
        } else {
            return labels[index-1]
        }
    }
    
    func best_split (node: Node) {
        // DA TESTARE
        if meet_criteria(node: node) {
            node.isLeaf = true
            let y = get_y(data: node.data ?? [])
            node.predClass = get_pred_class(Y: y)
            return
        }
        
        var index_feature_split = -1
        var min_entropy = 1.0
        
        var split_nodes: [Double : Node]
        var weighted_entropy: Double
        var child_nodes: [Double : Node] = [:]
        
        if let count = node.data?[0].count {
            
            for i in 0..<count - 1 {
                
                let splits = split_on_feature(data: node.data ?? [], feat_index: i)
                split_nodes = splits.0
                weighted_entropy = splits.1
                
                if weighted_entropy < min_entropy {
                    child_nodes = split_nodes
                    min_entropy = weighted_entropy
                    index_feature_split = i
                    
                }
            }
            
            node.children = child_nodes
            node.splitOn = index_feature_split
            
            for child_node in child_nodes.values {
                best_split(node: child_node)
            }
                
        } else {
            
            // Handle the case where node.data is nil
        }
        
    }
    
    
    func fit(X: [[Double]], Y: [Double]) {
        // DA TESTARE
        
        let data = combine(X: X, Y: Y)
        
        root.data = data
        
        best_split(node: root)
    }
    

    func traverse_tree (x: [Double] /* TESTAAAAAAAAAAA */, node: Node) -> Double {
        
        if node.isLeaf {
            
            return node.predClass ?? -1
        }
        
        var feat_value = x[node.splitOn ?? -1]
        print("traverse")
        
        print(node.children?[feat_value] ?? "missing")
        var predicted_class = traverse_tree(x: x, node: node.children![feat_value] ?? fatalError("AOOOOOO") as! Node)
        
        //UN BOTTO DI PROBLEMI CON STA FUNC RICORSIVA
        return predicted_class
    }
    

    
    func predict(X: [[Double]])-> [Double] {
        
        var predictions = [Double] ()
        
        for row in X {
            predictions.append(traverse_tree(x: row, node: root))
        }
        
        return predictions
        
    }
    


    
    
    
    
}
