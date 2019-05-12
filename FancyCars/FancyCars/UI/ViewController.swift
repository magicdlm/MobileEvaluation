//
//  MasterViewController.swift
//  FancyCars
//
//  Created by Leming Deng on 2019-05-11.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sortingView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func sortingViewValueChanged(_ sender: UISegmentedControl) {
        viewModel.sort = ViewModel.SortBy(rawValue: sender.selectedSegmentIndex)
        tableView.reloadData()
        
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        viewModel.fetchCars { (_) in
            self.spinner.stopAnimating()
            self.sortingView.isHidden = false
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Fancy Cars"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CarTableViewCell
        cell.configure(with: viewModel.cars[indexPath.row])
        return cell
    }

}

