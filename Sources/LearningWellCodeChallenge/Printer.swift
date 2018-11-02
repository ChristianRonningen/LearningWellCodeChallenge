//
//  Printer.swift
//  LearningWellCodeChallenge
//
//  Created by Christian Rönningen on 2018-11-02.
//

import Foundation

func printResult(metadata: MetadataResponse, statistics: StatisticsResponse) {
    statistics.years.sorted().forEach({ year in
        if let topCounty = statistics.topCounty(byYear: year) {
            if let regionName = metadata.variables.first?.valueText(for: topCounty.code) {
                print("\(year): \(regionName) \(topCounty.value)%")
            }
        }
    })
}
