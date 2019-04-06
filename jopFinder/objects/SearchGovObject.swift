//
//  SearchGov.swift
//  jopFinder
//
//  Created by Deema on 4/4/19.
//  Copyright © 2019 Deema. All rights reserved.
//

import Foundation
class SearchGovObject:Api{
    
    var query:String!
    var lat:Double!
    var long:Double!
    var page:Int!
    
    func get(done: @escaping (_ jobs: [JobObject]? , _ error:Bool?) -> ()) {
        Api.baseURL = Constants.searchGovURL
        let latString = self.lat == nil ? "" : "\(self.lat!)"
        let longString = self.long == nil ? "" : "\(self.long!)"
        SearchGovObject.networking.get("/jobs/search.json?query=\(self.query!)&lat_lon=\(latString),\(longString)") { (result) in
            var jobs = [JobObject]()
            switch result{
            case .success(let response):
                let json = response.arrayBody
                for jobRow in json {
                    let job = JobObject()
                    job.logo = jobRow["company_logo"] as? String ?? ""
                    job.name = jobRow["organization_name"] as? String ?? ""
                    job.title = jobRow["position_title"] as? String ?? ""
                    job.location = (jobRow["locations"] as? [String] ?? []).first
                    job.postDate = (jobRow["start_date"] as? String ?? "").convertDateFormatter(format: Constants.searchGovDateFormated)
                    job.url = jobRow["url"] as? String ?? ""
                    jobs.append(job)
                }
                done(jobs , false)
            case .failure(let response):
                done(nil , true)
                print(response.statusCode)
            }
        }
    }
    
}
