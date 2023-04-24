//
//  MyProfileViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//
import UIKit
import SnapKit

enum InfoField: String, CaseIterable {
  
//  case username = "Username"
  case name = "Name"
  case babyName = "Baby's Name"
  case dueDate = "Due Date"
  case statusMessage = "Status"
  case intro = "Intro"
 
 
}

class MyProfileViewController: CustomTextViewController {
  
  let profileTableView: UITableView = {
    let profileTableView = UITableView()
    profileTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    profileTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    profileTableView.separatorStyle = .none
    profileTableView.translatesAutoresizingMaskIntoConstraints = false
    
    return profileTableView
  }()
  
  let userImageView = UIImageView(image: UIImage(systemName: "person.fill"))
  
  let datePickerCell = DatePickerTableViewCell()
  
  var userInfo = HomeViewController.currentUser.detailsInfo
  var selectedIndexPath: IndexPath?
  
  let datePickerIndexPath = IndexPath(row: 2, section: 0)

 
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    fetchUserInfo()
    loadImage()
    titleLabel.text = Services.myProfile.description
    
    addTapToImage()

    configTableView()
    setupLayout()
   
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "My Profile", style: .plain, target: nil, action: nil)
  }
  
  override func viewWillAppear(_ animated: Bool){
    profileTableView.reloadData()
  }
  
  // TODO: fetch user info from db
  private func fetchUserInfo() {
    userInfo = HomeViewController.currentUser.detailsInfo
  }
  
  func addTapToImage() {
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    userImageView.isUserInteractionEnabled = true
    userImageView.addGestureRecognizer(tapGestureRecognizer)
    
    userImageView.contentMode = .scaleAspectFit
//    userImageView.layer.borderWidth = 1.0
    userImageView.layer.masksToBounds = false
    userImageView.layer.borderColor = #colorLiteral(red: 1, green: 0.8831380575, blue: 0.9568627451, alpha: 1)
//    userImageView.layer.cornerRadius = 60
    userImageView.clipsToBounds = true
    
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
    let alert = UIAlertController(title: "Accompany Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
      self.openPhotoGallery()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
    
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
  
  private func configTableView() {
    profileTableView.delegate = self
    profileTableView.dataSource = self
  }

  func setupLayout() {
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
   
    view.addSubview(userImageView)
   
    userImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.centerX.equalTo(view)
      make.width.equalTo(120)
      make.height.equalTo(120)
    }
   
    view.addSubview(profileTableView)
   
    profileTableView.snp.makeConstraints { make in
      make.top.equalTo(userImageView.snp.bottom).offset(45)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

extension MyProfileViewController: UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
}

extension MyProfileViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath == datePickerIndexPath {
    
      datePickerCell.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
      return datePickerCell
    }
    
    else {
      let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
      let userData = HomeViewController.currentUser.detailsInfo
      switch indexPath.row {
      // Username to be implemented soon
//      case 0:
//        cell.update(with: userData!.username, for: InfoField.username)
      case 0:
        cell.update(with: userData?.name ?? "", for: InfoField.name)
      case 1:
        cell.update(with: userData?.babyName ?? "", for: InfoField.babyName)
      case 2:
        cell.update(with: DateFormatter().string(from: userData?.dueDate ?? Date.now) , for: InfoField.dueDate)
      case 3:
        cell.update(with: userData?.statusMessage ?? "", for: InfoField.statusMessage)
      default:
        cell.update(with: userData?.intro ?? "", for: InfoField.intro)
      }
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath == datePickerIndexPath {
      return
    }
    
    else {
      let profileDetailVC = ProfileDetailViewController()
      profileDetailVC.delegate = self
      
      switch indexPath.row {
// Username to be implemented soon
//      case 0:
//        profileDetailVC.fieldValue = userInfo?.username
      case 0:
        profileDetailVC.fieldValue = userInfo?.name
      case 1:
        profileDetailVC.fieldValue = userInfo?.babyName
      case 3:
        profileDetailVC.fieldValue = userInfo?.statusMessage
      case 4:
        profileDetailVC.fieldValue = userInfo?.intro
      default:
        profileDetailVC.fieldValue = ""
      }
      
      profileDetailVC.field = InfoField.allCases[indexPath.row]
      profileDetailVC.updateUI(InfoField.allCases[indexPath.row])
      
      navigationController?.pushViewController(profileDetailVC, animated: true)
      
      selectedIndexPath = indexPath
      tableView.deselectRow(at: indexPath, animated: false)
    }
    
  }
  
  @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
    // TODO: update database
    
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatter.timeStyle = .none
    dateFormatter.dateStyle = .long

//    let selectedDate: String = dateFormatter.string(from: datePicker.date)
    
    HomeViewController.currentUser.detailsInfo?.dueDate = datePicker.date
    HomeViewController().saveUserData()
  }
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let image = info[.editedImage] as? UIImage
    self.userImageView.image = image
    saveImage(image: image!)
    self.dismiss(animated: true, completion: nil)
  }
  
  func saveImage( image : UIImage) {
    guard let profImage = image.jpegData(compressionQuality: 0.5) else { return }
    let encoded = try! PropertyListEncoder().encode(profImage)
    UserDefaults.standard.set(encoded, forKey: "profileImage")
  }

  func loadImage() {
    guard let profImage = UserDefaults.standard.data(forKey: "profileImage") else { return }
    let decoded = try! PropertyListDecoder().decode(Data.self, from: profImage)
    self.userImageView.image = UIImage(data: decoded)
  }
}

extension MyProfileViewController: ProfileDetailViewControllerDelegate {
  
  func edit(_ value: String, for field: InfoField) {
    switch field {
      case .name:
        HomeViewController.currentUser.detailsInfo?.name = value
        HomeViewController().updateWelcome()
      case .babyName:
        HomeViewController.currentUser.detailsInfo?.babyName = value.isEmpty ? "Not decided yet" : value
      case .statusMessage:
        HomeViewController.currentUser.detailsInfo?.statusMessage = value
      case .intro:
      HomeViewController.currentUser.detailsInfo?.intro = value
      default:
        return
    }
    HomeViewController().saveUserData()
    fetchUserInfo()
    profileTableView.reloadRows(at: [selectedIndexPath!], with: .automatic)
  }
}
