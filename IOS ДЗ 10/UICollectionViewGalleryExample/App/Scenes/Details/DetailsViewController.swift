//
//  DetailsViewController.swift
//  UICollectionViewGalleryExample
//
//  Created by Ярослав on 05.07.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
}

private extension DetailsViewController {
    func setupScene() {
        title = "Gallery Item"
    }
}
