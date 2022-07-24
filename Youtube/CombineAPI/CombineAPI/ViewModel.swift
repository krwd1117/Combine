//
//  ViewModel.swift
//  CombineAPI
//
//  Created by Jeongwan Kim on 2022/07/24.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    var subscriptions = Set<AnyCancellable>()
    
    func fetchTodos() {
        APIService.shared.fetchTodos()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchTodos SUCCESS")
                }
            } receiveValue: { todos in
                print("DEBUG: \(todos.count)")
            }.store(in: &subscriptions)
    }
    
    func fetchPosts() {
        APIService.shared.fetchPosts()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchPosts SUCCESS")
                }
            } receiveValue: { posts in
                print("DEBUG: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
    /// Todos, Posts 동시 호출
    func fetchTodosAndPostsAtTheSameTime() {
        APIService.shared.fetchTodosAndPostsAtTheSameTime()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchTodosAndPostsAtTheSameTime SUCCESS")
                }
            } receiveValue: { (todos: [Todo], posts: [Post]) in
                print("DEBUG Todos: \(todos.count)")
                print("DEBUG Posts: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
    func fetchTodosAndThenPosts() {
        APIService.shared.fetchTodosAndThenPosts()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchTodosAndThenPosts SUCCESS")
                }
            } receiveValue: { posts in
                print("DEBUG Posts: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
    func fetchTodosUnder200() {
        APIService.shared.fetchTodosUnder200()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchTodosUnder200 SUCCESS")
                }
            } receiveValue: { posts in
                print("DEBUG Posts: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
}
