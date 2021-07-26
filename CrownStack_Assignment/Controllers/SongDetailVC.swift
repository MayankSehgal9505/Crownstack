//
//  SongDetailVC.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import UIKit

class SongDetailVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            backBtn.makeCircularView(withBorderColor: .clear)
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songDesc: UILabel!
    @IBOutlet weak var songDate: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    
    //MARK:- Properties
    private var viewModel: SongDetailVM!
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Class Methods
    
    class func instance(model: Song)-> SongDetailVC?{
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SongDetailVC.self)) as? SongDetailVC
        vc?.viewModel = SongDetailVM(model: model)
        return vc
    }
    
    //MARK:- Internal Methods

    private func configureUI(){
        viewModel.fetchImage(imgView: imgView)
        let visualData = viewModel.getVisualData()
        songTitle.text = visualData.0
        songDesc.text = visualData.1
        songDate.text = visualData.2
        songArtist.text = visualData.3
    }
    
    //MARK:- IBActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
