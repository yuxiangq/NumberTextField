NumberTextField
===============
![image](https://raw.githubusercontent.com/yuxiangq/NumberTextField/master/Screenshots/61F90395-1DDC-4BDA-9DDB-B4E0C7B01ADD.png)

一个只允许输入数字的TextField子类

可以通过Numeric属性来设置数字的长度和小数位数

支持iOS6及以上系统

#用法示例#

<pre><code>
-(void)viewDidLoad{
    [super viewDidLoad];
    NumberField *numberField=[[NumberField alloc] initWithFrame:CGRectMake(100, 100, 120, 44)];
    numberField.placeholder=@"只能输入数字";
    
    //设置精度
    numberField.numeric=CGNumeric(10, 4);
    [self.view addSubview:numberField];
}
</code></pre>

#常用属性#
##numeric##
Numeric结构体用来表示数字的精度

它的定义为:
<pre><code>
typedef struct Numeric{
   int length;
   int decimalDigits;
} Numeric;
</code></pre>

**length**表示数字的长度，**decimalDigits**表示小数点位数
例如:
<pre><code>
Numeric = CGNumeric(6, 2);//CGNumeric(NSInteger length, NSInteger decimalDigits) 生成Numeric的方法
</code></pre>
表示长度为6，最多两位小数点的数。比如123456或1234.56

## 方法
**-(NSString*)trimText;**

处理掉数字中的冗余。
比如00001，将处理为1;.0001将处理为0.0001。

