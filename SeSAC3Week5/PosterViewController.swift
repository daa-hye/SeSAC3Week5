//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 박다혜 on 2023/08/16.
//

import UIKit
import Alamofire
import Kingfisher

protocol CollectinoViewAttributeProtocol {
    func configureCollectionView()
    func configureCollectionViewLayout()
}

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        LottoManager.shared.callLotto { bonus, number in
//            print(bonus, number)
//        }

        configureCollectionView()
        configureCollectionViewLayout()

        for i in 0..<movies.count {
            callRecommendation(id: movies[i]) { data in
                self.list[i] = data
                self.posterCollectionView.reloadData()
            }
        }
        
    }

    var list: [Recommendation] = [
        Recommendation(totalPages: 0, totalResults: 0, page: 0, results: []),
        Recommendation(totalPages: 0, totalResults: 0, page: 0, results: []),
        Recommendation(totalPages: 0, totalResults: 0, page: 0, results: []),
        Recommendation(totalPages: 0, totalResults: 0, page: 0, results: [])
    ]
    
    var movies = [122906, 313369, 10138, 346698]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        showAlert(title: "테스트", message: "메시지", button: "버튼") {
//            self.posterCollectionView.backgroundColor = .darkGray
//        }
    }


    //122906
    //313369
    //10138
    //346698
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void) {

        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.tmdb)&language=ko-KR"

        AF.request(url).validate(statusCode: 200...500).responseDecodable(of: Recommendation.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }

    }

}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0...3:
            return list[section].results.count
        default:
            return 0
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }

        switch indexPath.section {
        case 0...3:
            let url = "https://www.themoviedb.org/t/p/w440_and_h660_face\(list[indexPath.section].results[indexPath.row].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        default:
            return UICollectionViewCell()
        }

        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {

            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderPosterCollectionReusableView", for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }

            view.titleLabel.text = "테스트 섹션"

            return view

        } else {
            return UICollectionReusableView()
        }
    }


}

extension PosterViewController: CollectinoViewAttributeProtocol {

    func configureCollectionView() {
        //Protocal as Type
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }

    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)

        posterCollectionView.collectionViewLayout = layout
    }
    
}

//protocol Test {
//    func test()
//}
//
//class A: Test {
//
//    func test() {
//
//    }
//
//}
//
//class B: Test {
//
//    func test() {
//
//    }
//
//}
//
//class C: A {
//
//}
//
//let example:Test = A()
//
//let value: A = C()
