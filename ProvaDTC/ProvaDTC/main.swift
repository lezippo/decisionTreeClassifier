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

let featIndex = 3;

let data = [[1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3], [1,2,9,3,2,4,1,0,4,3]]

print(data)
print("--------------------------------------------------")
let featureValues = data.map { $0[featIndex] }

print(featureValues)


