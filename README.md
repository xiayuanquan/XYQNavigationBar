# XYQNavigationBar
# 自定义导航栏，随着tableView滚动显示和隐藏
custom navigation bar , can show and hide with  animation

### 一、介绍

    自定义导航栏是APP中很常用的一个功能，通过自定义可以灵活的实现动画隐藏和显示效果。
    虽然处理系统的导航栏也可以实现，但是这个是有弊端的，因为系统导航栏是全局的，在任何一个地方去修改导航栏内部的结构，
    其他地方都会改变，需要再次去特殊处理，否则很容易出现不可预知的bug。此时，自定义是最好的选择。
    
    
### 二、思想

     (1）在控制器将要显示时，隐藏系统的导航栏，显示自定义的导航栏
     
    （2）在控制器将要消失时，显示系统的导航栏，隐藏自定义的导航栏
    
    （3）重写scrollView的代理方法，监测ContentOffst.y偏移，动态控制自定义的导航栏的可见性


### 三、定义

    @interface XYQNavigationBar : UIView
    @property (copy , nonatomic)void(^clickLeftItemBlock)();  // click left button block
    @property (copy , nonatomic)void(^clickRightItemBlock)(); // click right button block
    @property (copy , nonatomic)NSString *title; // title
    @property (assign,nonatomic)UIColor  *titleColor; // title color
    @property (strong,nonatomic)UIColor  *navBackgroundColor;// navagationBar background color
    @property (strong,nonatomic)UIImage  *navBackgroundImage;// navigationBar background image

    +(instancetype)createCustomNavigationBar;  //create navigationBar

    -(void)showCustomNavigationBar:(BOOL)show; //set navigationBar hide, defalut is NO

    -(void)setupBgImageAlpha:(CGFloat)alpha animation:(NSTimeInterval)duration compeleteBlock:(void (^)())compeleteBlock;// navigationBar background image alpha

    -(void)setupBgColorAlpha:(CGFloat)alpha animation:(NSTimeInterval)duration compeleteBlock:(void (^)())compeleteBlock;// navigationBar background color alpha

    -(void)setLftItemImage:(NSString *)imgName leftItemtitle:(NSString *)leftItemtitle textColor:(UIColor *)color; // navigationBar left  button has title and image

    -(void)setRightItemImage:(NSString *)imgName rightItemtitle:(NSString *)rightItemtitle textColor:(UIColor *)color;// navigationBar right  button has title and image

    -(void)setLeftItemImage:(NSString *)imgName;  // navigationBar left  button only has image

    -(void)setRightItemImage:(NSString *)imgName; // navigationBar right button only has image

    @end

### 四、实现

    （1）创建
    - (void)viewDidLoad {
        [super viewDidLoad];
    
        //init
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.navigationBar = [XYQNavigationBar createCustomNavigationBar];

    
       //update（此处可以自由改变导航栏的属性值）
        self.navigationBar.title = @"自定义导航栏";
    
    
        //block
        __weak typeof(self) weakSelf = self;
        self.navigationBar.clickLeftItemBlock = ^(){
           [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        self.navigationBar.clickRightItemBlock = ^(){
           [weakSelf.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
        };
    
    
        // add
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.navigationBar];
     }
     
     （2）显示
     -(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
    
        //hide system navigationBar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    
        //show custom navigationBar
        [self.navigationBar showCustomNavigationBar:YES];
     }
     
    （3）隐藏
    -(void)viewWillDisappear:(BOOL)animated{
        [super viewWillDisappear:animated];
    
        //show system navigationBar
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    
        //hide custom navigationBar
        [self.navigationBar showCustomNavigationBar:NO];
    }
    
    （4）监测	
    #pragma mark - public methods
    // animation show or hide navigationbar
    -(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat colorOffset = offsetY / 64.0;
        colorOffset = colorOffset > 1 ? 1 : colorOffset;
    
        //method 1 : change backgrundViewImage alpha
        [self.navigationBar setupBgImageAlpha:colorOffset animation:0.4 compeleteBlock:nil];
    
        //method 2 : change backgrundViewColor alpha
        //[self.navigationBar setupBgColorAlpha:colorOffset animation:0.4 compeleteBlock:nil];
    }


### 五、效果


### 六、下载
    
