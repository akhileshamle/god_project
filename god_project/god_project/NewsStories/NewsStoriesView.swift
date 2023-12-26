//
//  NewsStoriesView.swift
//  god_project
//
//  Created by Akhilesh Amle on 26/12/23.
//

import SwiftUI

struct NewsStoriesView: View {
    @State private var stories = [NewsStory]()
    
    var body: some View {
        List(stories) { story in
            VStack(alignment: .leading) {
                Text(story.title)
                Text(story.strap)
            }
        }
        .navigationTitle("News sories")
        .task {
            do {
                try await loadStories()
            } catch {
                print("failed to load stories...")
            }
        }
    }
    
    private func loadStories() async throws {
        stories = try await withThrowingTaskGroup(of: [NewsStory].self) { group -> [NewsStory] in
            
            for i in 1...5 {
                group.addTask {
                    let url = URL(string: "https://hws.dev/news-\(i).json")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    return try JSONDecoder().decode([NewsStory].self, from: data)
                }
            }
            
            let allStories = try await group.reduce(into: [NewsStory]()) { $0 += $1 }
            return allStories
        }
    }
}

#Preview {
    NewsStoriesView()
}
