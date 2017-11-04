//
//  TreeViewController.swift
//  LeaFinder
//
//  Created by Alisson L. Selistre on 04/11/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

private enum TreeViewStyle {
    case json
    case tree
}

class TreeViewController: UIViewController {

    @IBOutlet weak var bfsButton: UIButton!
    @IBOutlet weak var bfsLoadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var dfsButton: UIButton!
    @IBOutlet weak var idfsLoadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var treeStyleDescriptionLabel: UILabel!

    @IBOutlet weak var treeContainerView: UIView!
    @IBOutlet weak var treeTextView: UITextView!
    @IBOutlet weak var treeTableView: UITableView!

    private var viewStyle: TreeViewStyle = .json {
        didSet {
            updateUI()
        }
    }

    internal var treeLines: [String] {
        return rootNode.childrenHierarchyRepresentedAsList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTreeView()
        updateUI()
    }

    @objc func handleTreeStyleTapGesture() {
        viewStyle = viewStyle == .json ? .tree : .json
    }

    // MARK: actions

    @IBAction func bfsButtonPressed(_ sender: UIButton) {
        isSearching(true)
        findSolutionWithBFS { [weak self] in
            self?.isSearching(false)
            self?.performSegue(withIdentifier: "results", sender: nil)
        }
    }

    @IBAction func dfsButtonPressed(_ sender: UIButton) {
        isSearching(true)
        findSolutionWithDFS { [weak self] in
            self?.isSearching(false)
            self?.performSegue(withIdentifier: "results", sender: nil)
        }
    }

    // MARK: helpers

    private func isSearching(_ isSearching: Bool) {
        if isSearching {
            bfsLoadingIndicator.startAnimating()
            idfsLoadingIndicator.startAnimating()
        } else {
            bfsLoadingIndicator.stopAnimating()
            idfsLoadingIndicator.stopAnimating()
        }

        bfsButton.isEnabled = !isSearching
        dfsButton.isEnabled = !isSearching
    }

    private func setupTreeView() {

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTreeStyleTapGesture))
        treeContainerView.addGestureRecognizer(tapGesture)

        treeTextView.text = rootNode.asJsonPrettyPrinted
    }

    private func updateUI() {

        treeStyleDescriptionLabel.text = viewStyle == .json ? "Árvore representada como JSON:" : "Árvore representada com caracteres ASCII:"

        UIView.transition(with: treeContainerView, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {

            switch self.viewStyle {
            case .json:
                self.treeContainerView.bringSubview(toFront: self.treeTextView)
            case .tree:
                self.treeContainerView.bringSubview(toFront: self.treeTableView)
            }

        }, completion: nil)
    }
}

extension TreeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treeLines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: TreeLineTableViewCell.identifier, for: indexPath) as? TreeLineTableViewCell {
            let treeLineString = treeLines[indexPath.row]
            cell.treeLineLabel.text = treeLineString
            return cell
        }

        return UITableViewCell()
    }
}
