//
//  EmojiReaderViewController.swift
//  Emoji Reader (learning project)
//
//  Created by Alexander on 12.09.2021.
//

import UIKit

class EmojiReaderViewController: UITableViewController {
    
    var emojiObjects = [
        Emoji(emoji: "🤣", name: "Rofl", description: "Rofling everyday on everything", isFavorite: false),
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavorite: false),
        Emoji(emoji: "⚽️", name: "Fotball", description: "Let's play football", isFavorite: false),
        Emoji(emoji: "🥃", name: "Wiskey", description: "Let's drink some wiskey", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "Emoji Reader"
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        //        Get an emojiObject from the NewEmojiTableViewController
        let segueVC = segue.source as! NewEmojiTableViewController
        let emoji = segueVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojiObjects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            //        Create a new row in the tableview and add a new emoji from the NewEmojiTableViewController
            let newIndexPath = IndexPath(row: emojiObjects.count, section: 0)
            emojiObjects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        
        //        Get an emoji from the selected row
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = emojiObjects[indexPath.row]
        
        //        Go to the newEmoji screen
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojiObjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojiObjects[indexPath.row]
        cell.setConfiguration(emoji: emoji)
        
        return cell
    }
    
    //  Add an editing action for table rows
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //    Add a moving ability for table rows
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojiObjects.remove(at: sourceIndexPath.row)
        emojiObjects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    //    Add a left swipe bar and add an action for action buttons
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favorite = favoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favorite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { action, view, complition in
            self.emojiObjects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complition(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var emoji = emojiObjects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favorite") { action, view, complition in
            emoji.isFavorite = !emoji.isFavorite
            self.emojiObjects[indexPath.row] = emoji
            complition(true)
        }
        action.backgroundColor = emoji.isFavorite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
