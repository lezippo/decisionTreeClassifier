//
//  CombineFunc.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 26/03/24.
//

import Foundation

func combine (X: [[Double]], Y: [Double] ) -> [[Double]] {
    
    /*
     Combines a 2D array with a 1D array element-wise.

     - Parameters:
        - X: A 2D array of Double values.
        - Y: A 1D array of Double values.

     - Returns: A 2D array where each element of `X` is combined with the corresponding element of `Y` by appending it.

     - Note: The arrays `X` and `Y` must have the same number of rows.

     - Example:
        ```swift
        let X = [[1.0, 2.0], [3.0, 4.0]]
        let Y = [5.0, 6.0]
        let combinedArray = combine(X: X, Y: Y)
        // Output: [[1.0, 2.0, 5.0], [3.0, 4.0, 6.0]]
        ```
     */
    
    var combinedArr = X
    
    for i in 0..<X.count {
        
        combinedArr[i].append(Y[i])
        
    }
    
    return combinedArr
}
