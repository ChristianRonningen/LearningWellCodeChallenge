//
//  DataFetcher.swift
//  LearningWellCodeChallenge
//
//  Created by Christian Rönningen on 2018-11-02.
//

import Foundation

func fetchStatistics(completion: @escaping (MetadataResponse?, StatisticsResponse?) -> ()) {
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: Query.metadata.urlRequest!) { (data, response, error) in
        guard let metaDataValue = data else {
            completion(nil, nil)
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let metaModel = try decoder.decode(MetadataResponse.self, from: metaDataValue)
            
            let statisticsTask = session.dataTask(with: Query.statistics.urlRequest!, completionHandler: { (data, response, error) in
                    guard let statisticsDataValue = data else {
                        completion(nil, nil)
                        return
                    }
                    
                    do {
                        let model = try decoder.decode(StatisticsResponse.self, from: statisticsDataValue)
                        completion(metaModel, model)
                    } catch {
                        print(error)
                    }
                    
            })
            statisticsTask.resume()
        } catch {
            print(error)
        }
        
    }
    task.resume()
    
//    Alamofire.request(Query.metadata).responseData(queue: nil) { (data) in
//        guard let metaDataValue = data.value else {
//            completion(nil, nil)
//            return
//        }
//
//        let decoder = JSONDecoder()
//        do {
//            let metaModel = try decoder.decode(MetadataResponse.self, from: metaDataValue)
//
//            Alamofire.request(Query.statistics)
//                .responseData(queue: nil) { (data) in
//                    guard let statisticsDataValue = data.value else {
//                        completion(nil, nil)
//                        return
//                    }
//
//                    do {
//                        let model = try decoder.decode(StatisticsResponse.self, from: statisticsDataValue)
//                        completion(metaModel, model)
//                    } catch {
//                        print(error)
//                    }
//
//            }
//        } catch {
//            print(error)
//        }
//    }
}
