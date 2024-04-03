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
        Initializes the decision tree classifier with a root node.
            
        - Parameter root: The root node of the decision tree.
        */
        self.root = root
        
    }
    
    func calculateEntropy (Y: [Double]) -> Double {
        
        /*
        Calculates the entropy of a set of labels.
             
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
         Splits the dataset in subsets, based on a specific feature
         
         - Parameter:      data: the dataset to split
                      featIndex: the index of the feature used to split the dataset
         
         - Returns: tuple made by: a dictionary made by the children nodes that contain the subsets yet created
                                   the weighted entropy of the split
         
         - Note: the keys of the dictionary are the values of the feature
         */
        
        let featureValues = data.map { $0[featIndex] }
        let uniqueValues = featureValues.unique()
        
        var splitNodes = [Double: Node]() //dizionario di key double e dato Node
        var weightedEntropy = 0.0
        let totalInstances = data.count
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

        let y = data.map { $0.last ?? 0 }
        
        return y
        
    }
    
    func meetCriteria (node: Node) -> Bool {
        // DA TESTARE
        let y = getY(data: node.data ?? [])
        
        if calculateEntropy(Y: y) == 0 {
            
            return true
            
        } else {
            
            return false
            
        }
        
    }
    
    func getPredClass(Y: [Double]) -> Double {
        // DA TESTARE
        var labels = [Double]()
        var labelsCounts = [Int]()
        for tupla in Y.unique() {
            labels.append(tupla.0)
            labelsCounts.append(tupla.1)
        }
        
/*        guard let index = labels_counts.max() else { return 0 }*/ // ????????????????????
        
        let index = labelsCounts.firstIndex(of: labelsCounts.max() ?? 0) ?? 0

//        if index == 0 {
//            return labels[index]
//        } else {
//            return labels[index-1]
//        }
        
        return labels[index]
    }
    
    func bestSplit (node: Node) {
        // DA TESTARE
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
        // DA TESTARE
        
        let data = combine(X: X, Y: Y)
        
        root.data = data
        
        bestSplit(node: root)
    }
    

    func traverseTree (x: [Double] /* TESTAAAAAAAAAAA */, node: Node) -> Double {
        
        if node.isLeaf {
            
            return node.predClass ?? -1
        }
        
        let featValue = x[node.splitOn ?? -1]
        
        let predictedClass = traverseTree(x: x, node: node.children![featValue] ?? fatalError("AOOOOOO") as! Node )
        
        //UN BOTTO DI PROBLEMI CON STA FUNC RICORSIVA
        return predictedClass
    }
    

    
    func predict(X: [[Double]])-> [Double] {
        
        var predictions = [Double] ()
        
        for row in X {
            predictions.append(traverseTree(x: row, node: root))
        }
        
        return predictions
        
    }
    


    
    
    
    
}
