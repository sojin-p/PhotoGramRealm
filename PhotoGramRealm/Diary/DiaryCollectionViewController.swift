//
//  DiaryCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/14.
//

import UIKit

class DiaryCollectionViewController: BaseViewController {
    
    let list = ["sdgnldfmlkaqsf", "123424646234", "asfadghfsh", "ㄴㅇㅎㄴㄹㅎㄴㄹㅁㄴㄹ"]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.image = UIImage(systemName: "heart.fill")
            content.secondaryText = "second"
            cell.contentConfiguration = content
        })
        
    }
    
    static func layout() -> UICollectionViewLayout {
        let configration = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configration)
        return layout
    }
}

extension DiaryCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        
        return cell
    }
}
