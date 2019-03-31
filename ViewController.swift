//
//  ViewController.swift
//  队列和下载
//
//  Created by 方瑾 on 2019/3/6.
//  Copyright © 2019 方瑾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personImageView: UIImageView!
    //线程   有关画面的处理都在主线程上处理  thread  スレﾄ
    //GCD（Grand Centeral Dispatch）
    // 任务：
    //同步任务：把一系列的任务放在同一个管理上，一个一个被执行(sync)
    //异步任务：可以不做任何等待，跟其他同时被执行。但是这要取决是在哪一个队列(async)
    //队列   管理排队的任务，每次只能执行一个
    //串行队列
    //并行队列
    //        DispatchQueue.main.async {     //自己开设一个线程进行处理，主线程
    //            <#code#>
    //        }
    //        DispatchQueue.global().async {//无画面处理,新的线程
    //            <#code#>
    //        }
    let strUrl = "https://www.telegraph.co.uk/content/dam/news/2017/11/22/TELEMMGLPICT000147365976_trans_NvBQzQNjv4Bq3XmyF3YIL3K1caQxZsZv2Ssm-UOV8_Q90I8_c5Af0yY.jpeg?imwidth=1400"
    var session: URLSession?

    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.global().async(execute: {
//            self.task1()
//        })
//        DispatchQueue.global().async(execute: {
//            self.task2()
////            })
//        //方法一
//        if let imageUrl = URL(string: strUrl) {
//            DispatchQueue.global().async {
//                //开辟线路进行下载
//                do {
//                    //利用Data类型的构造函数进行下载
//                    let downLoadData = try Data(contentsOf: imageUrl)
//                    //将下载后的Data类型转化成Image的类型
//                     let webImage = UIImage(data: downLoadData)
//                    //回到主线程设置图片
//                    DispatchQueue.main.async {
//                        self.personImageView.image = webImage
//                    }
//
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
////        }
//        //方法二
//        session = URLSession(configuration: .default)
//        if let imageUrl = URL(string: strUrl) {
//            //创建网络会话进行下载（在dataTask方法中指定下载后的内容）
//            let task = session?.dataTask(with: imageUrl, completionHandler: {
//                (data,response,error) in
//                //判断本次下载是否成功
//                if error != nil {
//                    print(error!.localizedDescription)
//                    //！！！！一旦有错误一定在此结束处理！！！
//                    return
//                }
//                if let downLoadData = data {
//                    //将下载后得到的Data类型数据转换成Image类型
//                    let webImage = UIImage(data: downLoadData)
//                    //回到主线程设置图片
//                    DispatchQueue.main.async {
//                        self.personImageView.image = webImage
//                    }
//
//                }
//            })
//            task?.resume()   //执行这个任务
//        }
        //方法三
        session = URLSession(configuration: .default)  //网络会话
        if let imageUrl = URL(string: strUrl) {
            let task = session?.downloadTask(with: imageUrl, completionHandler: {
                (url,response,error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if let realUrl = url {
                    do {
                        let webImage = UIImage(data: try Data(contentsOf: realUrl))
                        DispatchQueue.main.async {
                            self.personImageView.image = webImage
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            })
            task?.resume()
        }

    }
//    func task1() {
//        for i in 1...10 {
//            print("task1:\(i)")
//        }
//    }
//    func task2() {
//        for i in 1...10 {
//            print("task2:\(i)")
//        }
//
//    }
    

}

