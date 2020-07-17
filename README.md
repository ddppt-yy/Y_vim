# Y_vim
Vim file(support verilog/system-verilog)
" history            :  v1.0    创建插件，实现编译，加入注释，文件头等功能 
"                       v1.1    加入函数Component_Build() 可以实现垂直分割窗口
"                               生成component信息
"                       v1.2    加入函数Tb_Build() 可以为vhdl模块生成testbench文档
"                       v1.3    1 生成进程的命令改为：ProBuild
"                               2 加入函数Tb_Vhdl_Build(type) 函数
"                                   代替函数Tb_Build() 
"                                   修改了testbench文档的生成方式
"                                   功能：可以生成vhdl模块的vhdl testbench或者 verilog testbench
"                               3 修改了Component_Build()函数
"                                   修改了component的生成方式
"                               4 代码风格做了一些修改
"                               5 修改了光标位置
"                       v1.4    修改了Tb_Vhdl_Build(type)函数 使生成的component按原信号顺序排列
"                       v1.5    加入菜单
"                       v1.6    优化程序
"                       v1.7    Component_Build可以用变量定义选择instant窗口的方式
"                               不定义 g:RightB_Commponent  则水平分割打开
"                               g:RightB_Commponent = 1 原文件右侧垂直打开
"                               g:RightB_Commponent = 0 原文件左侧垂直打开
"                       v1.8    修改了一些错误
"                       v1.9    1 修改了AddFileInformation()和AddContent()函数
"                               2 加入变量g:HDL_Author g:HDL_Company g:Verilog_Timescale
"                                 可以在vimrc中添加设置,例如:
"                                   let g:HDL_Company = "UESTC"
"                                   let g:HDL_Author = "zz"
"                                   let g:Verilog_Timescale = " 1ns / 1ns"
"                               3 加入generic部分 使可识别generic
"                               4 加入g:HDL_Clock_Period 时钟周期可设置，默认为64
"                                   let g:HDL_Clock_Period = 64
"                               5 暂时不支持一行多个port
"                               6 菜单中加入compile file 默认快捷键为<F7>
"                               7 菜单中加入vlib work 默认快捷键为<F6>
"                                   需要安装modelsim。windows下需设置环境变量PATH=$ModelSim\win32
"                       v2.0    现在可以支持同一行多个port了
"                       v2.1    支持inout端口
"                               支持verilog模块，可为verilog模块生成testbench和instant
"                       v3.0    从此版本开始维护。去除lib、sim功能，添加对sv的支持,
"                               并添加perl和shell的文件头.并增加了对rst信号的触发条件。
"                               更改菜单栏为alltime。
"                       v3.1    加入对C/C++的支持，编译，连接，执行
"                       v3.2    support python, add <A-t> to generate verilog testbench, and others
