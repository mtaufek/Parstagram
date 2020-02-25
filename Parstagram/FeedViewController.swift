//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Adib Thaqif on 2/24/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell") as! PosterCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        print(user.username)
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        print(cell.captionLabel.text)
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        print(urlString)
        cell.photoView.af_setImage(withURL: url)
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
