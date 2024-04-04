# Decision Tree Classifier
This repository contains an implementation of a simple Decision Tree Classifier, entirely made in Swift

The code works with only categorical features. Basically, once a root node is initialized, to train the model on a given dataset the latter is allocated in full as the data of the root node. Then we proceed by splitting the dataset in the node on each possible feature, measuring the entropy of the split. The goal of the algorithm is to minimize the entropy, so as to obtain subsets of the original dataset that are as pure as possible. Once all the possible splits have been evaluated, the one that minimizes entropy is chosen and the children are proceeded recursively. the index of the feature on which the dataset was split is saved in the spiltOn of the node. Once the subsets are pure, the nodes reached are marked as leaf nodes and then the process ends. This saves step by step how to split the dataset into each node. To label new data then it is therefore sufficient to have it follow the path saved in the nodes; ones a leaf is reached the data ara labelled

## Table of contents
[Introduction](#introduction)

[Code structure](#code-structure)

[Example](#example)

## Introduction
### What is a Decision Tree?

We often hear about Decision Trees when it comes to machine learning but the concept behind them is so simple

## Code Structure

### Node model

1. **data**: Represents the dataset associated with the node.

2. **children**: Stores child nodes associated with this node.

3. **splitOn**: Indicates the index used for splitting the data at this node.

4. **predClass**: Represents the predicted class at this node.

5. **isLeaf**: A flag indicating whether this node is a leaf node.

### Classifier model
1. **Initialization**: It initializes with a root node for the decision tree.

2. **Fitting the Model**: The `fit` function trains the decision tree model using the provided training data (`X` - feature matrix, `Y` - target variable). It combines the feature matrix `X` and the target variable `Y` into a single dataset and initiates the process of finding the best splits for each node recursively using the `bestSplit` function.

3. **Calculating Entropy**: It calculates the entropy of a set of labels using the `calculateEntropy` function. Entropy measures the impurity or disorder of a dataset.

4. **Splitting the Dataset**: The `splitOnFeature` function splits the dataset into subsets based on a specific feature. It returns a dictionary containing the child nodes representing the subsets and the weighted entropy of the split.

5. **Finding the Best Split**: The `bestSplit` function recursively finds the best split for a given node in the decision tree. It evaluates whether the node meets the criteria for termination based on entropy. If not, it iterates through each feature, calculates the entropy of potential splits, and selects the split that minimizes entropy.

6. **Traversing the Tree**: The `traverseTree` function traverses the decision tree to predict the class label for a given input feature vector. It recursively navigates through the decision tree nodes starting from the root node until it reaches a leaf node. At each node, it evaluates the feature value corresponding to the splitting criterion of the node and proceeds to the appropriate child node.

7. **Predicting Class Labels**: The `predict` function predicts the class labels for a set of input feature vectors using the trained decision tree model. It iterates through each feature vector in the input array `X` and calls the `traverseTree` function to predict the class label.

## Example


Create an instance of DecisionTreeClassifier with the root node
```
let rootNode = Node()

let classifier = DecisionTreeClassifier(root: rootNode)
```   
Generate some example data

```
let X: [[Double]] = [ [1, 1, 0, 1, 0, 0, 1, 1],
                      [1, 1, 0, 1, 1, 1, 1, 1],
                      [1, 0, 0, 1, 0, 0, 1, 0],
                      [0, 1, 0, 0, 0, 0, 1, 0],
                      [1, 0, 0, 1, 0, 0, 1, 0] ]

let Y: [Double] = [ 0,
                    1,
                    0,
                    1,
                    0 ]
```

Fit the classifier with the example data
```
classifier.fit(X: X, Y: Y)
```
   
Generate some test data to make predictions

```
let testData: [[Double]] = [ [0, 1, 1, 1, 0, 0, 1, 0],
                             [1, 0, 0, 1, 0, 0, 0, 1] ]
```
Make predictions using the trained classifier
```
let predictions = classifier.predict(X: testData)
```

Output: Predictions: [1.0, 0.0]


