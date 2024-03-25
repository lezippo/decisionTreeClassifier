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
        let total_instances = Y.count
        var entropy = 0.0
        
        for label_count in labels_counts {
            
            entropy += Double(label_count.1) / Double(total_instances) * log2(Double(1 / (label_count.1 / total_instances)))
        }
        
        
        return entropy
    }
    
//    def split_on_feature(self, data, feat_index):
//
//        feature_values = data[:, feat_index]
//        unique_values = np.unique(feature_values)
//
//        split_nodes = {}
//        weighted_entropy = 0
//        total_instances = len(data)
//
//        for unique_value in unique_values:
//            partition = data[data[:, feat_index] == unique_value, :]
//            node = Node(data=partition)
//            split_nodes[unique_value] = node
//            partition_y = self.get_y(partition)
//            node_entropy = self.calculate_entropy(partition_y)
//            weighted_entropy += (len(partition) / total_instances) * node_entropy
//
//        return split_nodes, weighted_entropy
    
    func split_on_feature (data: [[Double]], feat_index: Int) {
        
        var feature_values = data.map { $0[feat_index] }
        var unique_values = feature_values.unique()
        
        var split_nodes = {}
        var eighted_entropy = 0
        var total_instances = data.count
        
        for unique_value in unique_values {
            
        }
        
    }
    
}
