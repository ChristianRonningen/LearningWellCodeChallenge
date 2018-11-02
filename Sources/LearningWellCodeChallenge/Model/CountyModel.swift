//
//  CountyModel.swift
//  LearningWellCodeChallenge
//
//  Created by Christian Rönningen on 2018-10-30.
//

import Foundation

struct StatisticsResponse: Decodable {
    let columns: [Dictionary<String, String>]
    let comments: [Dictionary<String, String>]
    let data: [CountyModel]
    
    // Use set to remove duplicates
    var years: Set<String> {
        return Set(data.compactMap({ county in
            return county.year
        }))
    }
    
    func topCounty(byYear: String) -> (code: String, county: String, value: Double)? {
        let matchingYear = data.compactMap({ model -> (code: String, county: String, value: Double)? in
            guard model.year == byYear else {
                return nil
            }

            guard let value = Double(model.values.first!),
                let code = model.code,
                let year = model.year
            else {
                return nil
            }
            return (code, year, value)
        })
        return matchingYear.max(by: {
            return $0.value < $1.value
        })
    }
    
}

struct CountyModel: Decodable {
    let key: [String]   // CountyCode, Year
    let values: [String]    // Values

    var code: String? {
        return key.first
    }
    var year: String? {
        guard key.count >= 2 else {
            return nil
        }
        return key[1]
    }
}
