//
//  MasterTableViewController.swift
//  HappyPlaces
//
//  Created by Kilian Kellermann on 24/08/16.
//  Copyright © 2016 Kilian Kellermann. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, NewLocationDelegate {

    var dataSource: HappyPlaceDataSource
    required init?(coder aDecoder: NSCoder) {
        dataSource = ArrayRessource()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //
    func newLocationAdded(name: String, lat: Double, long: Double) {
        let location = HappyPlace(name: name, lat: lat, long: long)
        dataSource.insertPlace(happyPlace: location)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSource.getPlaces().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)

        let happyPlace = dataSource.getPlace(for: indexPath.row)
        cell.textLabel?.text = happyPlace.name
        
        return cell
    }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPlace" {
            let ctrl = segue.destination as! DetailViewController
            
            guard let indexPath = tableView.indexPathForSelectedRow else {
                print("Keine Zeile gewählt?")
                return
            }
            
            ctrl.currentPlace = dataSource.getPlace(for: indexPath.row)
        }
        
        if segue.identifier == "randomPlace" {
            let ctrl = segue.destination as! DetailViewController
            
            ctrl.currentPlace = dataSource.getRandomPlace()
        }
        
    }
    

}
