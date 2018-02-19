# Visual Studio Code for lumen development in a container (Augusto Sotelo Labarca)

# Parent image
FROM php:7.2-fpm

#  Lumen framework requirements and common use
RUN apt-get update -y && apt-get install -y openssl zip unzip git

# Get composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Lumen framework php extensions requirements
RUN docker-php-ext-install pdo mbstring

# vscode: Install packages to allow apt to use repository over HTTPS
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common \
	gnupg \
	git

# vscode: Add vscode oficial GPG Key
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -

# vscode: Add apt repository
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

# vscode: Update the package cache and install the package requirements 
RUN apt-get update && apt-get -y install \
	code \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libx11-xcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
        libcanberra-gtk3-module \
	--no-install-recommends \
   && rm -rf /var/lib/apt/lists/*

# development: ...
ENV HOME /home/user

# development: ...
RUN useradd --create-home --home-dir $HOME user \
    && mkdir /var/www/html -p \
    && chown -R user:user $HOME /var/www/html

# vscode: package extension for PHP development
ENV VSCODEEXT /var/vscode-ext
RUN mkdir $VSCODEEXT \
    && chown -R user:user $VSCODEEXT \
	&& su user -c "code --extensions-dir $VSCODEEXT --install-extension felixfbecker.php-intellisense --install-extension felixfbecker.php-debug --install-extension PeterJausovec.vscode-docker --install-extension mikestead.dotenv"

COPY start.sh /usr/local/bin/start.sh

WORKDIR /var/www/html

CMD [ "start.sh" ]
