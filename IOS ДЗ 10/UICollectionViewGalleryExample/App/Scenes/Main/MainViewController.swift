//
//  MainViewController.swift
//  UICollectionViewGalleryExample
//
//  Created by Ярослав on 05.07.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = {
            let fraction: CGFloat = 1 / 4
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return UICollectionViewCompositionalLayout(section: section)
        }()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var columnCount: Int = 4
    var spacing: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupDelegates()
        makeConstraints()
    }
}

extension MainViewController {
    func setupScene() {
        let settingsBar = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(settingsTapped))
        navigationItem.rightBarButtonItem = settingsBar
        view.addSubview(collectionView)
    }
    
    func updateCollectionViewLayout() {
        let fraction: CGFloat = 1 / CGFloat(columnCount)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GalleryItemCell.self, forCellWithReuseIdentifier: GalleryItemCell.cellId)
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryItemCell.cellId, for: indexPath) as! GalleryItemCell
        cell.configure()
        return cell
    }
    
    @objc func settingsTapped() {
        let settingsViewController = SettingsViewController(columnCount: columnCount, spacing: spacing, delegate: self)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GalleryItemCell
        let cellBackgroundColor = cell.contentView.backgroundColor
        let detailsViewController = DetailsViewController()
        detailsViewController.view.backgroundColor = cellBackgroundColor
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


