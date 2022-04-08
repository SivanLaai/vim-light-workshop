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


#Ubuntu
#### python安装
echo "1 - Normal Enviroment for using lightly, 2 - Science Environment for Reasearch"
echo "Please Choose your Environment:"
read envChoose
pythonpath = ""
if (( $envChoose == 2)); then
    #### 2科学环境安装Anaconda3 python
    echo "choose Science Environment for Reasearch"
    anaconda3_file=$(ls Anaconda3*.sh)
    if [ ! -n "$anaconda3_file" ]; then
        echo "Downloading Anaconda3 Install Package."
        wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
    fi

    if [ ! -d "/usr/local/anaconda3/" ]; then
        echo "installing anaconda3."
        anaconda3_shell=$(ls Anaconda3*.sh)
        ./anaconda3_shell
        echo '. ~/anaconda3/etc/profile.d/conda.sh'>>~/.bash_profile
        ~/anaconda3/bin/conda create -n myenv python=3.8
        echo 'source ~/anaconda3/bin/activate myenv'>>~/.bash_profile
        source ~/anaconda3/bin/activate myenv
    fi
    pythonpath="/usr/local/anaconda3/envs/myenv"
else
    #### 1编译python3.8.12
    echo "choose Normal Enviroment for using lightly"
    if [ ! -e "Python-3.8.12.tar.xz" ]; then
        echo "Downloading Python Install Package."
    »···sudo apt-get install build-essential
        sudo apt install -y zlib1g zlib1g-dev libffi-dev openssl libssl-dev libbz2-dev liblzma-dev libsqlite3-dev
        wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tar.xz
    fi

    if [ ! -e "/usr/local/python3.8/lib/python3.8/config-3.8-x86_64-linux-gnu" ]; then
        echo "compiling and installing Python."
        tar -xvf Python-3.8.12.tar.xz
        cd Python-3.8.12
        ./configure --enable-shared --enable-optimizations --prefix=/usr/local/python3.8
        sudo make altinstall -j8
        # add bin path
        #echo 'export PATH=/usr/local/python3.8/bin:$PATH'>>~/.bash_profile
        #echo 'export PYTHONHOME=/usr/local/python3.8'>>~/.bash_profile
        cd ~
        echo '/usr/local/python3.8/lib'>>python.conf
        sudo mv python.conf /etc/ld.so.conf.d/python.conf
        sudo ldconfig
        sudo rm -rf Python-3.8.12
        /usr/local/python3.8/bin/python3.8 -m pip install --user --upgrade pip
        /usr/local/python3.8/bin/python3.8 -m pip install virtualenv
        cd ~
        /usr/local/python3.8/bin/python3.8 -m virtualenv venv
        echo 'source ~/venv/bin/activate'>>~/.bash_profile
        source ~/venv/bin/activate venv
    fi
    pythonpath="/usr/local/python3.8"
fi


echo "1 - Vim, 2 - Neovim"
echo "Please Choose your Vim version:"
read vimChoose
if (( $vimChoose == 1)); then
    echo "install Vim..."
    cd ~
    #### 编译vim 支持Python和clipboard

    if [ ! -d "$HOME/vim" ]; then
        echo "Downloading Python Install Package."
        cd ~
        git clone https://github.com/vim/vim
    fi


    cd ~
    output=$(vim --version | grep "SivanLaai")
    if [ ! -n "$output" ]; then
        cd ~/vim
        git pull && git fetch

        # 卸载旧版本vim
        sudo apt-get remove --purge vim-tiny vim vim-runtime vim-common vim-gui-common vim-nox
        # 安装依赖包
        sudo apt install ncurses-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev
        libxt-dev lua5.1 liblua5.1-dev libperl-dev
        export LD_FLAGS="-rdynamic"
        #./configure --enable-multibyte --enable-python3interp=dynamic --with-python3-config-dir=/usr/local/python3.8/lib/python3.8/config-3.8-x86_64-linux-gnu --enable-cscopei --enable-gui=auto --with-features=huge --with-x --enable-fontset --enable-largefile --disable-netbeans --with-compiledby=SivanLaai --enable-fail-if-missing
        ./configure --enable-multibyte --enable-python3interp=dynamic --with-python3-command=$pythonpath/bin/python3.8 \
        --with-python3-config-dir=$pythonpath/lib/python3.8/config-3.8-x86_64-linux-gnu --enable-cscopei --enable-gui=auto --with-features=huge \
        --enable-fontset --enable-largefile --disable-netbeans --with-compiledby=SivanLaai --enable-fail-if-missing
        make
        sudo make install
        cd ~
    else
        echo "vim has been installed successfully."
    fi
    # 安装vim配置文件
    cd $HOME/vim-light-workshop
    cp -rf vim/.vimrc $HOME/.vimrc
    cp -rf gvim/colors $HOME/.vim/colors
    cd ~
else
    echo "install Neovim..."
    sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    git clone https://github.com/neovim/neovim
    cd neovim
    make
    sudo make install
    pip install neovim
    cd $HOME/vim-light-workshop
    cp -rf neovim/init.vim $HOME/.config/nvim
    cd ~
fi


# 编译nodejs,插件coc需要nodejs的功能
# 安装nodejs, 插件coc.vim会用到这个软件
cd ~
if [ ! -e "node-v14.17.1-linux-x64.tar.xz" ]; then
    echo "Downloading node-v14.17.1 Install Package."
    wget https://nodejs.org/dist/v14.17.1/node-v14.17.1-linux-x64.tar.xz
fi

if [ ! -e "/usr/local/bin/node" ]; then
    tar -xf node-v14.17.1-linux-x64.tar.xz
    echo "installing nodejs"
    sudo cp -rf node-v14.17.1-linux-x64/bin/* /usr/local/bin
    sudo cp -rf node-v14.17.1-linux-x64/share/* /usr/local/share
    sudo cp -rf node-v14.17.1-linux-x64/lib/* /usr/local/lib
fi

#添加nodejs环境变量
bash_file="~/.bash_profile"
if [ ! -e "$HOME/.bash_profile" ]; then
    touch $HOME/.bash_profile
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
    cp -rf $HOME/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim
fi

mkdir -p $HOME/.cache/vimfiles/undodir
mkdir -p $HOME/.cache/vimfiles/swapdir
mkdir -p $HOME/.cache/vimfiles/backdir
cd $HOME/vim-light-workshop

#### zsh安装
if [ ! -x "$(command -v zsh)" ]; then
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

#### 配置vim-format依赖
#C++
sudo apt install clang-format
#java
sudo apt-get install astyle
#Python
pip install --upgrade autopep8
#html\css\js
npm install -g js-beautify

#### leaderf中文显示二进制
git config --global core.quotepath false

cat<<"eof"
Final Step:
## 打开vim
vim or nvim
:PlugInstall #等待插件安装完成
eof
