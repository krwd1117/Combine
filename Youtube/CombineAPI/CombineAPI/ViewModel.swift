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
    
    /// todos 호출 후 응답 결과에 따라 다음 api 호출 결정
    /// todos.count < 200 ? 포스트 호출 : 유저 호출
    func fetchTodosAndCallConditionally() {
        let shouldFetchPosts: AnyPublisher<Bool, Error> =
        APIService.shared.fetchTodos()
            .map { $0.count < 200 }
            .eraseToAnyPublisher()
        
        shouldFetchPosts.filter {$0 == true}
            .flatMap { _ in
                return APIService.shared.fetchPosts()
            }.sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchTodosAndCallConditionally SUCCESS")
                }
            } receiveValue: { posts in
                print("DEBUG Posts: \(posts.count)")
            }.store(in: &subscriptions)
        
        shouldFetchPosts.filter {$0 != true}
            .flatMap { _ in
                return APIService.shared.fetchUsers()
            }.sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .finished :
                    print("DEBUG: fetchUsers SUCCESS")
                }
            } receiveValue: { users in
                print("DEBUG Posts: \(users.count)")
            }.store(in: &subscriptions)
    }
}
