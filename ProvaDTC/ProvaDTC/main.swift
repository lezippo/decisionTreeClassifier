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

func split_on_feature (data: [[Double]], feat_index: Int) -> [Double: [[Double]]] {
    
    var feature_values = data.map { $0[feat_index] }
    var unique_values = feature_values.unique()
    
    var split_nodes = {}
    var eighted_entropy = 0
    var total_instances = data.count
    
    var partitions = [Double: [[Double]]]()
    
    for (unique_value, _) in unique_values {
        partitions[unique_value] = data.filter { ($0[feat_index] ) == unique_value }
    }
    return partitions
    
}

print(split_on_feature(data: data, feat_index: 1))




