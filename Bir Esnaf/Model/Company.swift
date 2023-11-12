//
//  Company.swift
//  Bir Esnaf
//
//  Created by Seyma on 7.11.2023.
//

import Foundation

struct Company: Codable {
    let success: Bool
    let company: [CompanyElement]
}

struct CompanyElement: Codable {
    var compId: Int = 0
    var userMail: String = ""
    var compName: String = ""
    var compLogoURL: String = ""
    var compAddress: String = ""
    var compPhone: String = ""
    var compMail: String = ""
    var compBankName: String = ""
    var compBankBranchName: String = ""
    var compBranchCode: String = ""
    var compAccountType: String = ""
    var compAccountName: String = ""
    var compAccountNo: String = ""
    var compIban: String = ""
}
