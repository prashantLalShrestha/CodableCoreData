//
//  ViewModel.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/16/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation

public enum Status {
    case `nil`
    case didStart(String)
    case didEndWithSuccess(String)
    case didEndWithError(String)
}


class ViewModel {
    
    var currentState: Status = .nil {
        willSet {
            updateUI(currentState)
        }
        didSet {
            updateUI(currentState)
        }
    }
    
    var posts: [Posts] = [] {
        didSet {
            print(posts)
            print()
            // Update Database
        }
    }
    
    var updateUI: ((Status) -> ()) = { _ in }
    
    func requestPosts() {
        let apiClient = APIClient()
        currentState = .didStart("Started")
        apiClient.send(GetPosts()) { (response) in
            switch response {
            case .success(let posts):
                self.posts = posts
                self.currentState = .didEndWithSuccess("Ended")
                break;
            case .failure(let error):
                self.currentState = .didEndWithError(error.localizedDescription)
                break;
            }
        }
    }
}
