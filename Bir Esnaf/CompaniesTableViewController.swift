//
//  CompaniesTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 5.11.2023.
//

import UIKit

class CompaniesTableViewController: UITableViewController{
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var companyVM = CompanyViewModel()
    var companyList = [Company]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        
        companyVM.allCompanies()
    }
/*
    private func setupBindings() {
        companyVM.loading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: bag)
        companyVM.error.observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString) // belki progressHUF
            }.disposed(by: bag)
        
//        companyVM.companies.observe(on: MainScheduler.asyncInstance).subscribe { companies in
//            self.companyList = companies
//            self.tableView.reloadData()
//        }.disposed(by: bag)
        
        companyVM.companies.observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: CompanyTableViewCell.self)) { row, item, cell in
                cell.item = item
            }.disposed(by: bag)
        
    }*/
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companyList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompanyTableViewCell
        
        return cell
    }
}
