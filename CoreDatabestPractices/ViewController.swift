//
//  ViewController.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/10/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = ViewModel()
    
    var count = Dynamic<Int>.init(0)
    var c = Dynamic<String>.init("a")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        
        viewModel.requestPosts()
        
        viewModel.updateUI = { status in
            switch status {
            case .didStart(let message):
                print(message)
                print()
            case .didEndWithSuccess(let message):
                print(message)
                print()
            case .didEndWithError(let error):
                print(error)
                print()
            default:
                return
            }
        }
        
        c ->> label.textBond
    }
    @IBAction func buttonAction(_ sender: Any) {
        count.value += 1
        print(map(count, { "\($0)"}).value)
        c.value = "\(count.value)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! TableViewCell
        c ->> cell.countLabel
        return cell
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

// MARK: Get Data
extension ViewController {
    func getData() {
        print("Get Data")
    }
}
