//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Josh Harsono on 3/19/18.
//  Copyright © 2018 Josh Harsono. All rights reserved.
//

import UIKit
import Foundation

class PeopleViewController: UITableViewController {
    var people: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://swapi.co/api/people")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        
                        for i in 0...9 {
                            let dict = resultsArray[i] as! NSDictionary
                            if let character = dict["name"] as? String {
                                self.people.append(character)
                                print(character)
                                print(self.people)
                                }
                            
                        }
                        self.tableView.reloadData()
                     }
                }
            } catch {
                print(error)
            }
})

        // execute the task and then wait for the response
        // to run the completion handler. This is async!
        task.resume()
        print(self.people)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()

       cell.textLabel?.text = people[indexPath.row]
        return cell
    
    }
}

