//
//  ContentView.swift
//  CombineAPI
//
//  Created by Jeongwan Kim on 2022/07/24.
//

import SwiftUI

struct ContentView: View {
    
    // viewModel 선언 방법 1
//    @StateObject var viewModel = ViewModel()
    
    // <-- viewModel 선언 방법 2
    @StateObject var viewModel: ViewModel
    init() {
        // 이름에 _를 붙이는 이유:
        // _를 붙여야 StateObject로 가져올 수 있음
        self._viewModel = StateObject.init(wrappedValue: ViewModel())
    }
    // -->
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                viewModel.fetchTodos()
            }, label: {
                Text("Todos 호출")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                    )
            })
            
            Button(action: {
                viewModel.fetchPosts()
            }, label: {
                Text("Posts 호출")                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                    )
            })
            
            Button(action: {
                viewModel.fetchTodosAndPostsAtTheSameTime()
            }, label: {
                Text("Todos + Posts 동시 호출")                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                    )
            })
            
            Button(action: {
                viewModel.fetchTodosAndThenPosts()
            }, label: {
                Text("Todos 호출 하고 그 다음에 Posts 호출")                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                    )
            })
            
            Button(action: {
                viewModel.fetchTodosUnder200()
            }, label: {
                Text("Todos 호출 하고 Todos 카운트가 200보다 작을 때만 Posts 호출")                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                    )
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
