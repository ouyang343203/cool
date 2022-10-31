//
//  MineController.swift
//  Cool
//
//  Created by ouyang on 2022/10/21.
//

import UIKit

class MineController: UIViewController {
    private var belowList: [GoodsModel]? //底部列表数据
    private var list: [shangpingModel]? //底部列表数据
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBelowListData()
      //  self.loadListData()
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

    // MARK:  mark - HTTP Method -- 网络请求
    private func loadBelowListData() -> Void{
        NetworkRequest(target: API.login(parameters: ["page":0]), modelType: GoodsModel.self) { model in
            self.belowList = (model as! [GoodsModel])
        } failureCallback: { code, message in
            JYToastUtils.showShort(withStatus: message)
        }
    }

//    private func loadListData() -> Void{
//        NetworkRequest(target: API.login(parameters: ["page":0]), modelType: shangpingModel.self,isHideFailAlert:true) { model in
//            self.list = (model as! [shangpingModel])
//        } failureCallback: { code, message in
//            JYToastUtils.showShort(withStatus: message)
//        }
//    }

    // 方法和方法之间空一行
    // MARK: mark - Delegate Method -- 代理方法


    // MARK:  mark - Private Method -- 私有方法


    // MARK:  mark - Public Method -- 公开方法

    // MARK: mark - Action Method -- 公开方法

    // MARK:  mark - Setter/Getter -- Getter尽量写出懒加载形式
    
}
