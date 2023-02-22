//
//  ViewController.swift
//  MorseDecoder
//
//  Created by Anton Kolesnikov on 22.02.2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var decodedTextLabel: UITextField!
    
    //MARK: - Private Properties
    private let vm = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureRx()
    }
    
    func configureUI() {
        
    }
    
    private func configureRx() {
        self.vm.outSubj
            .subscribe(onNext: { [weak self] in self?.decodedTextLabel.text = $0 })
            .disposed(by: self.disposeBag)
    }
    
    //MARK: - IBActions
    @IBAction private func resetDecoderButton(_ sender: Any) {
        self.vm.inSubj.onNext(())
    }
    
}

