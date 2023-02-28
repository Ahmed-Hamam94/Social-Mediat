//
//  AnimationViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 28/02/2023.
//

import UIKit
import Lottie
class AnimationViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAnimation(file: "71697-social-media-acccdesign", viewForAnimatio: animationView)
        goToSign()
    }
    
    func setUpAnimation(file: String, viewForAnimatio: LottieAnimationView){
        let path = Bundle.main.path(forResource: file,
                                    ofType: "json") ?? ""
        viewForAnimatio.animation = .filepath(path)
        viewForAnimatio.loopMode = .loop
        viewForAnimatio.animationSpeed = 3
        viewForAnimatio.play()
        
        
    }
    func goToSign(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else{return}
                self.present(vc, animated: true)
        }
    }
   
    

}
