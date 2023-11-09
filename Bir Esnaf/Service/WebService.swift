//
//  CompanyWebService.swift
//  Bir Esnaf
//
//  Created by Seyma on 9.11.2023.
//  

import Foundation

enum CompanyError: Error {
    case serverError  // web hatası
    case parsingError  // parse hatası
    case badUrl  // yanlış URL
    case noData  // data gelmiyor
}

class WebService {
    
    
    func allCompanies(url: URL, completion: @escaping (Result<[Company]?,CompanyError>) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                print(error?.localizedDescription ?? "")
                completion(.failure(CompanyError.badUrl))
            }
            guard let data = data, error == nil else {
                return completion(.failure(CompanyError.noData))
            }
            
            guard let companies = try? JSONDecoder().decode([Company].self, from: data) else {
                return completion(.failure(CompanyError.parsingError))
            }
            completion(.success(companies))
        }.resume()
    }
    
}
    
