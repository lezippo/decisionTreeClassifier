//
//  main.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

let rootNode = Node()
    
// Create an instance of DecisionTreeClassifier with the root node
let classifier = DecisionTreeClassifier(root: rootNode)
    
// Generate some example data
let X: [[Double]] = [ [1, 1, 0, 1, 0, 0, 1, 1],
                      [1, 1, 0, 1, 1, 1, 1, 1],
                      [1, 0, 0, 1, 0, 0, 1, 0],
                      [0, 1, 0, 0, 0, 0, 1, 0],
                      [1, 0, 0, 1, 0, 0, 1, 0] ]

// Example target labels
let Y: [Double] = [ 0,
                    1,
                    0,
                    1,
                    0 ]
    
// Fit the classifier with the example data
classifier.fit(X: X, Y: Y)
    
// Generate some test data to make predictions
let testData: [[Double]] = [ [0, 1, 1, 1, 0, 0, 1, 0],
                             [1, 0, 0, 1, 0, 0, 0, 1] ]


// Make predictions using the trained classifier
let predictions = classifier.predict(X: testData)

// Output the predictions
print("Predictions:", predictions)




