//
//  Node.swift
//  LeaFinder
//
//  Created by Alisson L. Selistre on 04/11/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

class Node: Codable {

    var value = ""
    var children: [Node] = []
}

// MARK: printer helpers

private let nodeSymbol = "-"
private let finalNodeSymbol = "•"

extension Node {

    var asJsonPrettyPrinted: String? {

        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        var jsonString: String?
        if let jsonData = try? jsonEncoder.encode(self) {
            jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        }
        return jsonString
    }

    var childrenHierarchyRepresentedAsList: [String] {
        return generateTreeHierarchy(withNodes: [self])
    }

    private func generateTreeHierarchy(withNodes nodes: [Node], currentList: [String] = []) -> [String] {

        guard nodes.count > 0 else { return currentList}

        var mutatingList = currentList

        var children: [Node] = []

        var nodesLinePrettyPrinted = ""
        for node in nodes {
            nodesLinePrettyPrinted += !node.value.isEmpty ? finalNodeSymbol : nodeSymbol
            children.append(contentsOf: node.children)
        }
        mutatingList.append(nodesLinePrettyPrinted)

        return generateTreeHierarchy(withNodes: children, currentList: mutatingList)
    }

    private var childrenPrettyPrinted: String {

        var childrenString = ""
        for child in children {
            childrenString += !child.value.isEmpty ? finalNodeSymbol : nodeSymbol
        }

        return childrenString
    }
}
