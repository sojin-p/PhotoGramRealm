//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        return view
    }()
    
    var tasks: Results<DiaryTable>!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realm Read
        print(realm.configuration.fileURL)
        
        tasks = realm.objects(DiaryTable.self).sorted(byKeyPath: "diaryDate", ascending: true)
         
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        tableView.reloadData()
        
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func backupButtonClicked() {
        
    }
    
    
    @objc func sortButtonClicked() {
     /*
      //1. 대소문자 구별 없음 - caseInsensitive
      $0.diaryTitle.contains("제목", options: .caseInsensitive)

      

      */
    }
    
    @objc func filterButtonClicked() {
 
        let result = realm.objects(DiaryTable.self).where {
            //3. 사진이 있는 데이터만 불러오기 (diaryPhoto의 nil 여부 판단)
            $0.diaryPhoto != nil
        }
        
        tasks = result
        tableView.reloadData()
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        
        cell.diaryImageView.image = loadImageFromDocument(fileName: "jack_\(data._id).jpg")
        
        cell.titleLabel.text = data.diaryTitle
        cell.contentLabel.text = data.diaryContents
        cell.dateLabel.text = "\(data.diaryDate)"
        
       
//        let value = URL(string: data.diaryPhoto ?? "")
//
//        //String -> Url -> Data -> UIImage
//        //1. 셀 서버통신 용량이 크다면 로드가 오래 걸릴 수 있음.
//        //2. 이미지를 미리 UIImage 형식으로 반환하고, 셀에서 UIImage를 바로 보여주자!
//        //  => 재사용 메커니즘을 효율적으로 사용하지 못할 수도 있고, UIImage 배열 구성 자체가 오래 걸릴 수 있음
//        DispatchQueue.global().async {
//            if let url = value, let data = try? Data(contentsOf: url ) {
//
//                DispatchQueue.main.async {
//                    cell.diaryImageView.image = UIImage(data: data)
//                }
//            }
//        }
        
         
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.data = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)

        //Realm Delete
//        let data = tasks[indexPath.row]
//
//        removeImageFromDocument(fileName: "jack_\(data._id).jpg")
//
//        try! realm.write {
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let like = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("좋아여 선택됨")
        }
        like.backgroundColor = .orange
        like.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")

        let sample = UIContextualAction(style: .normal, title: "테스트") { action, view, completionHandler in
            print("테스트 선택됨")
        }
        sample.backgroundColor = .blue
        sample.image = UIImage(systemName: "pencil")
         
        return UISwipeActionsConfiguration(actions: [like, sample])
    }
    
    
    
    
}













