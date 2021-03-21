//
//  SecondViewController.swift
//  LifeCycleVC
//
//  Created by Максим on 17.03.2021.
//

//До ARC существовала вещь, называемая ручным подсчетом ссылок Manual-Retain-Release Management.
//Тогда программисты должны были сами писать код увеличения / уменьшения «счетчик ссылок».

//Они делали это с помощью следующих команд:
    //alloc init, new, copy: создает новый объект с счетчиком ссылок == 1
    //retain: увеличивает счетчик ссылок на 1 и возвращает сам объект
    //release: уменьшает количество ссылок на 1 и возвращает ноль
    //autorelease: помечает этот экземпляр для автоматического освобождения

//autoreleasepool- это блок, который по завершении будет содержать release метод,
    //то есть освобождать все объекты из памяти, которые были созданы внутри него.

import UIKit

class SecondViewController: UIViewController {
    
    //MARK: - Properties
    
    var secondView: UIView?
    var imageData: Data!
    
    //MARK: - Method for autoreleasepool test
    func run() {
        
        var count: Int = 0
        
        guard let file = Bundle.main.path(forResource: "bigImage", ofType: "jpg") else {
            return
        }
        
        for _ in 0..<10000 {
            
            count += 1
            print(count)
            
            //Если его не использовать, то на устройстве можно будет что-то пожарить!
            //До того каак приложение вылетит, конечно.
            autoreleasepool {
                let url = URL(fileURLWithPath: file)
                imageData = try! Data(contentsOf: url)
                //Тут все сильные ссылки на объекты освобождаются
                //Объекты уходят из памяти
            }
            
            //Тоже вызовет утечку памяти, но не такую большую. Скорее всего из-за предка NSObject.
            guard let _ = UIImage(named: "bigImage") else { return }
            
            //Если использовать "чистые" объекты Swift, то всплеска памяти не будет.
            //Система ARC должна позаботится об этом.
        }
        
        //Поскольку эти фреймворки имеют закрытый исходный код в Apple, нет возможности посмотреть их исходный код, чтобы узнать, где они используются.
    }
    
    override func loadViewIfNeeded() {
        //Загружает View, если его не существует
        print("SecVC", #function)
    }
    
    override func loadView() {
        super.loadView()
        //Запускается один раз при страте и проверки на существование Контроллера.
        //Ручная инициализация. Кастомный UIView.
        print("SecVC", #function)
        
        secondView = SecondView()
        self.view = secondView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Запускается один раз после создания View.
        //Все элементы на экране.
        //Загрузка необходимых данных, сетевые запросы и растоновка элементов Subview для первого старта.
        //Не известны положения и размеры Views.
        print("SecVC", #function)
        
        title = "SecondVC"
        
        //        DispatchQueue.global(qos: .utility).async { [weak self] in
        //            guard let strongSelf = self else { return }
        //            strongSelf.run()
        //        }
                //После выполнения метода run() удаляется сильная ссылка на self,
                //цикла сильных ссылок не происходит.
        
        DispatchQueue.global(qos: .utility).async {
            self.run()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Вызывается несколько раз прямо перед появлением VC на экране.
        //Поскольку вы можете перемещаться назад и вперед между представлениями, это будет вызываться каждый раз, когда ваше представление будет отображаться на экране.
        //Полезно скрывать/показывать поля или любые операции, которые вы хотите выполнять каждый раз перед тем, как вид будет виден.
        print("SecVC", #function)
    }
    
    //---Layout-------------------------------------------------------------------
    //Для объектов, которые зависят от размера экрана используются 2 метода:
    override func viewWillLayoutSubviews() {
        print("SecVC", #function)
    }
    
    override func viewLayoutMarginsDidChange() {
        print("SecVC", #function)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        print("SecVC", #function)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        print("SecVC", #function)
    }
    
    override func viewDidLayoutSubviews() {
        //Лучшее место для ручного лейаута.
        //Он вызывается каждый раз, когда меняется размер view, поэтому можно опираться на размер bounds для правильных расчётов
        print("SecVC", #function)
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
        //Мы не применяем этот метод, если хотим обновить View в соответствии с Model, так как метод вызывается после вывода View на экран.
        print("SecVC", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Вызывается неогрониченное количество раз перед выходом из иерархии VC.
        //Бывает баг, при переходе между экранами жестом.
        //Используется, чтобы отменить сделанное во ViewDidAppear.
        //Например, остановить выполнение таймера, прервать анимацию, прекратить наблюдение GPS.
        print("SecVC", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Метод вызывается после того, как MVC полностью вышел с экрана. Применяется редко.
        print("SecVC", #function)
    }
    
    deinit {
        print("SecVC", #function)
    }
    
    override func didReceiveMemoryWarning() {
        print("SecVC", #function)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("SecVC", #function)
    }
    
}

