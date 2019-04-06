//
//  Github.swift
//  jopFinder
//
//  Created by Deema on 4/5/19.
//  Copyright © 2019 Deema. All rights reserved.
//
import Foundation

class GithubObject:Api{
    
    var description:String!
    var lat:Double?
    var long:Double?
    func get(done: @escaping (_ jobs: [JobObject]? , _ error: Bool?) -> ()) {
        //set networking header as Github URL
        Api.baseURL = Constants.githubURL
        let latString = self.lat == nil ? "" : "\(self.lat!)"
        let longString = self.long == nil ? "" : "\(self.long!)"
        GithubObject.networking.get("/positions.json?search=\(self.description!)&lat=\(latString)&long=\(longString)") { (result) in
            var jobs = [JobObject]()
            switch result{
            case .success(let response):
                let json = response.arrayBody
                for jobRow in json {
                    let job = JobObject()
                    job.logo = jobRow["company_logo"] as? String ?? ""
                    job.name = jobRow["company"] as? String ?? ""
                    job.title = jobRow["title"] as? String ?? ""
                    job.location = jobRow["location"] as? String ?? ""
                    job.postDate = (jobRow["created_at"] as? String ?? "").convertDateFormatter(format: Constants.githupDateFormated)
                    job.url = jobRow["company_url"] as? String ?? ""
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
