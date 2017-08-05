//
//  AuthorTableViewController.swift
//  My Quotes
//
//  Created by Hoàng Vũ Anh on 8/4/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class AuthorTableViewController: UITableViewController {
    
    var loadingView: UILabel = UILabel()
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let backendless = Backendless.sharedInstance()
    
    var authorList: [AUTHOR] = []
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        getNewAuthor()
        

       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func getNewAuthor() -> Void {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setSortBy(["created DESC"])
        let dataStore = self.backendless?.data.of(USER().ofClass())
        dataStore?.find(queryBuilder, response: { (sorted) -> () in
            self.authorList = sorted as! [AUTHOR]
            self.tableView.reloadData()
            self.loadingFinish()
            print("\(self.authorList)")
        },error: {(fault : Fault?) -> () in
            Toast(text: "Load Error").show()
        })
    }
    
    
    func loadingFinish() -> Void {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        loadingView.isHidden = true
    }

    
    func setLoadingText() -> Void {
        view.addSubview(loadingView)
        loadingView.text = "Loading"
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        loadingView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 1/30).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        loadingView.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: 5).isActive = true
        loadingView.textAlignment = NSTextAlignment.center
        loadingView.font = loadingView.font.withSize(10)
        loadingView.textColor = UIColor.lightGray
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setIndicatorView() -> Void {
        indicatorView.center = self.view.center
        indicatorView.hidesWhenStopped = true
        loadingView.isHidden = false
        indicatorView.isHidden = false
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        setLoadingText()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return authorList.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
