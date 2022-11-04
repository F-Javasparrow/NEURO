# 依赖

* Arma 3
* Arma 3 Tools (available on Steam)
* new P-drive
* Run Arma 3 and Arma 3 Tools directly from steam once to install registry entries (and again after every update)
* Windows (Mac or Linux isnt supported yet)
* [Python 3.x](https://www.python.org/)
* [ACE3](https://github.com/acemod/ACE3/tree/master) local clone of the reository
* [CBA](https://github.com/CBATeam/CBA_A3/tree/master) local clone of the reository
* [NEURO](https://github.com/F-Javasparrow/Neurotrauma) local clone of the reository
* [HEMTT](https://github.com/BrettMayson/HEMTT)
* [ArmaScriptCompiler](https://github.com/dedmen/ArmaScriptCompiler)

# 流程

1. 安装[Python 3.x](https://www.python.org/)。如果您不确定，如果它已经安装，那么您可以在cmd中使用命令 `python` 或 `py` 检查它。如果已安装，则会显示python的版本。确保您运行的是 3.X 版本
2. 新建一个文件夹，应该是您的新 P-Drive
3. 打开 A3Tools 并注册 P-Drive 的路径 (在步骤2中创建的文件夹的路径)
4. 安装 P-Drive
5. 提取游戏数据 (A3Tools -> 项目驱动器管理 -> 提取游戏数据 ->运行) 这可能需要一段时间。请等到它完成。
6. 克隆 ACE3, CBA 和 NEURO 的存储库
7. 将整个 NEURO 存储库复制到您的 P-Drive
8. 从 ACE3 存储库运行 setup.py
9. 从 CBA 存储库运行 setup.py
10. 从 NEURO 存储库运行 setup.py
11. 安装 HEMTT (从 github 下载最新版本 然后双击 setup.exe)
12. 从github下载最新的ArmaScriptCompiler，并将.exe文件复制到P-Drive和HEMTT安装的bin文件夹中
13. 在 P:\x\neuro 中运行 Powershell
14. 使用该命令 `hemtt build --release`. 现在您的P-Drive中应该有一个名为releases的新文件夹。在那里你可以找到打包和签名的.pbo文件。
15. 检查一切是否正常。打开一个随机的 .pbo 文件并检查函数文件夹。如果每个 .sqf 文件也有 .sqfc 文件，那么一切都做对了。

* 有时某些命令需要以管理员身份运行 cmd 或 powershell。因此，如果某些内容不适用于普通用户，请尝试以管理员身份运行

# 反馈

* 这不是一个非常专业的教程. 因此, 您需要一些技术背景才能使其正常工作. 如果本教程中有任何我们可以优化的内容, 请联系我.
