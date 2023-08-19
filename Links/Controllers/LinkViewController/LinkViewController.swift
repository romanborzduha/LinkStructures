//
//  LinkViewController.swift
//
//  Created by Roman Borzdukha on 15.08.2023.
//

import Combine
import UIKit

class LinkViewController: UIViewController {
    
    var viewModel: LinkStructureModelProtocol?
    var tableViewDataSource: TableViewDataSource = .empty {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private var bag = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        
        bind()
        viewModel?.start()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        
        setupNavigationBar()
        
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        let sortItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortAction))
        navigationItem.rightBarButtonItem = sortItem
    }
    
    private func bind() {
        viewModel?.tableViewDataSourcePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] dataSource in
                self?.tableViewDataSource = dataSource
            })
            .store(in: &bag)
    }
    
    // MARK: - Selectors
    @objc func sortAction() {
        viewModel?.sortAction()
    }
}

extension LinkViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewDataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewDataSource.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = tableViewDataSource.cellModel(atIndexPath: indexPath),
                let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseId, for: indexPath) as? BaseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = tableViewDataSource.cellModel(atIndexPath: indexPath)
        model?.action?()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

