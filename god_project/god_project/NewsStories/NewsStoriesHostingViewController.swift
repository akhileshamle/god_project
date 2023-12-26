//
//  NewsStoriesHostingViewController.swift
//  god_project
//
//  Created by Akhilesh Amle on 26/12/23.
//

import SwiftUI
import UIKit

class NewsStoriesHostingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let hostingController = UIHostingController(rootView: NewsStoriesView())
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.frame
        hostingController.didMove(toParent: self)
    }
}
