//
//  ClassifierModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

class DecisionTreeClassifier {
    
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
        var total_instances = data.count
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
    
    
    
    
}
