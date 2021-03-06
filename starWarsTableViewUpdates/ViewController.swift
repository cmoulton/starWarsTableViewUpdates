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
  var movies:Array<String>? = ["Star Wars", "The Empire Strikes Back", "A New Hope"]
  var tapCount = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "buttonTapped:")
    self.navigationItem.rightBarButtonItem = addButton
  }
  
  func buttonTapped(sender: AnyObject) {
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
      if let count = movies?.count
      {
        self.tableView?.beginUpdates()
        
        // add sequels
        movies?.append("The Force Awakens")
        movies?.append("Episode 8")
        movies?.append("Episode 9")
        self.tableView?.insertRowsAtIndexPaths(
          [NSIndexPath(forRow: count - 3, inSection: 0),
            NSIndexPath(forRow: count + 1 - 3, inSection: 0),
            NSIndexPath(forRow: count + 2 - 3, inSection: 0)],
          withRowAnimation: .Automatic)
        
        // remove prequels
        movies?.removeAtIndex(0)
        movies?.removeAtIndex(0)
        movies?.removeAtIndex(0)
        self.tableView?.deleteRowsAtIndexPaths(
        [NSIndexPath(forRow: 0, inSection: 0),
        NSIndexPath(forRow: 1, inSection: 0),
        NSIndexPath(forRow: 2, inSection: 0)],
          withRowAnimation: .Automatic)
        
        self.tableView?.endUpdates()
      }
    }
  }
  
  // MARK: - TableView
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    
    if let movieTitle = movies?[indexPath.row]
    {
      cell.textLabel!.text = movieTitle
    }
    else
    {
      cell.textLabel!.text = ""
    }
    
/*    for name in UIFont.familyNames() {
      println(name)
      if let nameString = name as? String
      {
        println(UIFont.fontNamesForFamilyName(nameString))
      }
    }*/

    let preferredDescriptor = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    var font = UIFont(name: "StarJediOutline", size: preferredDescriptor.pointSize)

    cell.textLabel?.font = font
    
    println("row: \(indexPath.row), title: \(cell.textLabel!.text!)")
    return cell
  }

}

