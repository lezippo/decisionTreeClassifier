//
//  main.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

print("Hello, World!")

//var arr: [Int] = [1,2,9,3,2,4,1,0,4,3]
//
//print(arr.unique())

//let featIndex = 3;
//
//let data: [[Double]] = [[1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3]]
//
//print(data)
//print("--------------------------------------------------")
//let featureValues = data.map { $0[featIndex] }
//
//print(featureValues)

// Sample data represented as an array of arrays
let data: [[Double]] = [
    [1, 0, 10],
    [2, 0, 15],
    [3, 1, 12],
    [4, 0, 18],
    [5, 1, 8]
]


func split_on_feature (data: [[Double]], feat_index: Int) {
    
    let feature_values = data.map { $0[feat_index] }
    let unique_values = feature_values.unique()
    
    var split_nodes = [Double: Node]()
    let weighted_entropy = 0
    let total_instances = data.count
    var node = Node()
    var node_entropy = 0.0
    
    var partition = [[Double]]()
    
    for (unique_value, _) in unique_values {
        partition = data.filter { ($0[feat_index] ) == unique_value }
        node = Node(data: partition)
        split_nodes[unique_value] = node
        
        let partition_y = get_y(data: partition)
        node_entropy = calculate_entropy(Y: partition_y)
        
        print(partition, "\n")
        print("Partition's entropy", node_entropy)
        print("-----------------\n")
        
        partition.removeAll()
        
    }
    
    print(split_nodes)
    
    
}

func get_y(data: [[Double]]) -> [Double] {

    let y = data.map { $0.last ?? 0 }
    
    return y
    
}

func calculate_entropy (Y: [Double]) -> Double {
    
    let labels_counts = Y.unique()
    let total_instances = Y.count
    var entropy = 0.0
    

    for label_count in labels_counts {
        
        entropy += Double(label_count.1) / Double(total_instances) * log2(1 / ((Double(label_count.1) / Double(total_instances))))
    }
    
    return entropy
}

split_on_feature(data: data, feat_index: 1)




