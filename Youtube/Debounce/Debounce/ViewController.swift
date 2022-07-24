//
//  ViewController.swift
//  Debounce
//
//  Created by Jeongwan Kim on 2022/07/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var mySubscription = Set<AnyCancellable>()
    
    @IBOutlet weak var resultLable: UILabel?
    
    private lazy var searchController: UISearchController = {
       let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .black
        searchController.searchBar.searchTextField.accessibilityIdentifier = "mySearchBarTextField"
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.searchController = searchController
        searchController.isActive = true
        
        searchController.searchBar.searchTextField
            .myDebounceSearchPublisher
            .sink { [weak self] result in
                self?.resultLable?.text = result
            }
            .store(in: &mySubscription)
    }
}

extension UISearchTextField {
    var myDebounceSearchPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            // Notification center에서 UISearchTextField 가져옴
            .compactMap { $0.object as? UISearchTextField }
            .map { $0.text ?? "" }
            .debounce(for: .milliseconds(2000), scheduler: RunLoop.main)
            .filter({ $0.count > 0 })
            .print()
            .eraseToAnyPublisher()
    }
}

