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
    @IBOutlet private weak var errorLabel: UILabel!
    
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
        self.vm.outDecodedText
            .subscribe(
                onNext: { [weak self] in
                    print("YES")
                    self?.decodedTextLabel.text = $0
                    self?.errorLabel.isHidden = true
//
                },
                onError: { [weak self] _ in
                    print("NO")
                    self?.decodedTextLabel.text = ""
                    self?.errorLabel.isHidden = false }
            )
            .disposed(by: self.disposeBag)
    }
    
    //MARK: - IBActions
    @IBAction private func dotButton(_ sender: Any) {
        self.vm.inDot.onNext(())
    }
    @IBAction private func dashButton(_ sender: Any) {
        self.vm.inDash.onNext(())
    }
    @IBAction private func spaceButton(_ sender: Any) {
        self.vm.inSpace.onNext(())
    }
    @IBAction private func resetDecoderButton(_ sender: Any) {
        self.vm.reset.onNext(())
    }
    
   
}

