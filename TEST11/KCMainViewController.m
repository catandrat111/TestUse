//
//  KCMainViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "KCMainViewController.h"
#import "KCView.h"
#import "RecordingCircleOverlayView.h"
#import "ProgressGradientView.h"
#define CONSTROLPANEL_FONTSIZE 12
@interface KCMainViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    KCView *_contentView;
    NSArray *_fontSize;
    
    UIImagePickerController *_imagePickerController;//系统照片选择控制器
    UIImageView *_imageView;//图片显示控件
    CIContext *_context;//Core Image上下文
    CIImage *_image;//我们要编辑的图像
    CIImage *_outputImage;//处理后的图像
    CIFilter *_colorControlsFilter;//色彩滤镜
}


@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    NSString* temp = [NSString stringWithFormat:@"%@:",self.type];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.type.length > 0) {
        if ([self respondsToSelector:NSSelectorFromString(temp)])  {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:NSSelectorFromString(temp) withObject:(__bridge id)(context) ];
#pragma clang diagnostic pop
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawUpdateStr:(CGContextRef)context {
    [self initLayout];
    [self addPickerView];
}

-(void)initLayout{
    _fontSize=@[@15,@18,@20,@22,@25,@28,@30,@32,@35,@40];
    _contentView=[[KCView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
    _contentView.type = self.type;
    _contentView.backgroundColor=[UIColor whiteColor];
    _contentView.title=@"Hello world!";
    _contentView.fontSize=[_fontSize[0] intValue];
    [self.view addSubview:_contentView];
}

-(void)addPickerView{
    UIPickerView *picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 300, 320, 268)];
    picker.dataSource=self;
    picker.delegate=self;
    
    [self.view addSubview:picker];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _fontSize.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%@号字体",_fontSize[row] ];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _contentView.fontSize=[[_fontSize objectAtIndex:row] intValue];
    
    //刷新视图
    [_contentView setNeedsDisplay];
}


#pragma mark 利用位图上下文添加水印效果
//要得到位图或者PDF的上下文可以利用UIGraphicsBeginImageContext(CGSize size)和UIGraphicsBeginPDFPageWithInfo(CGRect bounds, NSDictionary *pageInfo)方法。位图图形上下文和PDF图形上下文UIKit是不会负责创建的，所以需要用户手动创建，并且在使用完后关闭它。在使用UIKit中系统创建的图形上下文的时候，我们只能在drawRect：方法中使用，由于这两类图形上下文是由我们手动创建的因此可以放到任何方法中调用。此外，这两个方法开启的图形上下文并没有返回值，如果我们要得到我们创建的图形上下文只要在创建上下文之后、关闭之前调用UIGraphicsGetCurrentContext()方法，此时取得的上下文即是我们自己创建的图形上下文。
- (void)drawBitImage:(CGContextRef)context {
    
    UIImage *image=[self drawImageAtImageContext];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    imageView.center=CGPointMake(160, 284);
    
    [self.view addSubview:imageView];
}

-(UIImage *)drawImageAtImageContext{
    //获得一个位图图形上下文
    CGSize size=CGSizeMake(300, 188);//画布大小
    UIGraphicsBeginImageContext(size);
    
    UIImage *image=[UIImage imageNamed:@"photo2.png"];
    [image drawInRect:CGRectMake(0, 0, 300, 188)];//注意绘图的位置是相对于画布顶点而言，不是屏幕
    
    
    //添加水印
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 200, 178);
    CGContextAddLineToPoint(context, 270, 178);
    
    [[UIColor redColor]setStroke];
    CGContextSetLineWidth(context, 2);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    NSString *str=@"Kenshin Cui";
    [str drawInRect:CGRectMake(200, 158, 100, 30) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:15],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    //返回绘制的新图形
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //最后一定不要忘记关闭对应的上下文
    UIGraphicsEndImageContext();
    
    //保存图片
    //    NSData *data= UIImagePNGRepresentation(newImage);
    //    [data writeToFile:@"/Users/kenshincui/Desktop/myPic.png" atomically:YES];
    
    return newImage;
}
//注意：上面这种方式绘制的图像除了可以显示在界面上还可以调用对应方法进行保存（代码注释中已经包含保存方法）；除此之外这种方法相比在drawRect：方法中绘制图形效率更高，它不用每次展示时都调用所有图形绘制方法。


//绘制到PDF则要启用pdf图形上下文，PDF图形上下文的创建使用方式跟位图图形上下文是类似的，需要注意的一点就是绘制内容到PDF时需要创建分页，每页内容的开始都要调用一次IGraphicsBeginPDFPage();方法。下面的示例演示了文本绘制和图片绘制（其他图形绘制也是类似的）：

#pragma mark 利用pdf图形上下文绘制内容到pdf文档
-(void)drawContentToPdfContext{
    
    //沙盒路径（也就是我们应用程序文件运行的路径）
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[[paths firstObject] stringByAppendingPathComponent:@"myPDF.pdf"];
    NSLog(@"%@",path);
    //启用pdf图形上下文
    /**
     path:保存路径
     bounds:pdf文档大小，如果设置为CGRectZero则使用默认值：612*792
     pageInfo:页面设置,为nil则不设置任何信息
     */
    UIGraphicsBeginPDFContextToFile(path,CGRectZero,[NSDictionary dictionaryWithObjectsAndKeys:@"Kenshin Cui",kCGPDFContextAuthor, nil]);
    
    //由于pdf文档是分页的，所以首先要创建一页画布供我们绘制
    UIGraphicsBeginPDFPage();
    
    NSString *title=@"Welcome to Apple Support";
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    NSTextAlignment align=NSTextAlignmentCenter;
    style.alignment=align;
    [title drawInRect:CGRectMake(26, 20, 300, 50) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:style}];
    NSString *content=@"Learn about Apple products, view online manuals, get the latest downloads, and more. Connect with other Apple users, or get service, support, and professional advice from Apple.";
    NSMutableParagraphStyle *style2=[[NSMutableParagraphStyle alloc]init];
    style2.alignment=NSTextAlignmentLeft;
    //    style2.firstLineHeadIndent=20;
    [content drawInRect:CGRectMake(26, 56, 300, 255) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:style2}];
    
    UIImage *image=[UIImage imageNamed:@"applecare_folks_tall.png"];
    [image drawInRect:CGRectMake(316, 20, 290, 305)];
    
    UIImage *image2=[UIImage imageNamed:@"applecare_page1.png"];
    [image2 drawInRect:CGRectMake(6, 320, 600, 281)];
    
    //创建新的一页继续绘制其他内容
    UIGraphicsBeginPDFPage();
    UIImage *image3=[UIImage imageNamed:@"applecare_page2.png"];
    [image3 drawInRect:CGRectMake(6, 20, 600, 629)];
    
    //结束pdf上下文
    UIGraphicsEndPDFContext();
}

//Core Graphics是基于C语言的一套框架，开发时无法像使用Obj-C一样调用；

//2.在Quartz 2D中凡是使用带有“Create”或者“Copy”关键字方法创建的对象，在使用后一定要使用对应的方法释放（由于这个框架基于C语言编写无法自动释放内存）；
//
//3.Quartz 2D是跨平台的，因此其中的方法中不能使用UIKit中的对象（UIKit只有iOS可用），例如用到的颜色只能用CGColorRef而不能用UIColor，但是UIKit中提供了对应的转换方法；
//
//4.在C语言中枚举一般以“k”开头，由于Quartz 2D基于C语言开发，所以它也不例外（参数中很多枚举都是k开头的）；
//
//5.由于Quartz 2D是Core Graphics的一部分，所以API多数以CG开头；
//
//6.在使用Quartz 2D绘图API中所有以“Ref”结尾对象，在声明时都不必声明为指针类型；
//
//7.在使用Quartz 2D绘图API时，凡是“UI”开头的相关绘图函数，都是UIKit对Core Graphics的封装（主要为了简化绘图操作）；

#pragma mark 查看所有内置滤镜
-(void)showAllFilters{
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filterNames) {
        CIFilter *filter=[CIFilter filterWithName:filterName];
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
    }
}

//使用Core Image框架创建滤镜效果一般分为以下几步：

//1.创建图像上下文CIContext
//
//2.创建滤镜CIFilter
//
//3.创建过滤原图片CIImage
//
//4.调用CIFilter的setValue： forKey：方法为滤镜指定源图片
//
//5.设置滤镜参数【可选】
//
//6.取得输出图片显示或保存
#pragma mark 初始化布局

-(void)drawCIFilter:(CGContextRef)context {
    //初始化图片选择器
    _imagePickerController=[[UIImagePickerController alloc]init];
    _imagePickerController.delegate =self;
    
    //创建图片显示控件
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 502)];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    //上方导航按钮
    self.navigationItem.title=@"Enhance";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Open" style:UIBarButtonItemStyleDone target:self action:@selector(openPhoto:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePhoto:)];
    
    
    //下方控制面板
    UIView *controlView=[[UIView alloc]initWithFrame:CGRectMake(0, 450, 320, 118)];
    //    controlView.alpha=0.2;
    //    controlView.backgroundColor=[UIColor colorWithRed:46.0/255.0 green:178.0/255.0 blue:235.0/255.0 alpha:1];
    [self.view addSubview:controlView];
    //饱和度(默认为1，大于饱和度增加小于1则降低)
    UILabel *lbSaturation=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 25)];
    lbSaturation.text=@"Saturation";
    lbSaturation.font=[UIFont systemFontOfSize:CONSTROLPANEL_FONTSIZE];
    [controlView addSubview:lbSaturation];
    UISlider *sldStaturation=[[UISlider alloc]initWithFrame:CGRectMake(80, 10, 230, 30)];//注意UISlider高度虽然无法调整，很多朋友会说高度设置位0即可，事实上在iOS7中设置为0后是无法拖动的
    [controlView addSubview:sldStaturation];
    sldStaturation.minimumValue=0;
    sldStaturation.maximumValue=2;
    sldStaturation.value=1;
    [sldStaturation addTarget:self action:@selector(changeStaturation:) forControlEvents:UIControlEventValueChanged];
    //亮度(默认为0)
    UILabel *lbBrightness=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 60, 25)];
    lbBrightness.text=@"Brightness";
    lbBrightness.font=[UIFont systemFontOfSize:CONSTROLPANEL_FONTSIZE];
    [controlView addSubview:lbBrightness];
    UISlider *sldBrightness=[[UISlider alloc]initWithFrame:CGRectMake(80, 40, 230, 30)];
    [controlView addSubview:sldBrightness];
    sldBrightness.minimumValue=-1;
    sldBrightness.maximumValue=1;
    sldBrightness.value=0;
    [sldBrightness addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    //对比度(默认为1)
    UILabel *lbContrast=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 60, 25)];
    lbContrast.text=@"Contrast";
    lbContrast.font=[UIFont systemFontOfSize:CONSTROLPANEL_FONTSIZE];
    [controlView addSubview:lbContrast];
    UISlider *sldContrast=[[UISlider alloc]initWithFrame:CGRectMake(80, 70, 230, 30)];
    [controlView addSubview:sldContrast];
    sldContrast.minimumValue=0;
    sldContrast.maximumValue=2;
    sldContrast.value=1;
    [sldContrast addTarget:self action:@selector(changeContrast:) forControlEvents:UIControlEventValueChanged];
    
    
    //初始化CIContext
    //创建基于CPU的图像上下文
    //    NSNumber *number=[NSNumber numberWithBool:YES];
    //    NSDictionary *option=[NSDictionary dictionaryWithObject:number forKey:kCIContextUseSoftwareRenderer];
    //    _context=[CIContext contextWithOptions:option];
    _context=[CIContext contextWithOptions:nil];//使用GPU渲染，推荐,但注意GPU的CIContext无法跨应用访问，例如直接在UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染，所以推荐现在完成方法中保存图像，然后在主程序中调用
    //    EAGLContext *eaglContext=[[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES1];
    //    _context=[CIContext contextWithEAGLContext:eaglContext];//OpenGL优化过的图像上下文
    
    //取得滤镜
    _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];
    
}
#pragma mark 打开图片选择器
-(void)openPhoto:(UIBarButtonItem *)btn{
    //打开图片选择器
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 保存图片
-(void)savePhoto:(UIBarButtonItem *)btn{
    //保存照片到相册
    UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sytem Info" message:@"Save Success!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark 图片选择器选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    //取得选择图片
    UIImage *selectedImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image=selectedImage;
    //初始化CIImage源图像
    _image=[CIImage imageWithCGImage:selectedImage.CGImage];
    [_colorControlsFilter setValue:_image forKey:@"inputImage"];//设置滤镜的输入图片
}

#pragma mark 将输出图片设置到UIImageView
-(void)setImage{
    CIImage *outputImage= [_colorControlsFilter outputImage];//取得输出图像
    CGImageRef temp=[_context createCGImage:outputImage fromRect:[outputImage extent]];
    _imageView.image=[UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中
    
    CGImageRelease(temp);//释放CGImage对象
}

#pragma mark 调整饱和度
-(void)changeStaturation:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputSaturation"];//设置滤镜参数
    [self setImage];
}

#pragma mark 调整亮度
-(void)changeBrightness:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputBrightness"];
    [self setImage];
}

#pragma mark 调整对比度
-(void)changeContrast:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputContrast"];
    [self setImage];
}

//keyPath = strokeStart  动画的fromValue = 0，toValue = 1表示从路径的0位置画到1 怎么画是按照清除开始的位置也就是清除0 一直清除到1 效果就是一条路径慢慢的消失

//2 keyPath = strokeStart  动画的fromValue = 1，toValue = 0
//
//表示从路径的1位置画到0 怎么画是按照清除开始的位置也就是1 这样开始的路径是空的（即都被清除掉了）一直清除到0 效果就是一条路径被反方向画出来
//
//
//
//3 keyPath = strokeEnd  动画的fromValue = 0，toValue = 1
//
//表示 这里我们分3个点说明动画的顺序  strokeEnd从结尾开始清除 首先整条路径先清除后2/3，接着清除1/3 效果就是正方向画出路径
//
//
//
//3 keyPath = strokeEnd  动画的fromValue = 1，toValue = 0
//
//效果就是反方向路径慢慢消失
//
//注释： 动画的0-1（fromValue = 0，toValue = 1） 或1-0 （fromValue = 1，toValue = 0） 表示执行的方向 和路径的范围。
- (void)drawBezierPathLine1:(CGContextRef)context {
    // 创建path

    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [path moveToPoint:CGPointMake(0 , 30)];
    [path addLineToPoint:CGPointMake(200, 30)];

    
    CAShapeLayer* layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
    layer.strokeColor = [UIColor redColor].CGColor;

    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    // 添加圆到path
    [path1 addArcWithCenter:CGPointMake(160, 160) radius:100.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    [path1 setLineWidth:5.0];

    CAShapeLayer* layer1 = [CAShapeLayer new];
    layer1.path = path1.CGPath;
    [self.view.layer addSublayer:layer1];
    layer1.strokeColor = [UIColor redColor].CGColor;
    layer1.fillColor = [UIColor blueColor].CGColor;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    
}

- (void)drawBezierPathLine2:(CGContextRef)context {
    // 创建path
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [path moveToPoint:CGPointMake(0 , 30)];
    [path addLineToPoint:CGPointMake(200, 30)];
    
    
    CAShapeLayer* layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    // 添加圆到path
    [path1 addArcWithCenter:CGPointMake(160, 160) radius:100.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    [path1 setLineWidth:5.0];
    
    CAShapeLayer* layer1 = [CAShapeLayer new];
    layer1.path = path1.CGPath;
    [self.view.layer addSublayer:layer1];
    layer1.strokeColor = [UIColor redColor].CGColor;
    layer1.fillColor = [UIColor blueColor].CGColor;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.autoreverses = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];


    
}

- (void)drawBezierPathLine3:(CGContextRef)context {
    // 创建path
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [path moveToPoint:CGPointMake(0 , 30)];
    [path addLineToPoint:CGPointMake(200, 30)];
    
    
    CAShapeLayer* layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    // 添加圆到path
    [path1 addArcWithCenter:CGPointMake(160, 160) radius:100.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    [path1 setLineWidth:5.0];
    
    CAShapeLayer* layer1 = [CAShapeLayer new];
    layer1.path = path1.CGPath;
    [self.view.layer addSublayer:layer1];
    layer1.strokeColor = [UIColor redColor].CGColor;
    layer1.fillColor = [UIColor blueColor].CGColor;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;

    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
  

    
}


- (void)drawBezierPathLine4:(CGContextRef)context {
    // 创建path
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
//    [path moveToPoint:CGPointMake(0 , 30)];
//    [path addLineToPoint:CGPointMake(200, 30)];
//    
//    
//    CAShapeLayer* layer = [CAShapeLayer new];
//    layer.path = path.CGPath;
//    [self.view.layer addSublayer:layer];
//    layer.strokeColor = [UIColor redColor].CGColor;
//    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    // 添加圆到path
    [path1 addArcWithCenter:CGPointMake(160, 160) radius:100.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    [path1 setLineWidth:5.0];
    
    CAShapeLayer* layer1 = [CAShapeLayer new];
    layer1.path = path1.CGPath;
    [self.view.layer addSublayer:layer1];
    layer1.strokeColor = [UIColor redColor].CGColor;
    layer1.fillColor = [UIColor blueColor].CGColor;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:0.3f];
    pathAnimation.autoreverses = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [layer1 addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    
}

- (void)drawBezierPathLine5:(CGContextRef)context {
    RecordingCircleOverlayView *recordingCircleOverlayView = [[RecordingCircleOverlayView alloc] initWithFrame:self.view.bounds strokeWidth:7.f insets:UIEdgeInsetsMake(10.f, 0.f, 10.f, 0.f)];
    recordingCircleOverlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    recordingCircleOverlayView.duration = 10.f;
    [self.view addSubview:recordingCircleOverlayView];
}

- (void)drawProgress:(CGContextRef)context {
    ProgressGradientView *progressView = [[ProgressGradientView alloc] initWithFrame:CGRectMake(0, 10, 320, 51)];
    progressView.progress = 1.0;
    [progressView performAnimation];
   
    [self.view addSubview:progressView];
}

@end
