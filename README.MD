#配置bash
#配置vim
将vim打造成一个轻量的IDE
##编译python
##编译vim
cp -rf vimrc ~/.vimrc
##编译nodejs,插件coc需要nodejs的功能
# 安装nodejs, 插件coc.vim会用到这个软件
wget https://nodejs.org/dist/v14.17.1/node-v14.17.1-linux-x64.tar.xz
tar -xvf node-v14.17.1-linux-x64.tar.xz
echo "installing nodejs"
sudo mv node-v14.17.1-linux-x64 /usr/local/nodejs 
#添加nodejs环境变量
```bash
bash_file="~/.bash_profile"
echo ${bash_file}
if [ ! -e "~/.bash_profile" ]; then
    touch ~/.bash_profile
fi 
cat>~/.bash_profile<<-"eof"
#config nodejs env path
VERSION=v14.17.1
DISTRO=linux-x64
export PATH=/usr/local/nodejs/bin:$PATH
source ~/.bashrc
eof
```
```bash
#安装ctags，主要用来索引
#安装依赖
sudo apt install \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \t clone https://github.com/universal-ctags/ctags.git
$ cd ctags
$ ./autogen.sh
$ ./configure --prefix=/where/you/want # defaults to /usr/local
$ make
$ make install # may require extra privileges depending on where to install
    libxml2-dev
```
## 安装vim-plug
# 安装vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# 如果安装失败的话，可能就需要修改plug.vim
vim ~/.vim/autoload/plug.vim
/github.com
let fmt = get(g:, 'plug_url_format', 'git@github.com:%s.git')
## 打开vim
vim
:PlugInstall #等待插件安装完成
####配置coc
:CocInstall coc-json coc-tsserver
:CocInstall coc-pyright coc-clangd coc-snippets
#添加功能：
###文件管理：插件NerdTree
###跳转功能
###任意跳转功能，主要是和前一个功能进行补充
###搜索功能
###代码补全
###代码错误修正
