//
//  ViewController.swift
//  jopFinder
//
//  Created by Deema on 4/4/19.
//  Copyright © 2019 Deema. All rights reserved.
//

import UIKit
import SDWebImage

class JobList: UIViewController{
    
    @IBOutlet weak var tableList: UITableView!
    var selectedUrl:String!
    
    private var searchObject:SearchObject!
    
    var jobs = [JobObject]()
    var github = GithubObject()
    var searchGov = SearchGovObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.isNavigationBarHidden = false
        }
        self.searchObject = SearchController.parameters
        if searchObject.provider == .github{
            getJobsFromGithub()
        }else if searchObject.provider == .searchGov{
            getJobsFromSearchGov()
        }
    }
    
   
    
    func getJobsFromGithub() {
        github.description = searchObject.title
        github.lat = searchObject.latitude
        github.long = searchObject.longitude
        
        github.get { (JobList , error) in
            if error! {
                self.alert(message: "Error")
            }else{
                self.jobs = JobList!
                if self.jobs.isEmpty {
                    self.alert(message: "No jobs")
                    return
                }
                self.tableList.reloadData()
            }
            
        }
    }
    
    func getJobsFromSearchGov() {
        searchGov.query = searchObject.title
        searchGov.lat = searchObject.latitude
        searchGov.long = searchObject.longitude
        
        searchGov.get { (JobList , error) in
            if error! {
                self.alert(message: "Error")
            }else{
                self.jobs = JobList!
                if self.jobs.isEmpty {
                    self.alert(message: "No jobs")
                    return
                }
                self.tableList.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailsSegue {
            (segue.destination as! DetailsController).url = selectedUrl
        }
    }
    
    func alert(message: String){
        let alert = UIAlertController(title: "Job Finder", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension JobList:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:JobTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.jobCell) as! JobTableViewCell
        let job = jobs[indexPath.row]
        cell.name.text = job.name
        cell.title.text = job.title
        cell.Location.text = job.location
        cell.createdDate.text = job.postDate
        cell.logo.loadImage.sd_setImage(with: URL(string: job.logo), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if jobs[indexPath.row].url != nil {
            selectedUrl = jobs[indexPath.row].url!
        }
        performSegue(withIdentifier: Constants.detailsSegue, sender: self)
    }
}

