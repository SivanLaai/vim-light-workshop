## Xshell 护眼主题 Eyes Protection
#### Solarized Dark
##### 安装方式
## 配置vim 将vim打造成一个轻量的IDE
## linux安装
#### tmux安装
cd ~
HOME=$(pwd)
echo "now installing tmux"
sudo apt install libevent ncurses
sudo apt install tmux
# 配置tmux支持快捷键与vim无缝切换
if [ ! -e "$HOME/.tmux.conf" ]; then
    touch ~/.tmux.conf
else
    rm ~/.tmux.conf
fi
cat>>~/.tmux.conf<<-"eof"
# VIM模式
bind-key k select-pane -U # up
bind-key j select-pane -D # down
bind-key h select-pane -L # left
bind-key l select-pane -R # right
#开启鼠标
set -g mouse on
#设置vim模式
setw -g mode-keys vi
#设置tmux的颜色模式
set -g default-terminal "screen-256color"
eof


#### 编译python3.8.8
#Ubuntu

if [ ! -e "Python-3.8.8.tar.xz" ]; then
    echo "Downloading Python Install Package."
»···sudo apt-get install build-essential
    sudo apt install -y zlib1g zlib1g-dev libffi-dev openssl libssl-dev libbz2-dev liblzma-dev
    wget https://www.python.org/ftp/python/3.8.8/Python-3.8.8.tar.xz
fi
if [ ! -e "/usr/local/python3.8/lib/python3.8/config-3.8-x86_64-linux-gnu" ]; then
    echo "compiling and installing Python."
    tar -xvf Python-3.8.8.tar.xz
    cd Python-3.8.8
    ./configure --enable-shared --enable-optimizations --prefix=/usr/local/python3.8
    sudo make altinstall -j8
    # add bin path
    echo 'export PATH=/usr/local/python3.8/bin:$PATH'>>~/.bash_profile
    echo 'export PYTHONHOME=/usr/local/python3.8'>>~/.bash_profile
    cd ~
    echo '/usr/local/python3.8/lib'>>python.conf
    sudo mv python.conf /etc/ld.so.conf.d/python.conf
    sudo ldconfig
    sudo rm -rf Python-3.8.8
    /usr/local/python3.8/bin/python3.8 -m pip install --user --upgrade pip
    /usr/local/python3.8/bin/python3.8 -m pip install virtualenv
    cd ~
    /usr/local/python3.8/bin/python3.8 -m virtualenv venv
    echo 'source ~/venv/bin/activate'>>~/.bash_profile
fi

cd ~
#### 编译vim 支持Python和clipboard

if [ ! -d "$HOME/vim" ]; then
    echo "Downloading Python Install Package."
    cd ~
    git clone https://github.com/vim/vim
fi


cd ~
output=$(vim --version | grep "SivanLaai")
if [ ! -n "$output" ]
then
    cd ~/vim
    git pull && git fetch

    # 卸载旧版本vim
    sudo apt-get remove --purge vim-tiny vim vim-runtime vim-common vim-gui-common vim-nox
    # 安装依赖包
    sudo apt install ncurses-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev
    libxt-dev lua5.1 liblua5.1-dev libperl-dev
    export LD_FLAGS="-rdynamic"
    #./configure --enable-multibyte --enable-python3interp=dynamic --with-python3-config-dir=/usr/local/python3.8/lib/python3.8/config-3.8-x86_64-linux-gnu --enable-cscopei --enable-gui=auto --with-features=huge --with-x --enable-fontset --enable-largefile --disable-netbeans --with-compiledby=SivanLaai --enable-fail-if-missing
    ./configure --enable-multibyte --enable-python3interp=dynamic --with-python3-command=/usr/local/python3.8/bin/python3.8 \
    --with-python3-config-dir=/usr/local/python3.8/lib/python3.8/config-3.8-x86_64-linux-gnu --enable-cscopei --enable-gui=auto --with-features=huge \
    --enable-fontset --enable-largefile --disable-netbeans --with-compiledby=SivanLaai --enable-fail-if-missing
    make
    sudo make install
    cd ~
else
    echo "vim 8.2 has been installed successfully."
fi

# 编译nodejs,插件coc需要nodejs的功能
# 安装nodejs, 插件coc.vim会用到这个软件
cd ~
if [ ! -e "node-v14.17.1-linux-x64.tar.xz" ]; then
    echo "Downloading node-v14.17.1 Install Package."
    wget https://nodejs.org/dist/v14.17.1/node-v14.17.1-linux-x64.tar.xz
fi
if [ ! -e "/usr/local/nodejs/bin/node" ]; then
    tar -xf node-v14.17.1-linux-x64.tar.xz
    echo "installing nodejs"
    sudo mv node-v14.17.1-linux-x64 /usr/local/nodejs
fi

#添加nodejs环境变量
bash_file="~/.bash_profile"
if [ ! -e "$HOME/.bash_profile" ]; then
    touch $HOME/.bash_profile
fi

output=$(cat ~/.bash_profile | grep "config nodejs env path")
if [ ! -n "$output" ]; then
    cat>>$HOME/.bash_profile<<-"eof"
    #config nodejs env path
    VERSION=v14.17.1
    DISTRO=linux-x64
    export PATH=/usr/local/nodejs/bin:$PATH
    eof
fi

#安装ctags，主要用来索引
#安装依赖
sudo apt install \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev
if [ ! -d "$HOME/ctags" ]; then
    echo "Downloading universal-ctags Install Package."
    output=$(git clone https://github.com/universal-ctags/ctags.git)
    echo $output
    source ~/venv/bin/activate
    pip install pygments
fi

if [ ! -e "/usr/local/bin/ctags" ]; then
    echo "compiling universal-ctags."
    cd ctags
    ./autogen.sh
    ./configure --prefix=/usr/local # defaults to /usr/local
    make -j8
    sudo make install
fi
cd ~

#安装gtags，主要用来索引，相比ctags支持查找引用
GtagsVersion="global-6.6.7"
if [ ! -e "$HOME/$GtagsVersion.tar.gz" ]; then
    echo "Downloading gtags Install Package."
    output=$(wget https://ftp.gnu.org/pub/gnu/global/$GtagsVersion.tar.gz)
    echo $output
fi

if [ ! -e "/usr/local/bin/gtags" ]; then
    echo "compiling gtags."
    rm -rf ~/$GtagsVersion
    tar -zxvf $GtagsVersion.tar.gz
    cd $GtagsVersion
    ./configure --bindir=/usr/local/bin # defaults to /usr/local
    make -j8
    sudo make install
fi
cd ~

## 安装vim-plug
# 安装vim-plug
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Downloading vim-plug Install Package."
    git clone https://github.com/junegunn/vim-plug.git
    # 如果安装失败的话，可能就需要修改plug.vim
    # find ~ -name 'plug.vim' | xargs perl -pi -e 's|https://git::@github.com/%s.git|git@github.com:%s.git|g'
    mkdir -p $HOME/.vim/autoload
fi
cd $HOME/vim-light-workshop
cp -rf vimrc $HOME/.vimrc
cp -rf gvim/colors $HOME/.vim/colors
cp -rf $HOME/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim

#### zsh安装
if ! [ -x "$(command -v zsh)" ]; then
    echo 'zsh is not installed.' >&2
    echo 'installing zsh now.' >&2
    sudo apt install zsh
else
    echo 'zsh is installed'
fi
#安装oh-my-zsh
if [ ! -d "$HOME/ohmyzsh" ]; then
    echo 'installing oh-my-zsh now.' >&2
    cd ~
    output=$(git clone https://github.com/ohmyzsh/ohmyzsh.git)
    echo $output
else
    echo 'oh-my-zsh is installed, now reinstall oh-my-zsh'
    rm -rf $HOME/.oh-my-zsh
    rm -rf $HOME/.zshrc
fi

cd ~
cd $HOME/ohmyzsh/tools
#install theme
./install.sh
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's#"robbyrussell"#"powerlevel10k/powerlevel10k"#g' ~/.zshrc
#激活环境bash变量
output=$(cat ~/.zshrc | grep "bash_profile")
if [ ! -n "$output" ]; then
    echo 'alias tmux="tmux -2"'>>~/.zshrc
    echo 'source ~/.bash_profile'>>~/.zshrc
fi

cd ~

cat<<"eof"
Final Step:
## 打开vim
vim
:PlugInstall #等待插件安装完成
eof
