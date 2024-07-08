// Copyright (C) 2021 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import BooksModel

@main
struct BooksApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
        }
    }
    
    init() {
        UIView.appearance().tintColor = .brown
        configureNavigationBarAppearance()
        configureTabBarAppearance()
    }
}

struct MainTabBar: View {
    @State var viewModel = BooksViewModel()

    var body: some View {
        TabView {
            SearchResultsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            BookmarksView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                }
        }
    }
}

// MARK: - Global Appearance Configuration
extension BooksApp {
    
    static let titleTextAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.didotBold(size: 21),
        .foregroundColor: UIColor.systemBrown,
    ]
    
    static let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.didotBold(size: 36),
        .foregroundColor: UIColor.systemBrown,
        .kern: 0.5,
    ]
    
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.titleTextAttributes = Self.titleTextAttributes
        appearance.largeTitleTextAttributes = Self.largeTitleTextAttributes
        
        let proxy = UINavigationBar.appearance()
        proxy.standardAppearance = appearance
        proxy.scrollEdgeAppearance = appearance
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        let proxy = UITabBar.appearance()
        proxy.standardAppearance = appearance
        proxy.scrollEdgeAppearance = appearance
    }
}


// MARK: Fonts
extension UIFont {
    static func palatinoBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Palatino-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func didotBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Didot-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

    static func zapfino(size: CGFloat) -> UIFont {
        return UIFont(name: "Zapfino", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}

#Preview {
    MainTabBar()
}
