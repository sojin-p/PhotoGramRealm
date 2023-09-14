//
//  RealmCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by 박소진 on 2023/09/14.
//

import UIKit
import SnapKit
import RealmSwift //1.

class RealmCollectionViewController: BaseViewController {
    
    let realm = try! Realm() //2.
    
    //var collectionciew = UICollectioView() <- 이렇게 쓰면 컴파일 오류가 안 뜸 but 런타임 오류(스토리보드인지 코드베이스인지 모르니까)
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    //3.
    var list: Results<ToDoTable>! //let이면 오류 nil을 가져올 수 없어서
    
    //5. 타입 바꿔주기
    var cellRRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, ToDoTable>! //String: 들어가는 데이터의 타입
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //4. 가져오기
        list = realm.objects(ToDoTable.self)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //itemIdentifier = list[indexPath.item] 이라고 생각하기
        cellRRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.image = itemIdentifier.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 할 일"
            cell.contentConfiguration = content
            
        })
        
    }
    
    static func layout() -> UICollectionViewLayout {
        let configraion = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configraion)
        return layout
    }
}

extension RealmCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let data = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRRegistration, for: indexPath, item: data)
        
        return cell
    }
}
