ARG ImageTag=ltsc2019
FROM mcr.microsoft.com/windows/servercore:$ImageTag

ARG RVersion=4.0.3
ENV R_VERSION=${RVersion}

# See https://docs.chocolatey.org/en-us/choco/setup
RUN PowerShell -Command \
    Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN choco install r --version=%R_VERSION% --yes && \
    choco install rtools --yes

RUN setx /M path "%PATH%;%PROGRAMFILES%\R\R-%R_VERSION%\bin;%RTOOLS40_HOME%\usr\bin;"
ENTRYPOINT [ "cmd.exe" ]
