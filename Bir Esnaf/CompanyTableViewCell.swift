//
//  CompaniesTableViewCell.swift
//  Bir Esnaf
//
//  Created by Seyma on 5.11.2023.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        
    }
    /*
    public var item: CompanyElement! {
        didSet {
            self.companyImage.image = UIImage(named: item.compLogoURL)
            self.companyNameLabel.text = item.compName
        }
    }
    */

    
    
    func configureCell() {
        companyNameLabel.text = "denemeDeneme" // URL den gelecek
        setCompanyImage(imageLink: "denemedeneme")  // URL den gelecek
    }
    
    private func setCompanyImage(imageLink: String) {
        if imageLink != "" {
            // indirilen image
        } else {
            self.companyImage.image = UIImage(named: "companyLogo")?.circleMasked
        }
    }
    
}
