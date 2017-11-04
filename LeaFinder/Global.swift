//
//  Global.swift
//  LeaFinder
//
//  Created by Alisson L. Selistre on 04/11/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

let minAmplitude: Int = 2
var maxAmplitude: Int = 2
var depth: Int = 3

var randomAmplitude: Int {
    return randomValue(between: minAmplitude, and: maxAmplitude)
}

// tree data
var rootNode = Node()
var leafs: [Node] = []

// results of the search
var finalLeaf: Node?
var nodesTraveled: Int = 0
var searchStartTime: Date?
var searchEndTime: Date?

var timeSpentInSearch: TimeInterval {
    guard let startTime = searchStartTime else { return 0 }
    return searchEndTime?.timeIntervalSince(startTime) ?? 0
}

// MARK: generating the tree

func generateTree(completion: @escaping (() -> Void)) {

    DispatchQueue.global().async {

        resetTree()
        rootNode = generateNode(forDepthLevel: 0)
        chooseTheFinalLeaf()

        DispatchQueue.main.async {
            completion()
        }
    }
}

private func generateNode(forDepthLevel depthLevel: Int) -> Node {
    let node = Node()
    node.children = generateChildren(depthLevel: depthLevel + 1)

    if node.children.count == 0 {
        leafs.append(node)
    }

    return node
}

private func generateChildren(depthLevel: Int) -> [Node] {

    var children: [Node] = []

    if depthLevel <= depth {
        for _ in 1...randomAmplitude {
            let childNode = generateNode(forDepthLevel: depthLevel)
            children.append(childNode)
        }
    }

    return children
}

private func chooseTheFinalLeaf() {
    let leafIndex = randomValue(between: 0, and: leafs.count - 1)

    if leafIndex < leafs.count {
        let leaf = leafs[leafIndex]
        leaf.value = "The final leaf is here!"
    }
}

// MARK: solving the tree with BFS

func findSolutionWithBFS(completion: @escaping (() -> Void)) {

    resetResults()
    searchStartTime = Date()

    DispatchQueue.global().async {
        searchFinalLeafUsingBFSIn(nodes: [rootNode], completion: completion)
    }
}

private func searchFinalLeafUsingBFSIn(nodes: [Node], completion: @escaping (() -> Void)) {

    if finalLeaf != nil { return }

    var children: [Node] = []

    for node in nodes {

        nodesTraveled += 1

        if !node.value.isEmpty {

            finalLeaf = node

            searchEndTime = Date()

            DispatchQueue.main.async {
                completion()
            }

            return
        }

        children.append(contentsOf: node.children)
    }

    searchFinalLeafUsingBFSIn(nodes: children, completion: completion)
}

// MARK: solving the tree with DFS

func findSolutionWithDFS(completion: @escaping (() -> Void)) {

    resetResults()
    searchStartTime = Date()

    DispatchQueue.global().async {
        searchFinalLeafUsingDFSIn(node: rootNode, completion: completion)
    }
}

private func searchFinalLeafUsingDFSIn(node: Node, completion: @escaping (() -> Void)) {

    if finalLeaf != nil { return }

    nodesTraveled += 1

    if !node.value.isEmpty {
        finalLeaf = node

        searchEndTime = Date()

        DispatchQueue.main.async {
            completion()
        }

        return
    } else {
        for child in node.children {
            searchFinalLeafUsingDFSIn(node: child, completion: completion)
        }
    }
}

// MARK: helpers

private func randomValue(between min: Int, and max: Int) -> Int {
    let randomNumber = Int(arc4random_uniform(UInt32(max + 1) - UInt32(min)) + UInt32(min))
    return randomNumber
}

private func resetTree() {
    leafs.removeAll()
    rootNode = Node()
}

private func resetResults() {
    finalLeaf = nil
    searchStartTime = nil
    searchEndTime = nil
    nodesTraveled = 0
}
