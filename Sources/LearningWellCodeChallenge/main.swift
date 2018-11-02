import Foundation

private let dispatchGroup = DispatchGroup()

dispatchGroup.enter()

fetchStatistics { (metadata: MetadataResponse?, statistics: StatisticsResponse?) -> () in
    guard
        let metadata = metadata,
        let statistics = statistics
    else {
        dispatchGroup.leave()
        return
    }
    printResult(metadata: metadata, statistics: statistics)
    dispatchGroup.leave()
}

dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(EXIT_SUCCESS)
}
dispatchMain()
