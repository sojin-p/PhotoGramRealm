//
//  DiaryCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/14.
//

import UIKit
import RealmSwift

class DiaryCollectionViewController: BaseViewController {
    
    let realm = try! Realm()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, DiaryTable>!
    
    var list: Results<DiaryTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(DiaryTable.self)
        print(realm.configuration.fileURL)
        
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.diaryTitle
            content.image = UIImage(systemName: "heart.fill")
            content.secondaryText = "second"
            cell.contentConfiguration = content
        })
        
    }
    
    override func configure() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        let data = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        
        return cell
    }
}
