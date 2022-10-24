//
//  MineController.swift
//  Cool
//
//  Created by ouyang on 2022/10/21.
//

import UIKit

class MineController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension MineController {
    
    private func loadBelowListData() -> Void{
        NetworkRequest(target: .login(parameters: ["age":"12"]), mapper:UserInfoModel.self) { responsedata in
            
        } failClosure: { responsedata in
            
        }
    }
    // MARK:  mark - HTTP Method -- 网络请求

    // 方法和方法之间空一行
    // MARK: mark - Delegate Method -- 代理方法


    // MARK:  mark - Private Method -- 私有方法


    // MARK:  mark - Public Method -- 公开方法

    // MARK: mark - Action Method -- 公开方法

    // MARK:  mark - Setter/Getter -- Getter尽量写出懒加载形式
    
}
