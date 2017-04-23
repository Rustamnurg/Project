//
//  SearchController.swift
//  Project
//
//  Created by Rustam N on 11.04.17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

//TODO: сделать один активный массив

class SearchController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedElementDelegate: Selectlement? = nil
    var state: Int = 0
    var url: String! = ""
    let arr = ["dasd", "sdassa", "123", "sd1"]
    var filterdArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarInit()
    //    print(state)
        
        
    }
    
}

extension SearchController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterdArr.count > 0 {
            return filterdArr.count
        }
        return arr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if filterdArr.count > 0 {
            cell.textLabel?.text = filterdArr[indexPath.row]
        }
        else{
            cell.textLabel?.text = arr[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var name = ""
        if filterdArr.count > 0 {
            name = filterdArr[indexPath.row]
        }
        else{
            name = arr[indexPath.row]
        }
        selectedElementDelegate?.setElement(name: name, url: "url", state: state)
        navigationController?.popViewController(animated: true)
        
    }
    
}


    

extension SearchController: UISearchBarDelegate{
    func searchBarInit(){
        searchBar.delegate = self
        var message = ""
        switch state {
            
        case EventFlow.route.state:
            message = "номер маршрута"
        case EventFlow.direction.state:
            message = "напраление"
        case EventFlow.stop.state:
            message = "остановку"
        default:
            message = "?"
        }
        searchBar.placeholder = "Выберите \(message)"
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
    }
    
    func  searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdArr = arr.filter { arr in
            return arr.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
        
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}





