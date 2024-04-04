# Decision Tree Classifier
This repository contains an implementation of a simple Decision Tree Classifier, entirely made in Swift.

The code only works with categorical features. Basically, once a root node is initialised to train the model on a given dataset, the latter is fully allocated as the data of the root node. Then, the data set in the node is split for each possible feature and the entropy of the split is measured. The goal of the algorithm is to minimise the entropy in order to obtain subsets of the original dataset that are as pure as possible. After evaluating all possible splits, the one that minimises the entropy is chosen and the children are created. The index of the feature on which the dataset was split is stored in the spiltOn attribute of the node.The algorithm proceeds recursively on the children. When the subsets are pure, the nodes reached are marked as leaf nodes and the process ends. This stores, step by step, how the dataset was split into each node. To label new data, it is therefore sufficient to let it follow the path stored in the nodes; as soon as a leaf is reached, the data is labelled.

## Table of contents
[Introduction to Decision Trees](#introduction-to-decision-trees)

[Code structure](#code-structure)

[Example](#example)

## Introduction to Decision Trees
### What is a Decision Tree?

We often hear about Decision Trees when it comes to machine learning but the concept behind them is so simple. First of all they're called trees for the data structure they rely on

![TreeStructure](https://github.com/lezippo/decisionTreeClassifier/assets/148436988/425fb5b3-1024-4723-a3f8-2950ee6a5844)

The basic unit of a tree is a node. It's made by 2 parts: some data and something that indicates the next node in the structure. 
Linking the nodes like in the picture above we can create trees: we start from a root and we link it to its children. Each children node can have some childrens. If a node has no childrean it is called leaf node.

Decision trees are used to classify things

The best way to understand them is using a chart:



They are often used to classify things: they start from a dataset and start divideding the the dataset in subsets verifying some conditions. In the example we can see that the dataset of the cat and dogs has been split using the feature "ears": it means that we have created two nodes, children of the first one, and in one we have allocated all the data points, i. e. cat or dog of the dataset, having the floppy ears, in the other one insthead the dog or cat with pointy ears

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


