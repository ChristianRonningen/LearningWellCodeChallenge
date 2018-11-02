//
//  MetadataResponse.swift
//  LearningWellCodeChallenge
//
//  Created by Christian Rönningen on 2018-10-30.
//

import Foundation

struct MetadataResponse: Decodable {
    let title: String
    let variables: [MetadataVariables]
}

struct MetadataVariables: Decodable {
    let code: String
    let text: String
    let values: [String]        // Codes
    let valueTexts: [String]    // Names
    
    func valueText(for value: String) -> String? {
        return Array(zip(values, valueTexts)).first(where: { (code, name) -> Bool in
            return code == value
        })?.1
    }
}
