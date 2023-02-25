//
//  TagsViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 24/02/2023.
//

import UIKit

class TagsViewController: UIViewController {

    @IBOutlet weak var tagsCollectionView: UICollectionView!
    var postNetworkProtocol : PostNetworkProtocol?
    var tagsArray : [String?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    postNetworkProtocol = PostNetworkService()
        setUpCollection()
        getAllTags()
    }
    
    func setUpCollection(){
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
    }
    func getAllTags(){
        Indicator.shared.setUpIndicator(view: view)

        postNetworkProtocol?.getAllTags(completionHandler: { tags in
            Indicator.shared.indicator.stopAnimating()
            self.tagsArray = tags
            print(self.tagsArray)
            self.tagsCollectionView.reloadData()
        })
    }

}
extension TagsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagsArray.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionViewCell", for: indexPath) as? TagsCollectionViewCell else{return TagsCollectionViewCell()}
        cell.tagsLabel.text = tagsArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/3)-1, height: (view.frame.width/3)-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else{return}
        vc.tag = tagsArray[indexPath.row]
        present(vc, animated: true)
    }
    
}
