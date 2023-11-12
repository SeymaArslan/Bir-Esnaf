//
//  CompanyViewModel.swift
//  Bir Esnaf
//
//  Created by Seyma on 7.11.2023.
//  "https://lionelo.tech/birEsnaf/allCompanies.php"

import Foundation

class CompanyViewModel {
    
    var companies: [CompanyElement] = []
    var error: String = ""
    var loading: Bool = false
    
    func allCompanies() {
        self.loading = true
        let url = URL(string: "https://lionelo.tech/birEsnaf/allCompanies.php")!
        WebService().allCompanies(url: url) { result in
            self.loading = false
            switch result {
            case .success(let companies):
                self.companies = companies!
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error = "Parsing Error"
                case .serverError:
                    self.error = "Server Error"
                case .badUrl:
                    self.error = "Url Error"
                case .noData:
                    self.error = "Data Error"
                }
            }
        }
    }
    
}
