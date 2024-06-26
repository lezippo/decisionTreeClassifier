//
//  ClassifierModel.swift
//  ProvaDTC
//
//  Created by Luigi Emanuele Zippo on 21/03/24.
//

import Foundation

class DecisionTreeClassifier {
    
    /*
     A decision tree classifier implementation.

     This class builds a decision tree based on the provided training data and predicts the class labels for new instances.

     - Note: This implementation supports binary classification.
     */
    
    
    
    // The root node of the decision tree.
    var root: Node
    
    
    
    init(root: Node) {
        
        /*
         This function initializes the decision tree classifier with a root node.
            
        - Parameter root: The root node of the decision tree.
        */
        
        self.root = root
        
    }
    
    
    
    
    
    
    
    func calculateEntropy (Y: [Double]) -> Double {
        
        /*
         This function calculates the entropy of a set of labels.
             
        - Parameter Y: An array containing the labels.
         
        - Returns: The entropy of the label set.
         
        - Example: data = [ [ 0, 1, 0, 0 ],
                            [ 1, 0, 0, 1 ],
                            [ 1, 1, 1, 0 ] ]
         
                   calculateEntropy(Y: getY(data))
         
                   assuming that getY is a function that returns the last column of the matrix data, calculate entropy
                   will calculate the entropy of this set of samples based on the last column. The entropy measures how
                   "pure" is the set. The goal of the algorithm is dividing the original set of samples in subsets minimizing
                   the entropy: in this way we will obtain subsets marked with the same feature. In this case, chosen the 
                   last colmn, the best split is this : subsetsZero = [ [ 0, 1, 0, 0 ], [ 1, 1, 1, 0 ] ]
                                                          subsetOne = [ [ 1, 0, 0, 1 ] ]
        */
        
        let labelsCounts = Y.unique()
        let totalInstances = Double(Y.count)
        
        var entropy = 0.0
        

        for labelCount in labelsCounts {
            
            entropy += Double(labelCount.1) / totalInstances * log2(1 / ((Double(labelCount.1) / totalInstances)))
            
        }
        
        return entropy
    }
    
    
    
    
    
    
    
    func splitOnFeature (data: [[Double]], featIndex: Int) -> ([Double : Node], Double) {
        
        /*
         This function splits the dataset in subsets, based on a specific feature
         
         - Parameter:      data: the dataset to split
                      featIndex: the index of the feature used to split the dataset
         
         - Returns: tuple made by: a dictionary made by the children nodes that contain the subsets yet created
                                   the weighted entropy of the split
         
         - Note: the keys of the dictionary are the values of the feature
         */
        
        let featureValues = data.map { $0[featIndex] }
        let uniqueValues = featureValues.unique()
        let totalInstances = data.count
        
        var splitNodes = [Double: Node]() //dizionario di key double e dato Node
        var weightedEntropy = 0.0
        var node = Node()
        var nodeEntropy = 0.0
        var partitionY = [Double] ()
        var partition = [[Double]]()
        
        for (uniqueValue, _) in uniqueValues {
            
            partition = data.filter { ($0[featIndex] ) == uniqueValue }
            node = Node(data: partition)
            splitNodes[uniqueValue] = node
            partitionY = getY(data: partition)
            
            nodeEntropy = calculateEntropy(Y: partitionY)
            weightedEntropy += (Double(partition.count) / Double(totalInstances)) * nodeEntropy
            
            partition.removeAll()
            
        }
        
        return (splitNodes, weightedEntropy)
    }
    
    
    
    
    
    
    
    func getY(data: [[Double]]) -> [Double] {
        
        /* 
         This function extracts the last column from the dataset
         
         - Parameter: A 2D array of Double values representing the dataset
         
         - Returns: An array of Double values representig the column extracted
         
         - Example: data = [ [ 0, 1, 0, 0 ],
                             [ 1, 0, 0, 1 ],
                             [ 1, 1, 1, 0 ] ]

                    getY(data) returns the array [ 0, 1, 0 ]
         */

        let y = data.map { $0.last ?? 0 }
        
        return y
        
    }
    
    
    
    
    
    
    
    func meetCriteria (node: Node) -> Bool {
        
        /*
         This function checks if the node respects the criteria of  having entropy equal to zero
        
        - Parameters: node: the node containing the subset of the original dataset to check
         
        - Returns: Bool: if the entropy is 0 it returns true, otherwise it returns false
         */
        
        let y = getY(data: node.data ?? [])
        
        if calculateEntropy(Y: y) == 0 {
            
            return true
            
        } else {
            
            return false
            
        }
        
    }
    
    
    
    
    
    
    
    func getPredClass(Y: [Double]) -> Double {
        
        /*
         This function calculates the predicted class label based on the input array of Double values representing class labels
         
        - Parameter: An array of Double values representing class labels
         
        - Returns: the label predicted, i.e. the most frequent one
         */
        
        var labels = [Double]()
        var labelsCounts = [Int]()
        for tupla in Y.unique() {
            labels.append(tupla.0)
            labelsCounts.append(tupla.1)
        }
        
        let index = labelsCounts.firstIndex(of: labelsCounts.max() ?? 0) ?? 0
        
        return labels[index]
    }
    
    
    
    
    
    
    
    func bestSplit (node: Node) {
        
        /*
         This function recursively finds the best split for a given node in a decision tree. It evaluates whether the node meets the criteria for termination based on entropy. If the criteria are met, the function assigns the node as a leaf node and determines the predicted class label. Otherwise, it iterates through each feature and calculates the entropy of potential splits. It selects the split that minimizes entropy and continues the splitting process recursively for each child node
         
         - Parameter: a node of the decision tree containind the dataset to split
         
         - Notes: - This function does not return any value. Instead, it modifies the node object and its children to create a           decision tree structure
                  - It utilizes the splitOnFeature function to calculate potential splits on each feature and determine the split that minimizes entropy
                  - The function operates recursively, splitting the node into child nodes until termination criteria are met or no further splitting is possible
         */
        
        if meetCriteria(node: node) {
            
            node.isLeaf = true
            
            let y = getY(data: node.data ?? [])
            
            node.predClass = getPredClass(Y: y)
            
            return
        }
        
        var indexFeatureSplit = -1
        var minEntropy = 1.0
        var splitNodes: [Double : Node]
        var weightedEntropy: Double
        var childNodes: [Double : Node] = [:]
        
        if let count = node.data?[0].count {
            
            for i in 0..<count - 1 {
                
                let splits = splitOnFeature(data: node.data ?? [], featIndex: i)
                
                splitNodes = splits.0
                weightedEntropy = splits.1
                
                if weightedEntropy < minEntropy {
                    
                    childNodes = splitNodes
                    minEntropy = weightedEntropy
                    indexFeatureSplit = i
                    
                }
            }
            
            node.children = childNodes
            node.splitOn = indexFeatureSplit
            
            for child_node in childNodes.values {
                bestSplit(node: child_node)
            }
                
        } else {
            
            // Handle the case where node.data is nil
        }
        
    }
    
    
    
    
    
    
    
    func fit(X: [[Double]], Y: [Double]) {
        
        /*
        This function fits a decision tree model to the provided dataset. It combines the feature matrix X and the target variable Y into a single dataset, assigns it to the root node of the decision tree, and then initiates the process of finding the best splits for each node recursively using the bestSplit function
         
        - Parameters: - X: A 2D array of Double values representing the feature matrix of the dataset
                      - Y: An array of Double values representing the target variable or class labels of the dataset
         
        - Notes: - This function does not return any value. It modifies the root node of the decision tree and its children to           create the decision tree model based on the provided dataset
                 - The paramete X HAS TO not comprehend the target labels. In fact the function combines the feature matrix X and target variable Y into a single dataset using the combine function
         
        */
        
        let data = combine(X: X, Y: Y)
        
        root.data = data
        
        bestSplit(node: root)
    }
    

    
    
    
    
    
    func traverseTree (x: [Double], node: Node) -> Double {
        /*
         This function traverses the decision tree to predict the class label for a given input feature vector x. It recursively navigates through the decision tree nodes starting from the root node until it reaches a leaf node. At each node, it evaluates the feature value of x corresponding to the splitting criterion of the node and proceeds to the appropriate child node. Once it reaches a leaf node, it returns the predicted class label stored in that node
         
         - Parameters: - x: An array of Double values representing the feature vector for which the class label is to be predicted
                       - node: The current node in the decision tree traversal
         
         - Returns: The predicted label for the input x
         
         - Notes: It retrieves the splitting criterion stored in the current node (calculated during the fitting process)
        */
        if node.isLeaf {
            
            return node.predClass ?? -1
        }
        
        let featValue = x[node.splitOn ?? -1]
        
        let predictedClass = traverseTree(x: x, node: node.children![featValue] ?? fatalError("AOOOOOO") as! Node )
        
        return predictedClass
    }
    
    
    
    
    

    
    func predict(X: [[Double]])-> [Double] {
        
        /*
         This function predicts the class labels for a set of input feature vectors using the trained decision tree model. It iterates through each feature vector in the input array X, and for each feature vector, it calls the traverseTree function to traverse the decision tree and predict the class label. The predicted class labels are collected and returned as an array.
         
         - Parameters: A 2D array of Double values representing the feature matrix for which class labels are to be predicted
         
         - Returns: An array of Double values representing the predicted class labels for the input feature matrix X
        */
        
        var predictions = [Double] ()
        
        for row in X {
            
            predictions.append(traverseTree(x: row, node: root))
            
        }
        
        return predictions
        
    }
    


    
    
    
    
}
