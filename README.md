# MVCManager
MVC 优雅的分离 Controller 和 View

越来越多的人开发从 MVC 转向了 MVVM，原因是臃肿的 Controller 让项目难于维护
该项目的目的就是为了剥离 Controller 层和 View 层，让 Controller 只对 view 进行配置，view 对 UI 视图进行管理
为 Controller 添加一个默认属性 contrainer，container 为自定义 view，可以直接使用该自定义 view 内的属性及方法进行配置

使用方法：
1、复制 MVCManager 和 MVCProcotol 到自己项目

2、在合适的地方，如 Appdelegate 的 didFinishLaunchingWithOptions 中启动：
```
MVCManager.instance.launch([(ViewController.self, XXView.self)])
```

3、对要分离 Controller 和 View 的控制器在 MVCProcotol 的底部添加以下代码就可以了
```
extension ProfileController: MVCProtocol { typealias Container = ProfileView }
```

缺点：

1、如果 AController 遵守了 MVCProcotol，BController 继承 AController 就无法更改为 BView，只能继续使用 AView

2、考虑到直接交换 UIViewController 的 loadView 方法过于极端，项目中应尽可能避免或者尽可能少的交换方法，该项目没有对整个 UIViewController 的 loadView 方法进行替换。项目自动提取了所有遵守 MVCProcotol 协议的类，只对遵守 MVCProcotol 协议的类进行了替换。

3、因为第二个缺点，我们交换了所有遵守 MVCProcotol 协议的类，但是在 Appdelegate 的 didFinishLaunchingWithOptions 方法中交换过多的方法会导致启动变慢，所以提供了 launch 方法，在 launch 方法中只填入首页要加载的控制器就好，如果全部写入会导致启动速度变慢！！如
```
// 正确,只填写首页要加载的类，未填写的类遵守了协议会自动添加
MVCManager.instance.launch([(ViewController.self, XXView.self)])
```
```
// 错误
MVCManager.instance.launch(
[(AController.self, AView.self),
(BController.self, BView.self),
(CController.self, CView.self),
(DController.self, DView.self),
(EController.self, EView.self),
(FController.self, FView.self),
......
])
```
