//
//  ViewController.swift
//  LifeCycleVC
//
//  Created by Максим on 17.03.2021.
//

import UIKit

protocol MainViewControllerProtocol: class {
    func navigationButtonAction()
    func modalButtonPressed()
}

class MainViewController: UIViewController {
    
    //MARK: - Properties
    //Загружаются до начала жизненного цикли VC
    
    var firstView: FirstView?
    
    override func loadViewIfNeeded() {
        //Загружает View, если его не существует
        print("MainVC", #function)
    }
       
    override func loadView() {
        super.loadView()
        //Запускается один раз при страте и проверки на существование Контроллера.
        //Ручная инициализация. Кастомный UIView.
        print("MainVC", #function)
        
        firstView = FirstView()
        self.view = firstView
        firstView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Запускается один раз после создания View.
        //Все элементы на экране.
        //Инициализация переменых и объектов которые должны жить на протяжении всего цикла VC.
        //Загрузка необходимых данных, сетевые запросы и растоновка элементов Subview для первого старта.
        //Не известны положения, границы и размеры Views.
        print("MainVC", #function)
        
        title = "MainView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Вызывается несколько раз прямо перед появлением VC на экране.
        //Вызывается перед тем как VC будет добавлена в текущую иерархию контроллеров.
        //Тонкая настройка Subviews без анимации, например стили Views.
        //Поскольку вы можете перемещаться назад и вперед между представлениями, это будет вызываться каждый раз, когда ваше представление будет отображаться на экране.
        //Полезно скрывать/показывать поля или любые операции, которые вы хотите выполнять каждый раз перед тем, как вид будет виден.
        print("MainVC", #function)
    }
    
    //---Layout-------------------------------------------------------------------
    //Геометрические границы доступны.
    
    //Способы, которые сообщают системе, что Layout изменился:
    //  1. Изменения рамеров у View
    //  2. Добавление View
    //  3. Прокручивание ScrollView.
    //  4. Если пользователь изменяет ориентацию.
    //  5. Если мы меняем константу у View.
    
    //  6. На прямую через метод layoutIfNeeded.
    
    // Эти сопособы говорят системе, что Layouts должны быть пересчитаны
    // и вызовут LayoutSubviews
    
    //Для объектов, которые зависят от размера экрана используются 2 метода:
    override func viewWillLayoutSubviews() {
        print("MainVC", #function)
        //Срабатывает перед тем как размеры View поменяются под размер экрана до начала раствновки.
        //Этот метод вызывается для того, чтобы уведомить VC о том, что его View собирается разместить свои Subviews.
        //Этот метод вызывается каждый раз при изменении view.frame, повороте устройства.
        //Bounds у View окончательно вычеслен.
        
        
        
        //в UIVIew.animate {} когда мы перемещали centerX, то layoutSubviews вызывался автоматически.
        //Но когда в этом блоке увеличивали констрейнт, layoutSubviews сам по себе не вызывался и поэтому мы писали layoutIfNeeded, чтобы косвенно вызвать layoutSubviews (который в свою очередь высчитывает фреймы на основе констрейнтов)
    }
    
    override func viewLayoutMarginsDidChange() {
        print("MainVC", #function)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        print("MainVC", #function)
    }
    
    override func updateViewConstraints() {
        print("MainVC", #function)
        //Изменение констант значений констрайнтов
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        //Срабатывает после того как размеры View поменяются под размер экрана.
        //Для сохранения последнего состояния объекта. Например положение ScrollView или выделение ячейки.
        //Лучшее место для ручного лейаута.
        //Он вызывается каждый раз, когда меняется размер view, поэтому можно опираться на размер bounds для правильных расчётов.
        print("MainVC", #function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("MainVC", #function)
    }
    //---Layout-------------------------------------------------------------------
    
    
    //***Пользователь увидел экран***
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Вызывается несколько раз после появления представления.
        //Отличное место для запуска анимации или загрузки внешних данных из API.
        //Подходит для анимации, запуска таймера, наблюдения GPS, gyro-position.
        //Также можно применять для подгрузки тяжелых объектов, например, данных из сети.
        //Мы используем именно этот метод для подгрузки данных, потому что он позволяет не блокировать экран от пользователя во время выполнения загрузки.
        //Можно вызвать becomeFirstRespoder().
        print("MainVC", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Вызывается неогрониченное количество раз перед выходом из иерархии VC.
        //Бывает баг, при переходе между экранами жестом.
        //Используется, чтобы отменить сделанное во ViewDidAppear.
        //Например, остановить выполнение таймера, прервать анимацию, прекратить наблюдение GPS.
        print("MainVC", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Метод вызывается после того, как MVC полностью вышел с экрана. Применяется редко.
        print("MainVC", #function)
    }
    
    deinit {
        print("MainVC", #function)
    }
    
    override func didReceiveMemoryWarning() {
        print("MainVC", #function)
    }
    
}

extension MainViewController: MainViewControllerProtocol {
    
    func modalButtonPressed() {
        let vc = ModalViewController()
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
    }
    
    func navigationButtonAction() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// StoryBoard

//override class func awakeFromNib() {
//    super.awakeFromNib()
//    print("MainVC", #function)
//    //Загружает View из Nib-файла
//}
//
//override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//}
//
//required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//}
