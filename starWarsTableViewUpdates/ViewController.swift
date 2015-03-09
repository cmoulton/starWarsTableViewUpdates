//
//  ViewController.swift
//  starWarsTableViewUpdates
//
//  Created by Christina Moulton on 2015-03-08.
//  Copyright (c) 2015 Teak Mobile Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView?
  var movies:Array<String>?
  var tapCount = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    movies = Array<String>()
    movies?.append("Star Wars")
    movies?.append("The Empire Strikes Back")
    movies?.append("A New Hope")
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPrequels:")
    self.navigationItem.rightBarButtonItem = addButton
  }
  
  func addPrequels(sender: AnyObject) {
    tapCount++
    if (tapCount == 1)
    {
      // Add the prequels if we're not showing them yet
      movies?.insert("The Phantom Menace", atIndex: 0)
      movies?.insert("The Attack of the Clones", atIndex: 1)
      movies?.insert("Revenge of the Sith", atIndex: 2)
      
      // use a single call to update the tableview with 3 indexpaths
      self.tableView?.insertRowsAtIndexPaths(
        [NSIndexPath(forRow: 0, inSection: 0),
          NSIndexPath(forRow: 1, inSection: 0),
          NSIndexPath(forRow: 2, inSection: 0)],
        withRowAnimation: .Automatic)
    }
    else if (tapCount == 2)
    {
      // Add the sequels, even though they don't exist yet
      // use one call to delete and one call to add rows to the tableview
      // so we need to wrap them in beginUpdates()/endUpdates()
      // add the sequels
      if let count = movies?.count
      {
        movies?.append("The Force Awakens")
        movies?.append("Episode VIII")
        movies?.append("Episode IX")
        self.tableView?.insertRowsAtIndexPaths([NSIndexPath(forRow: count, inSection: 0),
          NSIndexPath(forRow: count+1, inSection: 0),
          NSIndexPath(forRow: count+2, inSection: 0)], withRowAnimation: .Automatic)
      }
    }
    else if (tapCount == 3)
    {
      movies?.removeAtIndex(0)
      movies?.removeAtIndex(0)
      movies?.removeAtIndex(0)
      self.tableView?.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 1, inSection: 0), NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Automatic)
    }
  }
  
  // MARK: - TableView
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    if let movieTitle = movies?[indexPath.row]
    {
      cell.textLabel!.text = movieTitle
    }
    else
    {
      cell.textLabel!.text = ""
    }
    return cell
  }
  
/*  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      movies.removeObjectAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }*/



}

