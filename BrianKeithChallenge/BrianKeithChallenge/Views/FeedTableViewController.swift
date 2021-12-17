//
//  FeedTableViewController.swift
//  BrianKeithChallenge
//
//  Created by Brian Hogan on 12/17/21.
//

import UIKit
import Combine

class FeedTableViewController: UIViewController {
    
    // MARK:- privates properties
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        return tableview
    }()
    private let dataFeedViewModel = FeedViewModel()
    private var publishers = Set<AnyCancellable>()
    
    // MARK:- UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setupBinding()
    }
    
    // MARK:- private func
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        // configure constraint
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupBinding() {
        // binding for feeds
        dataFeedViewModel
            .feedsBinding
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &publishers)
        
        dataFeedViewModel.loadFeeds()
        
        // binding for error
        dataFeedViewModel
            .errorBinding
            .sink { [weak self] in
                self?.showErrorAlert()
            }
            .store(in: &publishers)
        
        // binding update row when get the image
        dataFeedViewModel
            .rowUpdateBinding
            .sink { [weak self] row in
                self?.tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }
            .store(in: &publishers)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: dataFeedViewModel.geterrorDescription(), preferredStyle: .alert)
        let acceptButton = UIAlertAction(title: "Accept", style: .default)
        alert.addAction(acceptButton)
        present(alert, animated: true)
    }
}

// MARK:- UITableViewDataSource
extension FeedTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFeedViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        let title = dataFeedViewModel.getTitle(at: row)
        let numComments = dataFeedViewModel.getNumComments(at: row)
        let imageData = dataFeedViewModel.getImageData(at: row)
        cell.configureCell(title: title, numComments: numComments, imageData: imageData)
        return cell
    }
    
}

// MARK:- UITableViewDelegate
extension FeedTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK:- UITableViewDelegate
extension FeedTableViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexes = tableView.indexPathsForVisibleRows ?? []
        let rows = indexes.map { $0.row }
        dataFeedViewModel.visibleRows(rows)
    }
}
