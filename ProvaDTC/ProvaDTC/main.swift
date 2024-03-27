//
//  main.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

print("Hello, World!")

// EXAMPLE
//var data = [[0, 7.9, 9, 4 , 0], [0, 9, 5.9, 4, 1], [1, 3.2, 5, 1.2, 0], [0, 3.2, 5, 1.2, 1], [1, 7.9, 9, 4 , 1]]
//
//
//print("labels: ", get_y(data: data), "\n")
//print(split_on_feature(data: data, feat_index: 0))
//
//
//func calculate_entropy (Y: [Double]) -> Double {
//    
//    let labels_counts = Y.unique()
//    let total_instances = Double(Y.count)
//    
//    var entropy = 0.0
//    
//
//    for label_count in labels_counts {
//        
//        entropy += Double(label_count.1) / total_instances * log2(1 / ((Double(label_count.1) / total_instances)))
//        
//    }
//    
//    return entropy
//}
//
//func split_on_feature (data: [[Double]], feat_index: Int) -> ([Double : Node], Double) {
//    
//    let feature_values = data.map { $0[feat_index] }
//    let unique_values = feature_values.unique()
//    
//    var split_nodes = [Double: Node]() //dizionario di key double e dato Node
//    var weighted_entropy = 0.0
//    let total_instances = data.count
//    var node = Node()
//    var node_entropy = 0.0
//    var partition_y = [Double] ()
//    var partition = [[Double]]()
//    
//    for (unique_value, _) in unique_values {
//        
//        partition = data.filter { ($0[feat_index] ) == unique_value }
//        print("partition :", partition, "\n")
//        node = Node(data: partition)
//        split_nodes[unique_value] = node
//        partition_y = get_y(data: partition)
//        
//        print("-----------------------------------------")
//        
//        node_entropy = calculate_entropy(Y: partition_y)
//        
//        print("Node entropy: ", node_entropy, "\n")
//        weighted_entropy += (Double(partition.count) / Double(total_instances)) * node_entropy
//        
//        partition.removeAll()
//        
//    }
//
//    
//    return (split_nodes, weighted_entropy)
//}
//
//
//func get_y(data: [[Double]]) -> [Double] {
//
//    let y = data.map { $0.last ?? 0 }
//    
//    return y
//    
//}


let rootNode = Node()
    
    // Create an instance of DecisionTreeClassifier with the root node
    let classifier = DecisionTreeClassifier(root: rootNode)
    
    // Generate some example data (replace with your actual dataset)
let X: [[Double]] = [[1.0, 1, 0, 1, 0, 0, 1, 1], [1.0, 1, 0, 1, 1, 1, 1, 1], [1.0, 0, 0, 1, 0, 0, 1, 0], [0.0, 1, 0, 0, 0, 0, 1, 0], [1.0, 0, 0, 1, 0, 0, 1, 0]]
    let Y: [Double] = [0.0, 1.0, 0, 1, 0] // Example target labels
    
    // Fit the classifier with the example data
    classifier.fit(X: X, Y: Y)
    
    // Generate some test data to make predictions (replace with your actual test dataset)
    let testData: [[Double]] = [[1.0, 6.0], [5.0, 6.0]]


//    // Make predictions using the trained classifier
    let predictions = classifier.predict(X: testData)
//
//    // Output the predictions
    print("Predictions:", predictions)




