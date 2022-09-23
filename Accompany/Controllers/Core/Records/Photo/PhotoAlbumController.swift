//
//  PhotoAlbumController.swift
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

class PhotoAblumController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  
  // MARK: Section Definitions
  
//
//  enum Section: Hashable {
////    case slidePhoto
//    case uploadPhoto
//  }
////
//  enum UploadSectionByUser: CustomStringConvertible, CaseIterable {
//
//    case slideSection
//    case uploadSection
//
//    var description: String {
//      switch self {
//      case .slideSection:
//        return "SlideSection"
//      case .uploadSection:
//        return "GridSection"
//      }
//    }
//  }
  
//  var dataSource: UICollectionViewDiffableDataSource<Section, Image>!
  
  let appName = "Accompany"
  let photoTitle = TitleLabel(title: "Photo Album", size: .medium)
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  // MARK: Data
  
  var slideImages = [Image]()
//    var slideArr = [Image]()
//    for i in 1...10 {
//      slideArr.append(Image(id: i, uiImage: UIImage(named: "logo-app")!))
//    }
//
//    return slideArr
//  }()
  
  var uploadedImages = [Image]()
//    var uploadArr = [Image]()
//
//    for i in 11...110 {
//      uploadArr.append(Image(id: i, uiImage: UIImage(named: "logo-app")!))
//    }
//
//    return uploadArr
//  }()
  
//  var sections = [Section]()
//
//  var snapshot: NSDiffableDataSourceSnapshot<Section, Image> {
//
//    var snapshot = NSDiffableDataSourceSnapshot<Section, Image>()
//    snapshot.appendSections([.slidePhoto])
//    snapshot.appendItems(slideImages, toSection: .slidePhoto)
//
//    snapshot.appendSections([.uploadPhoto])
//    snapshot.appendItems(uploadedImages, toSection: .uploadPhoto)
//
//    sections = snapshot.sectionIdentifiers
//
//    dataSource.apply(snapshot)
//    return snapshot
//  }
  
//  var selectedIndexPath: IndexPath?
//  var selectedInsertPhotoSection = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
//    if let saveSlideImage = Image.loadPhotoCell() {
//      slideImages = saveSlideImage
//    } else {
//      slideImages = Image.loadSampleSlide()
//    }
//
//    if let uploadImage = Image.loadPhotoCell() {
//      uploadedImages = uploadImage
//    } else {
//      uploadedImages = Image.loadSampleUpload()
//    }
//
    setupLabelLayout()
    
    // collectionView
    collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
      make.top.equalTo(photoTitle.snp.bottom)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    collectionView.collectionViewLayout = createCollectionLayout()
    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    
    configureDataSource()
    collectionView.dataSource = self
//    configCollectionView()
    
//    retrieveData(key: .keyForImage)
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "Photo Album ", style: .plain, target: nil, action: nil)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
  }
 
  func configureDataSource() {
    
    // MARK: Data Source Initialization
//    dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
//      let section = self.sections[indexPath.section]
//      switch section {
//      case .slidePhoto:
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
//        cell.photoView.image = item.uiImage
//
//        return cell
        
//      case .uploadPhoto:
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
//        cell.photoView.image = item.uiImage
//        return cell
//
////      }
////    })
//
//    // MARK: Snapshot Definition
//    dataSource.apply(snapshot)
  }
  
//  func configCollectionView() {
//
//    collectionView.delegate = self
//  }
  
  func setupLabelLayout() {
    
    view.addSubview(photoTitle)
    photoTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
  }
  
  func createCollectionLayout() -> UICollectionViewCompositionalLayout {
    let spacing: CGFloat = 4.0
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
    section.orthogonalScrollingBehavior = .none

    return UICollectionViewCompositionalLayout(section: section)
    
    
  
  //        // MARK: UploadPhoto Section Layout
  //        // 'Triplet' - three 1/3 width items stacked horizontally
  //        let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
  //        tripleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
  //
  //        let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitems: [tripleItem, tripleItem, tripleItem])
  //        tripleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
  //
  //        // 'Double' - two 1/2 width items stacked horizontally
  //        let doubleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2)))
  //        doubleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
  //        let doubleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), subitems: [doubleItem, doubleItem])
  //        doubleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
  //
  //        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/3)), subitems: [tripleGroup, doubleGroup])
  //
  //        let section = NSCollectionLayoutSection(group: nestedGroup)
  //        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
  //        section.orthogonalScrollingBehavior = .none
  //
  //        return section
    
  }
  
//  func createLayout() -> UICollectionViewLayout {
//    let layout = UICollectionViewCompositionalLayout
//    { (sectionIndex, layoutEnvironment) ->
//      NSCollectionLayoutSection? in
////      let section = self.sections[sectionIndex]
//      let spacing: CGFloat = 4.0
//      switch section {
//      case .slidePhoto:
//        // MARK: SlidePhoto Section Layout
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//
//        return section
        
//      case .uploadPhoto:
//        // MARK: UploadPhoto Section Layout
//        // 'Triplet' - three 1/3 width items stacked horizontally
//        let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
//        tripleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//
//        let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitems: [tripleItem, tripleItem, tripleItem])
//        tripleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//
//        // 'Double' - two 1/2 width items stacked horizontally
//        let doubleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2)))
//        doubleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//        let doubleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), subitems: [doubleItem, doubleItem])
//        doubleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//
//        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/3)), subitems: [tripleGroup, doubleGroup])
//
//        let section = NSCollectionLayoutSection(group: nestedGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
//        section.orthogonalScrollingBehavior = .none
//
//        return section
//
//      }
//    }
//    return layout
//
//  }

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
  
  func accessPhoto() {
    let alert = UIAlertController(title: "\(appName) APP Would Like to Access your Photos.", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
      self.openPhotoGallery()
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc func didTapAdd() {
    let alert = UIAlertController(title: "\(appName) APP Would Like to Access your Photos.", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
      var config = PHPickerConfiguration(photoLibrary: .shared())
      config.selectionLimit = 3
      config.filter = .images
      let vc = PHPickerViewController(configuration: config)
      vc.delegate = self
      self.present(vc, animated: true)
      
    }))
    alert.addAction(UIAlertAction(title: "LATER", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
  }
  
//  @objc func didTapAdd() {
//
//    self.accessPhoto()
    
//    let alert = UIAlertController(title: "Choose One Section", message: "Upload the photo", preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: UploadSectionByUser.slideSection.description, style: .default, handler: { (_) in
//      self.selectedInsertPhotoSection = UploadSectionByUser.slideSection.description
//      self.accessPhoto()
//    }))
//    alert.addAction(UIAlertAction(title: UploadSectionByUser.uploadSection.description, style: .default, handler: { (_) in
//      self.selectedInsertPhotoSection = UploadSectionByUser.uploadSection.description
//      self.accessPhoto()
//    }))
//
//    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

//    self.present(alert, animated: true, completion: nil)
//    let alert = UIAlertController(title: "Choose One Section", message: "Upload the photo"i, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: UploadSectionByUser.slideSection.description, style: .default, handler: { (_) in
//      self.selectedInsertPhotoSection = UploadSectionByUser.slideSection.description
//      self.accessPhoto()
//    }))
//    alert.addAction(UIAlertAction(title: UploadSectionByUser.uploadSection.description, style: .default, handler: { (_) in
//      self.selectedInsertPhotoSection = UploadSectionByUser.uploadSection.description
//      self.accessPhoto()
//    }))
//
//    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//    self.present(alert, animated: true, completion: nil)
    
//  }
  
//  func gotoDetail() {
//
//    let photoDetailVC = PhotoDetailedViewController()
////    if selectedIndexPath!.section == 0 {
////      photoDetailVC.section = 0
////      print(selectedIndexPath!.row)
////      photoDetailVC.imageView.image = slideImages[selectedIndexPath!.row].uiImage
//    if selectedIndexPath!.section == 0 {
//      photoDetailVC.section = 0
////      photoDetailVC.selectedIndex = uploadedImages[selectedIndexPath!.row]
//      photoDetailVC.imageView.image = uploadedImages[selectedIndexPath!.row].uiImage
//    }
//    photoDetailVC.photoDetaildelegate = self
//    navigationController?.pushViewController(photoDetailVC, animated: true)
//
//  }
  
  func save(image: UIImage) {
    print("save!")
    
    let imageData = image.pngData()! as NSData
    UserDefaults.standard.set(imageData, forKey: .keyForImage)
  }
  
//  func retrieveData(key: String) {
//    if selectedIndexPath!.row != nil {
//
//      guard let data = UserDefaults.standard.value(forKey: key) as? NSData else { return }
//      let image = UIImage(data: data as Data)
//
//      slideImages[selectedIndexPath!.row].uiImage = image!
//      uploadedImages[selectedIndexPath!.row].uiImage = image!
//
//    }
//
//    print(slideImages[selectedIndexPath!.row].uiImage.imageAsset)
    
  
//
//    if (slideImages[selectedIndexPath!.row].uiImage.size.width != 0) && (uploadedImages[selectedIndexPath!.row].uiImage.size.width != 0) {
//      slideImages[selectedIndexPath!.row].uiImage = UIImage(named: "logo-app")!
//      uploadedImages[selectedIndexPath!.row].uiImage = UIImage(named: "logo-app")!
//    } else {
//      slideImages[selectedIndexPath!.row].uiImage = image!
//      uploadedImages[selectedIndexPath!.row].uiImage = image!
    
  }
  
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    // update snapshot
//    let uiImage = info[.editedImage] as! UIImage
//
//    if self.selectedInsertPhotoSection == UploadSectionByUser.slideSection.description {
//      slideImages.append(Image(id: slideImages.count + 1, uiImage: uiImage))
//      let indexPath = IndexPath(row:slideImages.count - 1, section: 0)
//      collectionView.insertItems(at: [indexPath])
//      save(image: uiImage)
//
//    } else if self.selectedInsertPhotoSection == UploadSectionByUser.uploadSection.description {
//      uploadedImages.append(Image(id: uploadedImages.count + 1, uiImage: uiImage))
//      let indexPath = IndexPath(row:uploadedImages.count - 1, section: 0)
//      collectionView.insertItems(at: [indexPath])
//      save(image: uiImage)
//
//    }
    
   

    
//    if (selectedIndexPath!.section == 0) && (selectedIndexPath!.row < slideImages.count) {
//      slideImages[selectedIndexPath!.row].uiImage = uiImage
//
//    } else if (selectedIndexPath!.section == 1) && (selectedIndexPath!.row < uploadedImages.count) {
//      uploadedImages[selectedIndexPath!.row].uiImage = uiImage
//      save(image: uiImage)
//    }
//
//    // update dataSource
//    dataSource.apply(snapshot, animatingDifferences: true)
//    self.dismiss(animated: true, completion: nil)
//
//  }
//
//}
//}


extension PhotoAblumController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return uploadedImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
    cell.photoView.image = uploadedImages[indexPath.row].uiImage
    return cell
  }
  
  
  
}

//extension PhotoAblumController: UICollectionViewDelegate {
//
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//      let alert = UIAlertController(title: "Go to Detail", message: "Have you already upload the photo first?", preferredStyle: .alert)
////      alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
////        self.openCamera()
////      }))
////      alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
////        self.openPhotoGallery()
////      }))i
////      alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
//
//    alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
//        if (self.slideImages[self.selectedIndexPath!.row].uiImage == UIImage(named: "logo-app")!) && (self.uploadedImages[self.selectedIndexPath!.row].uiImage == UIImage(named: "logo-app")!)  {
//          let alert = UIAlertController(title: "Make sure you upload the photo first", message: nil, preferredStyle: .alert)
//          alert.addAction(UIAlertAction(title: "OK", style: .default))
//          self.present(alert, animated: true, completion: nil)
//        } else {
//          self.gotoDetail()
//        }
//      }))
//
//
//      self.present(alert, animated: true, completion: nil)
//
//      selectedIndexPath = indexPath
//
//  }
//
//}

//extension PhotoAblumController: PhotoDetailDelegate {
//  func photoDelete(data: UIImage, section: Int, id: Int) {
//
//    if section == 0 {
//      print(id)
//      print(selectedIndexPath!.row)
//      selectedIndexPath!.row = id - 1
//      print(slideImages[selectedIndexPath!.row].uiImage)
//      slideImages[selectedIndexPath!.row].uiImage = data
//    } else if section == 1 {
//      uploadedImages[id - 1].uiImage = data
//    }
//  }
//
//}

extension PhotoAblumController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true, completion: nil)
    let group = DispatchGroup()
    
    results.forEach { result in
      group.enter()
      result.itemProvider.loadObject(ofClass: UIImage.self) { reading,error in
        defer {
          group.leave()
        }
        guard let image = reading as? UIImage, error == nil else {
          return
        }
        self.uploadedImages.append(Image(uiImage: image))
        
      }
    }
    group.notify(queue: .main) {
      print(self.uploadedImages.count)
      self.collectionView.reloadData()
    }
    
  }
}

extension String {
  static let keyForImage = "data"
}

