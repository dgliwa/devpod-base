FROM mcr.microsoft.com/devcontainers/base:1-bookworm

RUN apt update && export DEBIAN_FRONTEND=noninteractive && \
  apt install -y libc-dev libssl-dev libyaml-dev && \
  rm -rf /var/lib/apt/lists/*

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
  rm -rf /opt/nvim && \
  tar -C /opt -xzf nvim-linux64.tar.gz



# RUN wget https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz && \
# tar -xvzf nvim-linux64.tar.gz -C /root/ && \
# ln -sf /usr/share/nvim-linux64/nvim /usr/
# rm nvim-linux64.tar.gz

USER vscode
# RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
RUN git clone https://github.com/dgliwa/local_nvim.git ~/.config/nvim
WORKDIR /home/vscode

SHELL [ "/bin/zsh", "-lc" ]

COPY .zshrc /home/vscode/.zshrc

RUN source ~/.asdf/asdf.sh && \ 
  asdf plugin add nodejs && \
  asdf install nodejs latest && \
  asdf global nodejs latest

RUN /opt/nvim-linux64/bin/nvim --headless +q


# FROM alpine:latest
# RUN apk update && \
#   apk add --no-cache bash git neovim zsh curl gcc make libc-dev shadow openssl-dev yaml-dev && \
#   rm -rf /var/cache/apk
#
# RUN useradd -ms /bin/zsh devloper
#
# USER devloper
# RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
#
#
# RUN git clone https://github.com/dgliwa/local_nvim.git ~/.config/nvim
#
# SHELL [ "/bin/zsh", "-lc" ]
#
# COPY .zshrc /home/devloper/.zshrc
#
# RUN source ~/.asdf/asdf.sh && \ 
#   asdf plugin add nodejs && \
#   asdf install nodejs latest && \
#   asdf global nodejs latest
#
# RUN nvim --headless +q
#
ENTRYPOINT ["/bin/zsh"]
