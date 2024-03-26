//
//  CombineFunc.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 26/03/24.
//

import Foundation

func combine (X: [[Double]], Y: [Double] ) -> [[Double]] {
    
    var combinedArr = X
    
    for i in 0..<X.count {
        
        combinedArr[i].append(Y[i])
        
    }
    
    return combinedArr
}
