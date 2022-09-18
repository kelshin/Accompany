//
//  BabySonogramController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-14.
//

import Foundation
import Photos
import PhotosUI
import UIKit
import SnapKit
import Gallery

class BabySonogramController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  // MARK: Section Definitions
  enum Section: Hashable {
    case randomPhoto
    case uploadPhoto
  }
  
  let appName = "Accompany"
  
  let babyTitleLabel = TitleLabel(title: "Photo Album", size: .medium)
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

  // MARK: Data
  
  lazy var randomImages: [Image] = uploadedImages[randomPick: 5]
    
  var uploadedImages: [Image] = {
    var images = [Image]()
     
//    for i in 1..<21 {
//      images.append(Image(id: i, uiImage: UIImage(named: "logo-app")!, category: .uploadPhoto))
//     }
     
    return images
  }()

  var sections = [Section]()
  
  var selectedIndexPath: IndexPath?
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Image>!
  var snapshot: NSDiffableDataSourceSnapshot<Section, Image> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Image>()
    snapshot.appendSections([.randomPhoto])
    snapshot.appendItems(randomImages, toSection: .randomPhoto)
    print(randomImages)
    
    snapshot.appendSections([.uploadPhoto])
    snapshot.appendItems(uploadedImages, toSection: .uploadPhoto)
    
    sections = snapshot.sectionIdentifiers
    dataSource.apply(snapshot)
    
    return snapshot
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(babyTitleLabel)
    
    setupLabelLayout()

    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
      make.top.equalTo(babyTitleLabel.snp.bottom)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }

    collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    configCollectionView()
    collectionView.setCollectionViewLayout(setupCollectionLayout(), animated: false)
    
    configureDataSource()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Photo Album ", style: .plain, target: nil, action: nil)
  }
   
  func openCamera() {

    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .camera
      imagePicker.allowsEditing = true

      self.present(imagePicker, animated: true, completion: nil)
    }

  }

  func openPhotoGallery() {

    if UIImagePickerController.isSourceTypeAvailable((.photoLibrary)) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .photoLibrary
      imagePicker.allowsEditing = true

      self.present(imagePicker, animated: true, completion: nil)
    }

  }
  
  func gotoDetail() {
    
    let photoDetailVC = PhotoDetailedViewController()

    navigationController?.pushViewController(photoDetailVC, animated: true)
    
  }
  
  private func configureDataSource() {

    //MARK: Data Source Initializaion

    dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
      cell.photoView.image = item.uiImage
      
      return cell
    })

    dataSource.apply(snapshot)
    
  }

  private func configCollectionView() {

    collectionView.delegate = self
    
    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    
  }

  private func setupLabelLayout() {
    babyTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
  }

  func setupCollectionLayout() -> UICollectionViewLayout {

    let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
    let spacing: CGFloat = 4.0
    let section = self.sections[sectionIndex]

    switch section {
      case .randomPhoto:
       // Section 1 - 'Full' - A full width item
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
       section.orthogonalScrollingBehavior = .groupPagingCentered

       return section

     case .uploadPhoto:
       // Section 2
       // 'Triplet' - three 1/3 width items stacked horizontally
       let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
       tripleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitems: [tripleItem, tripleItem, tripleItem])
       tripleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       // 'Double' - two 1/2 width items stacked horizontally
       let doubleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2)))
       doubleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
       let doubleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), subitems: [doubleItem, doubleItem])
       doubleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/3)), subitems: [tripleGroup, doubleGroup])

       let section = NSCollectionLayoutSection(group: nestedGroup)
       section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
       section.orthogonalScrollingBehavior = .groupPagingCentered

       return section
      
      }
    }
    return layout

  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    // update snapshot
    let uiImage = info[.editedImage] as! UIImage
    // TODO: Upload Image to Database
    if selectedIndexPath!.row  < uploadedImages.count {
      uploadedImages[selectedIndexPath!.row].uiImage = uiImage
  
    } else {
      uploadedImages.append(Image(id: selectedIndexPath!.row, uiImage: uiImage))
    }
    randomImages = uploadedImages[randomPick: 10]
    
    // update dataSource
    dataSource.apply(snapshot, animatingDifferences: true)
    
    self.dismiss(animated: true, completion: nil)

  }

}

extension BabySonogramController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if indexPath.section == 0 {
      gotoDetail()
    } else {
      let alert = UIAlertController(title: "\(appName) APP Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
        self.openCamera()
      }))
      alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
        self.openPhotoGallery()
      }))
      alert.addAction(UIAlertAction(title: "Go to Detail", style: .default, handler: { (_) in
        self.gotoDetail()
      }))

      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

      self.present(alert, animated: true, completion: nil)

    }

    selectedIndexPath = indexPath

  }

}

extension Array {
    subscript (randomPick n: Int) -> [Element] {
        var indices = [Int](0..<count)
        var randoms = [Int]()
        for _ in 0..<n {
            randoms.append(indices.remove(at: Int(arc4random_uniform(UInt32(indices.count)))))
        }
        return randoms.map { self[$0] }
    }
}
