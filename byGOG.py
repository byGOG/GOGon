import os
os.system("title byGOG")
print("by GOG - Çevrimiçi Yükleyici\n\nBu program, çeşitli yazılımların kolayca indirilip kurulmasına yardımcı olmak amacıyla, tamamen yapay zeka kullanılarak GOG tarafından geliştirilmiştir.")
import sys
import requests
import subprocess
import threading
import os
import tempfile
import time
import webbrowser
import glob
import winreg
from PySide6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QLabel, QCheckBox, QPushButton,
    QProgressBar, QMessageBox, QGridLayout, QHBoxLayout, QScrollArea, QMenuBar, QComboBox, QFrame, QTableWidget, QTableWidgetItem, QGroupBox, QToolTip, QGraphicsDropShadowEffect
)
from PySide6.QtGui import QPixmap, QIcon, QAction, QPalette, QColor, QFont, QCursor
from PySide6.QtCore import Qt, QMetaObject, Slot, Q_ARG, QTimer, QPoint

def resource_path(relative_path):
    """ Get absolute path to resource, works for dev and for PyInstaller """
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)

# Sadece yerel dosya yolları için resource_path kullanın
software_list = {
    "Dosya Paylaşımı": dict(sorted({
        "Internet Download Manager": ["Software/InternetDownloadManager-OnlineInstaller.cmd", resource_path("icons/idm.ico")],
        "Stremio": ["Software/Stremio-OnlineInstaller.cmd", resource_path("icons/Stremio.ico")],
        "qBittorrent EE": ["Software/qBittorrentEE-OnlineInstaller.cmd", resource_path("icons/qBittorrent.ico")],
    }.items())),
    "Dosya Yönetimi": dict(sorted({
        "7-Zip": ["Software/7zip-OnlineInstaller.cmd", resource_path("icons/7-Zip.ico")],
        "Everything": ["Software/Everything-OnlineInstaller.cmd", resource_path("icons/Everything.ico")],
        "TeraCopy": ["Software/TeraCopy-OnlineInstaller.cmd", resource_path("icons/TeraCopy.ico")],
        "WinRAR": ["Software/WinRAR-OnlineInstaller.cmd", resource_path("icons/winrar.ico")],
        "WizTree": ["Software/WizTree-OnlineInstaller.cmd", resource_path("icons/WizTree.ico")],
    }.items())),
    "Geliştirme": dict(sorted({
        "Notepad++": ["Software/NotepadPlusPlus-OnlineInstaller.cmd", resource_path("icons/notepad++.ico")],
        "Visual Studio Code": ["Software/VisualStudioCode-OnlineInstaller.cmd", resource_path("icons/VisualStudioCode.ico")],
        "Java": ["Software/Java-OnlineInstaller.cmd", resource_path("icons/Java.ico")],
        "WinScript": ["Software/WinScript-OnlineInstaller.cmd", resource_path("icons/WinScript.ico")],
    }.items())),
    "Güvenlik ve Gizlilik": dict(sorted({
        "Bitwarden": ["Software/Bitwarden-OnlineInstaller.cmd", resource_path("icons/Bitwarden.ico")],
        "GoodbyeDPI": ["Software/GoodbyeDPI-OnlineInstaller.cmd", resource_path("icons/terminal.png")],
        "ProtonVPN": ["Software/ProtonVPN-OnlineInstaller.cmd", resource_path("icons/ProtonVPN.ico")],
        "OpenVPN Connect": ["Software/OpenVPNConnect-OnlineInstaller.cmd", resource_path("icons/OpenVPNConnect.ico")],
    }.items())),
    "Medya Oynatıcılar": dict(sorted({
        "AIMP": ["Software/AIMP-OnlineInstaller.cmd", resource_path("icons/AIMP.ico")],
        "HandBrake": ["Software/HandBrake-OnlineInstaller.cmd", resource_path("icons/HandBrake.ico")],
        "K-Lite Codec Pack Mega": ["Software/K-LiteCodecPackMega-OnlineInstaller.cmd", resource_path("icons/mpc-hc64.ico")],
        "Spotify": ["Software/Spotify-OnlineInstaller.cmd", resource_path("icons/spotify.ico")],
        "Spotify SpotX": ["Software/SpotifySpotX-OnlineInstaller.cmd", resource_path("icons/SpotX.png")],
        "VLC Media Player": ["Software/VLC-OnlineInstaller.cmd", resource_path("icons/vlc.ico")],
    }.items())),
    "Ofis ve Üretkenlik": dict(sorted({
        "CopyQ": ["Software/CopyQ-OnlineInstaller.cmd", resource_path("icons/CopyQ.ico")],
        "Google Drive": ["Software/GoogleDrive-OnlineInstaller.cmd", resource_path("icons/GoogleDrive.ico")],
        "Office Tool Plus": ["Software/OfficeToolPlus-OnlineInstaller.cmd", resource_path("icons/OfficeToolPlus.ico")],
        "OpenHashTab": ["Software/OpenHashTab-OnlineInstaller.cmd", resource_path("icons/OpenHashTab.ico")],
        "ShareX": ["Software/ShareX-OnlineInstaller.cmd", resource_path("icons/ShareX.ico")],
        "Dropbox": ["Software/Dropbox-OnlineInstaller.cmd", resource_path("icons/Dropbox.ico")],
    }.items())),
    "OS ve Araçlar": dict(sorted({
        "BleachBit": ["Software/BleachBit-OnlineInstaller.cmd", resource_path("icons/BleachBit.ico")],
        "Bulk Crap Uninstaller": ["Software/BulkCrapUninstaller-OnlineInstaller.cmd", resource_path("icons/BCUninstaller.ico")],
        "ChatGPT": ["Software/ChatGPT-OnlineInstaller.cmd", resource_path("icons/ChatGPT.ico")],
        "HWiNFO": ["Software/HWiNFO-OnlineInstaller.cmd", resource_path("icons/HWiNFO.ico")],
        "MiniTool Partition Wizard": ["Software/MiniToolPartitionWizard-OnlineInstaller.cmd", resource_path("icons/MiniToolPartitionWizard.ico")],
        "PowerToys": ["Software/PowerToys-OnlineInstaller.cmd", resource_path("icons/PowerToys.ico")],
        "Rufus": ["Software/Rufus-OnlineInstaller.cmd", resource_path("icons/Rufus.ico")],
        "Snappy Driver Installer Origin": ["Software/SnappyDriverInstallerOrigin-OnlineInstaller.cmd", resource_path("icons/SDIO.ico")],
        "UniGetUI": ["Software/UniGetUI-OnlineInstaller.cmd", resource_path("icons/UniGetUI.ico")],
        "Sandboxie": ["Software/Sandboxie-OnlineInstaller.cmd", resource_path("icons/Sandboxie.ico")],
        "Sysinternals Suite": ["Software/SysinternalsSuite-OnlineInstaller.cmd", resource_path("icons/SysinternalsSuite.png")],
        "Driver Store Explorer": ["Software/DriverStoreExplorer-OnlineInstaller.cmd", resource_path("icons/DriverStoreExplorer.ico")],
        "Cmder": ["Software/Cmder-OnlineInstaller.cmd", resource_path("icons/Cmder.ico")],
        "Windows Media Creation Tool": ["Software/WindowsMediaCreationTool-OnlineInstaller.cmd", resource_path("icons/WindowsMediaCreationTool.ico")],
    }.items())),
    "Oyun Yazılımları": dict(sorted({
        "Steam": ["Software/Steam-OnlineInstaller.cmd", resource_path("icons/Steam.ico")],
    }.items())),
    "Sosyal ve İletişim": dict(sorted({
        "Discord": ["Software/Discord-OnlineInstaller.cmd", resource_path("icons/Discord.ico")],
        "Telegram": ["Software/Telegram-OnlineInstaller.cmd", resource_path("icons/Telegram.ico")],
    }.items())),
    "Uzaktan Çalışma": dict(sorted({
        "AnyDesk": ["Software/AnyDesk-OnlineInstaller.cmd", resource_path("icons/AnyDesk.ico")],
        "RustDesk": ["Software/RustDesk-OnlineInstaller.cmd", resource_path("icons/RustDesk.png")],
        "TeamViewer": ["Software/TeamViewer-OnlineInstaller.cmd", resource_path("icons/TeamViewer.ico")],
    }.items())),
    "Web Tarayıcıları": dict(sorted({
        "Brave Browser": ["Software/BraveBrowser-OnlineInstaller.cmd", resource_path("icons/Brave.ico")],
        "Google Chrome": ["Software/GoogleChrome-OnlineInstaller.cmd", resource_path("icons/GoogleChrome.ico")],
        "Mozilla Firefox": ["Software/MozillaFirefox-OnlineInstaller.cmd", resource_path("icons/Firefox.ico")],
        "Zen Browser": ["Software/ZenBrowser-OnlineInstaller.cmd", resource_path("icons/ZenBrowser.ico")],
    }.items()))
}

software_info = {
    "Internet Download Manager": ("https://www.internetdownloadmanager.com/", "Dosya indirme yöneticisi."),
    "Stremio": ("https://www.stremio.com/", "Medya içeriklerini izleme ve organize etme."),
    "qBittorrent EE": ("https://github.com/c0re100/qBittorrent-Enhanced-Edition", "Torrent indirme yazılımı."),
    "7-Zip": ("https://www.7-zip.org/", "Dosya sıkıştırma ve arşivleme."),
    "Everything": ("https://www.voidtools.com/", "Hızlı dosya arama."),
    "TeraCopy": ("https://www.codesector.com/teracopy", "Dosya kopyalama ve taşıma."),
    "WinRAR": ("https://www.rarlab.com/", "Dosya sıkıştırma ve arşivleme."),
    "WizTree": ("https://wiztreefree.com/", "Disk alanı analiz aracı."),
    "Notepad++": ("https://notepad-plus-plus.org/", "Kod düzenleyici."),
    "Visual Studio Code": ("https://code.visualstudio.com/", "Kod düzenleyici ve geliştirme ortamı."),
    "Bitwarden": ("https://bitwarden.com/", "Parola yöneticisi."),
    "GoodbyeDPI": ("https://github.com/ValdikSS/GoodbyeDPI", "DPI baypas aracı."),
    "ProtonVPN": ("https://protonvpn.com/", "VPN hizmeti."),
    "OpenVPN Connect": ("https://openvpn.net/client-connect-vpn-for-windows/", "OpenVPN bağlantı istemcisi."),
    "AIMP": ("http://www.aimp.ru/", "Müzik oynatıcı."),
    "HandBrake": ("https://handbrake.fr/", "Video dönüştürücü."),
    "K-Lite Codec Pack Mega": ("https://codecguide.com/", "Medya codec paketi."),
    "Spotify": ("https://www.spotify.com/", "Müzik akış hizmeti."),
    "Spotify SpotX": ("https://github.com/SpotX-CLI/SpotX-Win", "Spotify için reklam engelleyici."),
    "VLC Media Player": ("https://www.videolan.org/vlc/", "Medya oynatıcı."),
    "CopyQ": ("https://hluk.github.io/CopyQ/", "Pano yöneticisi."),
    "Google Drive": ("https://www.google.com/drive/", "Bulut depolama."),
    "Office Tool Plus": ("https://otp.landian.vip/en-us/", "Office araçları."),
    "OpenHashTab": ("https://implbits.com/", "Dosya hash kontrolü."),
    "ShareX": ("https://getsharex.com/", "Ekran görüntüsü ve video kaydı."),
    "BleachBit": ("https://www.bleachbit.org/", "Disk temizleme aracı."),
    "Bulk Crap Uninstaller": ("https://www.bcuninstaller.com/", "Yazılım kaldırma aracı."),
    "ChatGPT": ("https://chat.openai.com/", "Yapay zeka sohbet botu."),
    "HWiNFO": ("https://www.hwinfo.com/", "Sistem bilgi aracı."),
    "MiniTool Partition Wizard": ("https://www.partitionwizard.com/", "Disk yönetim yazılımı."),
    "PowerToys": ("https://github.com/microsoft/PowerToys", "Windows yardımcı araç seti."),
    "Rufus": ("https://rufus.ie/", "Önyüklenebilir USB sürücüler oluşturma."),
    "Snappy Driver Installer Origin": ("https://www.snappy-driver-installer.org/", "Sürücü güncellemeleri."),
    "UniGetUI": ("https://www.marticliment.com/unigetui/", "Yazılım indirme yöneticisi."),
    "Steam": ("https://store.steampowered.com/", "Dijital oyun ve yazılım platformu."),
    "Discord": ("https://discord.com/", "Sesli, görüntülü ve yazılı iletişim platformu."),
    "Telegram": ("https://telegram.org/", "Mesajlaşma uygulaması."),
    "AnyDesk": ("https://anydesk.com/", "Uzaktan erişim yazılımı."),
    "RustDesk": ("https://rustdesk.com/", "Açık kaynaklı uzaktan erişim yazılımı."),
    "TeamViewer": ("https://www.teamviewer.com/", "Uzaktan erişim ve masaüstü paylaşımı."),
    "Brave Browser": ("https://brave.com/", "Gizlilik odaklı web tarayıcısı."),
    "Google Chrome": ("https://www.google.com/chrome/", "Popüler web tarayıcısı."),
    "Mozilla Firefox": ("https://www.mozilla.org/firefox/", "Açık kaynaklı web tarayıcısı."),
    "Zen Browser": ("https://zen-browser.app/", "Gizlilik odaklı web tarayıcısı."),
    "Sandboxie": ("https://sandboxie-plus.com/", "Uygulamaları izole bir ortamda çalıştırarak sisteminizi korur."),
    "Java": ("https://www.java.com/", "Platform bağımsız uygulamalar geliştirmek için kullanılan bir programlama dilidir."),
    "WinScript": ("https://winscript.cc/", "Debloat, gizlilik, performans ve uygulama yükleme komut dosyaları içerir."),
    "Dropbox": ("https://www.dropbox.com/", "Bulut depolama ve dosya paylaşım hizmeti."),
    "Cmder": ("https://cmder.app/", "Komut satırı emülatörü."),
    "Driver Store Explorer": ("https://github.com/lostindark/DriverStoreExplorer", "Sürücü yönetim aracı."),
    "Sysinternals Suite": ("https://learn.microsoft.com/tr-tr/sysinternals/", "Windows sistem araçları paketi."),
    "Windows Media Creation Tool": ("https://www.microsoft.com/tr-tr/software-download/windows11", "Windows kurulum medyası oluşturma aracı."),
}

def check_software_installed(software_name, paths):
    green_check_path = resource_path("icons/green_check.png")
    black_check_path = resource_path("icons/black_check.png")
    
    if not os.path.exists(green_check_path):
        print(f"Error: {green_check_path} not found")
    if not os.path.exists(black_check_path):
        print(f"Error: {black_check_path} not found")
    
    green_check_icon = QPixmap(green_check_path)
    black_check_icon = QPixmap(black_check_path)
    
    if green_check_icon.isNull():
        print(f"Error loading icon: {green_check_path}")
    if black_check_icon.isNull():
        print(f"Error loading icon: {black_check_path}")
    
    if software_name == "Java":
        for path in paths:
            try:
                with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, path) as key:
                    return green_check_icon, True
            except FileNotFoundError:
                continue
        return black_check_icon, False
    else:
        for path in paths:
            if os.path.exists(path):
                return green_check_icon, True
        return black_check_icon, False

class SoftwareInstallerApp(QWidget):
    def __init__(self):
        super().__init__()
        java_registry_keys = [
            r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{77724AE4-039E-4CA4-87B4-2F64180441F0}",
            r"SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{77724AE4-039E-4CA4-87B4-2F32180441F0}"
        ]
        self.software_paths = {
            "7-Zip": [os.path.expandvars(r"%PROGRAMFILES%/7-Zip/7zG.exe")],
            "Everything": [os.path.expandvars(r"%PROGRAMFILES%/Everything/Everything.exe")],
            "TeraCopy": [os.path.expandvars(r"%PROGRAMFILES%/TeraCopy/TeraCopy.exe")],
            "WinRAR": [os.path.expandvars(r"%PROGRAMFILES%/WinRAR/WinRAR.exe")],
            "WizTree": [os.path.expandvars(r"%PROGRAMFILES%/WizTree/WizTree.exe")],
            "Internet Download Manager": [os.path.expandvars(r"%PROGRAMFILES(X86)%/Internet Download Manager/IDMan.exe")],
            "Stremio": [os.path.expandvars(r"%LOCALAPPDATA%/Programs/LNV/Stremio-4/Stremio.exe")],
            "qBittorrent EE": [os.path.expandvars(r"%PROGRAMFILES%/qBittorrent/qbittorrent.exe")],
            "Notepad++": [os.path.expandvars(r"%PROGRAMFILES%/Notepad++/notepad++.exe")],
            "Visual Studio Code": [os.path.expandvars(r"%LOCALAPPDATA%/Programs/Microsoft VS Code/Code.exe")],
            "Bitwarden": [os.path.expandvars(r"%LOCALAPPDATA%/Programs/Bitwarden/Bitwarden.exe")],
            "GoodbyeDPI": [os.path.expandvars(r"%SystemDrive%/tools/GOODBY~1/2_any_country_dnsredir.cmd")],
            "ProtonVPN": [os.path.expandvars(r"%PROGRAMFILES%/Proton/VPN/ProtonVPN.Launcher.exe")],
            "OpenVPN Connect": [os.path.expandvars(r"%PROGRAMFILES%/OpenVPN Connect/OpenVPNConnect.exe")],
            "AIMP": [os.path.expandvars(r"%PROGRAMFILES%/AIMP/AIMP.exe")],
            "HandBrake": [os.path.expandvars(r"%PROGRAMFILES%/HandBrake/HandBrake.exe")],
            "K-Lite Codec Pack Mega": [os.path.expandvars(r"%PROGRAMFILES(X86)%/K-Lite Codec Pack/MPC-HC64/mpc-hc64.exe")],
            "Spotify": [os.path.expandvars(r"%APPDATA%/Spotify/Spotify.exe")],
            "Spotify SpotX": [os.path.expandvars(r"%APPDATA%/Spotify/Spotify.exe")],
            "VLC Media Player": [os.path.expandvars(r"%PROGRAMFILES%/VideoLAN/VLC/vlc.exe")],
            "CopyQ": [os.path.expandvars(r"%PROGRAMFILES%/CopyQ/copyq.exe")],
            "Google Drive": [os.path.expandvars(r"%PROGRAMFILES%/Google/Drive File Stream/launch.bat")],
            "Office Tool Plus": [os.path.expandvars(r"%SystemDrive%/tools/Office Tool/Office Tool Plus.exe")],
            "OpenHashTab": [os.path.expandvars(r"%PROGRAMFILES%/OpenHashTab/OpenHashTab.dll")],
            "ShareX": [os.path.expandvars(r"%PROGRAMFILES%/ShareX/ShareX.exe")],
            "BleachBit": [os.path.expandvars(r"%PROGRAMFILES(X86)%/BleachBit/BleachBit.exe")],
            "Bulk Crap Uninstaller": [os.path.expandvars(r"%PROGRAMFILES%/BCUninstaller/BCUninstaller.exe")],
            "ChatGPT": [os.path.expandvars(r"%PROGRAMFILES%/ChatGPT/ChatGPT.exe")],
            "HWiNFO": [os.path.expandvars(r"%PROGRAMFILES%/HWiNFO64/HWiNFO64.exe")],
            "MiniTool Partition Wizard": [os.path.expandvars(r"%PROGRAMFILES%/MINITO~1/partitionwizard.exe")],
            "PowerToys": [os.path.expandvars(r"%PROGRAMFILES%/PowerToys/PowerToys.exe")],
            "Rufus": [os.path.expandvars(r"%SystemDrive%/tools/Rufus/Rufus.exe")],
            "Snappy Driver Installer Origin": [os.path.expandvars(r"%SystemDrive%/tools/SnappyDriverInstallerOrigin/SDIO_auto.bat")],
            "UniGetUI": [os.path.expandvars(r"%PROGRAMFILES%/UniGetUI/UniGetUI.exe")],
            "Steam": [os.path.expandvars(r"%PROGRAMFILES(X86)%/Steam/Steam.exe")],
            "Discord": [os.path.expandvars(r"%LOCALAPPDATA%/Discord/Update.exe")],
            "Telegram": [os.path.expandvars(r"%APPDATA%/TELEGR~1/Telegram.exe")],
            "AnyDesk": [os.path.expandvars(r"%PROGRAMFILES(X86)%/AnyDesk/AnyDesk.exe")],
            "RustDesk": [os.path.expandvars(r"%PROGRAMFILES%/RustDesk/RustDesk.exe")],
            "TeamViewer": [os.path.expandvars(r"%PROGRAMFILES%/TeamViewer/TeamViewer.exe")],
            "Brave Browser": [os.path.expandvars(r"%LOCALAPPDATA%/BraveSoftware/Brave-Browser/Application/brave.exe")],
            "Google Chrome": [os.path.expandvars(r"%PROGRAMFILES%/Google/Chrome/Application/chrome.exe")],
            "Mozilla Firefox": [os.path.expandvars(r"%PROGRAMFILES%/Mozilla Firefox/firefox.exe")],
            "Zen Browser": [os.path.expandvars(r"%PROGRAMFILES%/Zen Browser/zen.exe")],
            "Sandboxie": [os.path.expandvars(r"%PROGRAMFILES%/Sandboxie-Plus/SandMan.exe")],
            "Java": java_registry_keys,
            "WinScript": [os.path.expandvars(r"%PROGRAMFILES%/WinScript/WinScript.exe")],
            "Dropbox": [os.path.expandvars(r"%PROGRAMFILES(X86)%/Dropbox/Client/Dropbox.exe")],
            "Cmder": [os.path.expandvars(r"%SystemDrive%/tools/Cmder/Cmder.exe")],
            "Driver Store Explorer": [os.path.expandvars(r"%SystemDrive%/tools/DriverStoreExplorer/RAPR.exe")],
            "Sysinternals Suite": [os.path.expandvars(r"%SystemDrive%/Tools/SysinternalsSuite/Autoruns64.exe")],
            "Windows Media Creation Tool": [os.path.expandvars(r"%SystemDrive%/tools/WindowsMediaCreationTool/WindowsMediaCreationTool11.exe")],
        }
        self.total_software_count = sum(len(software_dict) for software_dict in software_list.values())
        self.software_info_labels = {}
        self.initUI()

    def initUI(self):
        self.setWindowTitle('by GOG - Çevrimiçi Yükleyici')
        self.setWindowIcon(QIcon(resource_path('icons/cmd.ico')))
        
        # Ekran çözünürlüğünü alın
        screen = QApplication.primaryScreen()
        screen_geometry = screen.geometry()
        screen_width = screen_geometry.width()
        screen_height = screen_geometry.height()
        
        # Pencere boyutlarını genişletin ve ekranın sağ tarafında konumlandırın
        self.setGeometry(screen_width * 1 // 12, screen_height // 7, screen_width * 10 // 12, screen_height * 3 // 4)
        self.resize(screen_width * 10 // 12, screen_height * 3 // 4)
        self.setMinimumSize(screen_width * 3 // 13, screen_height * 3 // 4)

        main_layout = QVBoxLayout()

        # Menü çubuğu ekleyin
        menu_bar = QMenuBar(self)
        menu_bar.setStyleSheet("""
            QMenuBar {
                background-color: #f0f0f0;
                color: #000;
                font-size: 14px;
                font-family: 'Calibri';
            }
            QMenuBar::item {
                background-color: #f0f0f0;
                color: #000;
                font-size: 14px;
                font-family: 'Calibri';
            }
            QMenuBar::item:selected {
                background-color: #d0d0d0;
            }
            QMenu {
                background-color: #f0f0f0;
                color: #000;
                font-size: 14px;
                font-family: 'Calibri';
            }
            QMenu::item:selected {
                background-color: #d0d0d0;
            }
        """)

        # Araçlar menü öğesi
        tools_menu = menu_bar.addMenu('Araçlar')
        mas_action = QAction(QIcon(resource_path("icons/mas.png")), 'Microsoft Activation Scripts', self)
        mas_action.triggered.connect(self.run_mas_script)
        tools_menu.addAction(mas_action)

        idm_activation_action = QAction(QIcon(resource_path("icons/terminal.png")), 'IDM Activation Script', self)
        idm_activation_action.triggered.connect(self.run_idm_activation_script)
        tools_menu.addAction(idm_activation_action)

        defender_remover_action = QAction(QIcon(resource_path("icons/terminal.png")), 'Defender Remover', self)
        defender_remover_action.triggered.connect(self.download_and_run_defender_remover)
        tools_menu.addAction(defender_remover_action)

        fido_action = QAction(QIcon(resource_path("icons/terminal.png")), 'Fido [Windows ISO İndirici]', self)
        fido_action.triggered.connect(self.run_fido_script)
        tools_menu.addAction(fido_action)

        tools_menu.addSeparator()

        winfetch_action = QAction(QIcon(resource_path("icons/terminal.png")), 'Winfetch [Sistem Bilgileri]', self)
        winfetch_action.triggered.connect(self.run_winfetch_script)
        tools_menu.addAction(winfetch_action)

        tools_menu.addSeparator()

        atlasos_action = QAction(QIcon(resource_path("icons/atlasos.png")), 'Atlas OS', self)
        atlasos_action.triggered.connect(lambda: webbrowser.open("https://atlasos.net/"))
        tools_menu.addAction(atlasos_action)

        revios_action = QAction(QIcon(resource_path("icons/revios.png")), 'Revi OS', self)
        revios_action.triggered.connect(lambda: webbrowser.open("https://www.revi.cc/"))
        tools_menu.addAction(revios_action)

        tools_menu.addSeparator()

        antizapret_action = QAction(QIcon(resource_path("icons/terminal.png")), 'AntiZapret [Sanal Özel Ağ]', self)
        antizapret_action.triggered.connect(lambda: webbrowser.open("https://antizapret.prostovpn.org/"))
        tools_menu.addAction(antizapret_action)

        # Yazılım Yükleyicileri menü öğesi
        installers_menu = menu_bar.addMenu('Yazılım Yükleyicileri')
        ninite_action = QAction(QIcon(resource_path("icons/Ninite.png")), 'Ninite.net', self)
        ninite_action.triggered.connect(self.open_ninite)
        installers_menu.addAction(ninite_action)

        packagepicker_action = QAction(QIcon(resource_path("icons/PackagePicker.svg")), 'PackagePicker.co', self)
        packagepicker_action.triggered.connect(self.open_packagepicker)
        installers_menu.addAction(packagepicker_action)

        ctt_action = QAction(QIcon(resource_path("icons/ChrisTitusTech.png")), "Chris Titus Tech's Windows Utility", self)
        ctt_action.triggered.connect(self.run_ctt_script)
        installers_menu.addAction(ctt_action)

        winget_run_action = QAction(QIcon(resource_path("icons/winget.run.ico")), 'Winget.run', self)
        winget_run_action.triggered.connect(lambda: webbrowser.open("https://winget.run/"))
        installers_menu.addAction(winget_run_action)

        winstall_app_action = QAction(QIcon(resource_path("icons/winstall.app.ico")), 'Winstall.app', self)
        winstall_app_action.triggered.connect(lambda: webbrowser.open("https://winstall.app/"))
        installers_menu.addAction(winstall_app_action)

        installers_menu.addSeparator()

        # Sistem Araçları menü öğesi
        system_tools_menu = menu_bar.addMenu('Sistem Araçları')
        device_manager_action = QAction(QIcon(resource_path("icons/devmgmt.png")), 'Aygıt Yöneticisi', self)
        device_manager_action.triggered.connect(lambda: os.startfile("devmgmt.msc"))
        system_tools_menu.addAction(device_manager_action)

        add_remove_programs_action = QAction(QIcon(resource_path("icons/appwiz.png")), 'Program Ekle ve Kaldır', self)
        add_remove_programs_action.triggered.connect(lambda: os.startfile("appwiz.cpl"))
        system_tools_menu.addAction(add_remove_programs_action)

        network_connections_action = QAction(QIcon(resource_path("icons/ncpa.png")), 'Ağ Bağlantıları', self)
        network_connections_action.triggered.connect(lambda: os.startfile("ncpa.cpl"))
        system_tools_menu.addAction(network_connections_action)

        registry_editor_action = QAction(QIcon(resource_path("icons/regedit.png")), 'Kayıt Defteri', self)
        registry_editor_action.triggered.connect(lambda: os.startfile("regedit"))
        system_tools_menu.addAction(registry_editor_action)

        task_manager_action = QAction(QIcon(resource_path("icons/taskmgr.png")), 'Görev Yöneticisi', self)
        task_manager_action.triggered.connect(lambda: os.startfile("taskmgr"))
        system_tools_menu.addAction(task_manager_action)

        cmd_action = QAction(QIcon(resource_path("icons/terminal.png")), 'Komut Penceresi', self)
        cmd_action.triggered.connect(lambda: os.startfile("cmd"))
        system_tools_menu.addAction(cmd_action)

        cmd_admin_action = QAction(QIcon(resource_path("icons/terminal.png")), 'Komut Penceresi (Yönetici)', self)
        cmd_admin_action.triggered.connect(lambda: subprocess.run(["powershell", "-Command", 'Start-Process cmd -Verb RunAs']))
        system_tools_menu.addAction(cmd_admin_action)

        powershell_action = QAction(QIcon(resource_path("icons/powershell.png")), 'PowerShell', self)
        powershell_action.triggered.connect(lambda: os.startfile("powershell"))
        system_tools_menu.addAction(powershell_action)

        powershell_admin_action = QAction(QIcon(resource_path("icons/powershell.png")), 'PowerShell (Yönetici)', self)
        powershell_admin_action.triggered.connect(lambda: subprocess.run(["powershell", "-Command", 'Start-Process powershell -Verb RunAs']))
        system_tools_menu.addAction(powershell_admin_action)

        system_info_action = QAction(QIcon(resource_path("icons/msinfo32.png")), 'Sistem Bilgisi', self)
        system_info_action.triggered.connect(lambda: os.startfile("msinfo32"))
        system_tools_menu.addAction(system_info_action)

        disk_management_action = QAction(QIcon(resource_path("icons/diskmgmt.png")), 'Disk Yönetimi', self)
        disk_management_action.triggered.connect(lambda: os.startfile("diskmgmt.msc"))
        system_tools_menu.addAction(disk_management_action)

        services_action = QAction(QIcon(resource_path("icons/services.png")), 'Servisler', self)
        services_action.triggered.connect(lambda: os.startfile("services.msc"))
        system_tools_menu.addAction(services_action)

        msconfig_action = QAction(QIcon(resource_path("icons/msconfig.png")), 'Sistem Yapılandırması', self)
        msconfig_action.triggered.connect(lambda: os.startfile("msconfig"))
        system_tools_menu.addAction(msconfig_action)

        # Kullanıcı Hesabı Denetimi ayarları
        uac_settings_action = QAction(QIcon(resource_path("icons/uac.png")), 'Kullanıcı Hesabı Denetimi', self)
        uac_settings_action.triggered.connect(lambda: os.startfile("UserAccountControlSettings.exe"))
        system_tools_menu.addAction(uac_settings_action)

        # Windows Güvenliği menü öğesi
        windows_security_action = QAction(QIcon(resource_path("icons/windows_security.png")), 'Windows Güvenliği', self)
        windows_security_action.triggered.connect(lambda: os.startfile("windowsdefender:"))
        system_tools_menu.addAction(windows_security_action)

        system_tools_menu.addSeparator()

        # Hakkında menü öğesi
        about_menu = menu_bar.addMenu('Hakkında')
        about_action = QAction(QIcon(resource_path("icons/about.png")), 'Hakkında', self)
        about_action.triggered.connect(self.show_about_dialog)
        about_menu.addAction(about_action)

        sordum_net_action = QAction(QIcon(resource_path("icons/Sordumnet.ico")), 'sordum.net', self)
        sordum_net_action.triggered.connect(lambda: webbrowser.open("https://www.sordum.net"))
        about_menu.addAction(sordum_net_action)

        sordum_org_action = QAction(QIcon(resource_path("icons/sordumorg.ico")), 'sordum.org', self)
        sordum_org_action.triggered.connect(lambda: webbrowser.open("https://www.sordum.org"))
        about_menu.addAction(sordum_org_action)

        main_layout.setMenuBar(menu_bar)

        title = QLabel('Yüklemek istediğiniz yazılımları seçin:')
        title.setStyleSheet("font-size: 16px; font-weight: 900; font-family: 'Calibri';")
        main_layout.addWidget(title)

        self.selected_count_label = QLabel(f'Seçilen yazılım sayısı: 0 / {self.total_software_count}')
        self.selected_count_label.setStyleSheet("font-family: 'Calibri';")
        main_layout.addWidget(self.selected_count_label)

        self.scroll_area = QScrollArea()
        self.scroll_area.setWidgetResizable(True)
        scroll_content = QWidget()
        scroll_layout = QVBoxLayout(scroll_content)
        scroll_layout.setSpacing(2)  # Reduce spacing between items

        self.software_checkboxes = {}
        self.status_labels = {}

        QToolTip.setFont(QFont('Calibri', 10))

        for category, software_dict in software_list.items():
            category_group = QGroupBox(category)
            category_group.setStyleSheet("QGroupBox { font-weight: bold; font-family: 'Calibri'; }")
            category_layout = QVBoxLayout(category_group)
            category_layout.setSpacing(2)  # Reduce spacing between items
            category_group.setLayout(category_layout)
            scroll_layout.addWidget(category_group)

            for software, (url, logo_path) in sorted(software_dict.items()):
                software_widget = QWidget()
                software_layout = QHBoxLayout(software_widget)
                software_layout.setSpacing(2)  # Reduce spacing between items

                logo_label = QLabel()
                pixmap = QPixmap(logo_path)
                if pixmap.isNull():
                    print(f"Error loading icon: {logo_path}")
                logo_label.setPixmap(pixmap.scaled(22, 22, Qt.IgnoreAspectRatio, Qt.SmoothTransformation))  # Smaller logo
                software_layout.addWidget(logo_label)

                status_label = QLabel()
                status_icon, is_installed = check_software_installed(software, self.software_paths.get(software, []))
                status_label.setPixmap(status_icon.scaled(16, 16, Qt.IgnoreAspectRatio, Qt.SmoothTransformation))  # Smaller status icon
                software_layout.addWidget(status_label)
                self.status_labels[software] = status_label

                cb = QCheckBox(software)
                cb.setStyleSheet("font-size: 12px; font-family: 'Calibri'; font-weight: normal;")  # Smaller font size
                cb.stateChanged.connect(self.update_selected_count)
                self.software_checkboxes[software] = cb
                software_layout.addWidget(cb)

                info_icon_label = QLabel()
                info_icon_label.setPixmap(QPixmap(resource_path("icons/info.png")).scaled(16, 16, Qt.IgnoreAspectRatio, Qt.SmoothTransformation))  # Smaller info icon
                info_icon_label.setToolTip(software_info[software][1])
                info_icon_label.setMouseTracking(True)
                info_icon_label.enterEvent = lambda event, s=software: self.show_tooltip(event, s)
                info_icon_label.leaveEvent = lambda event: QToolTip.hideText()
                self.software_info_labels[software] = info_icon_label

                website_icon_label = QLabel()
                website_icon_label.setPixmap(QPixmap(resource_path("icons/internet.png")).scaled(16, 16, Qt.IgnoreAspectRatio, Qt.SmoothTransformation))  # Smaller website icon
                website_icon_label.setToolTip(software_info[software][0])
                website_icon_label.mousePressEvent = lambda event, s=software: self.open_software_website(s)

                software_layout.addStretch()
                software_layout.addWidget(info_icon_label)
                software_layout.addWidget(website_icon_label)

                category_layout.addWidget(software_widget)

        self.scroll_area.setWidget(scroll_content)
        main_layout.addWidget(self.scroll_area)

        self.progress_bar = QProgressBar(self)
        self.progress_bar.setValue(0)
        self.progress_bar.setStyleSheet("""
            QProgressBar {
                border: 2px solid #8f8f91;
                border-radius: 5px;
                text-align: center;
                font-family: 'Calibri';
                font-size: 14px;
                background-color: #f0f0f0;
            }
            QProgressBar::chunk {
                background-color: #4CAF50;  /* Change this color to your desired color */
                width: 20px;
                margin: 1px;
            }
        """)
        main_layout.addWidget(self.progress_bar)

        checkbox_layout = QHBoxLayout()
        self.popular_button = QPushButton('Tavsiye Edilen', self)
        self.popular_button.setStyleSheet("font-size: 14px; padding: 10px; border: none; background: none; color: black; font-family: 'Calibri';")
        self.popular_button.setIcon(QIcon(resource_path("icons/Recommended.png")))
        self.popular_button.clicked.connect(self.toggle_recommended)
        checkbox_layout.addWidget(self.popular_button)

        self.select_all_button = QPushButton('Hepsini Seç', self)
        self.select_all_button.setStyleSheet("font-size: 14px; padding: 10px; border: none; background: none; color: black; font-family: 'Calibri';")
        self.select_all_button.setIcon(QIcon(resource_path("icons/SelectAll.png")))
        self.select_all_button.clicked.connect(lambda: self.toggle_select_all_deselect_all(True))
        checkbox_layout.addWidget(self.select_all_button)

        self.deselect_all_button = QPushButton('Hepsini Kaldır', self)
        self.deselect_all_button.setStyleSheet("font-size: 14px; padding: 10px; border: none; background: none; color: black; font-family: 'Calibri';")
        self.deselect_all_button.setIcon(QIcon(resource_path("icons/RemoveAll.png")))
        self.deselect_all_button.clicked.connect(lambda: self.toggle_select_all_deselect_all(False))
        checkbox_layout.addWidget(self.deselect_all_button)

        main_layout.addLayout(checkbox_layout)

        button_layout = QHBoxLayout()
        self.install_button = QPushButton('Yükle', self)
        self.install_button.setStyleSheet("font-size: 14px; padding: 10px; font-family: 'Calibri';")
        self.install_button.setIcon(QIcon(resource_path("icons/Run.png")))
        self.install_button.clicked.connect(self.on_install_button_click)
        button_layout.addWidget(self.install_button)

        self.exit_button = QPushButton('Çıkış', self)
        self.exit_button.setStyleSheet("font-size: 14px; padding: 10px; font-family: 'Calibri';")
        self.exit_button.setIcon(QIcon(resource_path("icons/Exit.png")))
        self.exit_button.clicked.connect(self.close)
        button_layout.addWidget(self.exit_button)

        main_layout.addLayout(button_layout)
        self.setLayout(main_layout)

        # Pencereyi sağda aç ve tam ekran yapma
        self.setGeometry(screen_width - (screen_width // 4) - 20, screen_height // 7, screen_width // 5, screen_height * 3 // 4)

    def show_about_dialog(self):
        QMessageBox.about(self, "Hakkında", "by GOG - Çevrimiçi Yükleyici\n\nBu program, çeşitli yazılımların kolayca indirilip kurulmasına yardımcı olmak amacıyla, tamamen yapay zeka kullanılarak GOG tarafından geliştirilmiştir.")

    def run_mas_script(self):
        subprocess.run(["powershell", "-Command", "irm https://get.activated.win | iex"])

    def run_ctt_script(self):
        subprocess.run(["powershell", "-Command", 'Start-Process powershell -ArgumentList "irm https://christitus.com/win | iex" -Verb RunAs'])

    def run_idm_activation_script(self):
        subprocess.run(["powershell", "-Command", "iex(irm is.gd/idm_reset)"])

    def download_and_run_defender_remover(self):
        local_filename = os.path.join(tempfile.gettempdir(), "DefenderRemover.exe")
        subprocess.run(["curl", "-L", "-o", local_filename, "https://github.com/ionuttbara/windows-defender-remover/releases/latest/download/DefenderRemover.exe"])
        subprocess.run(["powershell", "-Command", f'Start-Process "{local_filename}" -Verb RunAs'])

    def run_fido_script(self):
        tools_dir = "C:\\Tools"
        os.makedirs(tools_dir, exist_ok=True)
        fido_path = os.path.join(tools_dir, 'Fido.ps1')
        subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-Command", f'irm "https://raw.githubusercontent.com/pbatard/Fido/master/Fido.ps1" -OutFile "{fido_path}"; & "{fido_path}"'])

    def run_winfetch_script(self):
        tools_dir = "C:\\Tools"
        os.makedirs(tools_dir, exist_ok=True)
        winfetch_path = os.path.join(tools_dir, 'winfetch.ps1')
        subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-Command", f'irm "https://raw.githubusercontent.com/lptstr/winfetch/master/winfetch.ps1" -OutFile "{winfetch_path}"; & "{winfetch_path}"'])

    def open_ninite(self):
        webbrowser.open("https://ninite.com/")

    def open_packagepicker(self):
        webbrowser.open("https://packagepicker.co/")

    def update_selected_count(self):
        selected_count = sum(cb.isChecked() for cb in self.software_checkboxes.values())
        self.selected_count_label.setText(f'Seçilen yazılım sayısı: {selected_count} / {self.total_software_count}')
        
        if self.software_checkboxes["Spotify"].isChecked():
            self.software_checkboxes["Spotify SpotX"].setEnabled(False)
        else:
            self.software_checkboxes["Spotify SpotX"].setEnabled(True)
        
        if self.software_checkboxes["Spotify SpotX"].isChecked():
            self.software_checkboxes["Spotify"].setEnabled(False)
        else:
            self.software_checkboxes["Spotify"].setEnabled(True)

    def on_install_button_click(self):
        selected_software = {software: software_list[category][software][0] for category in software_list for software in software_list[category] if self.software_checkboxes[software].isChecked()}
        if selected_software:
            self.install_button.setEnabled(False)
            self.disable_all_checkboxes()
            thread = threading.Thread(target=self.install_software, args=(selected_software,))
            thread.start()
        else:
            QMessageBox.warning(self, "Uyarı", "Lütfen en az bir yazılım seçin.")

    def disable_all_checkboxes(self):
        for checkbox in self.software_checkboxes.values():
            checkbox.setEnabled(False)

    def enable_all_checkboxes(self):
        for checkbox in self.software_checkboxes.values():
            checkbox.setEnabled(True)

    def install_software(self, selected_software):
        total_software = len(selected_software)
        progress_step = 100 // total_software
        self.installation_times = {}

        with tempfile.TemporaryDirectory() as temp_dir:
            for index, (software, url) in enumerate(selected_software.items()):
                start_time = time.time()
                
                # Yazılımı vurgula
                QMetaObject.invokeMethod(self, "highlight_software", Qt.QueuedConnection, Q_ARG(str, software))

                # Listeyi kurulan yazılımın üzerine kaydır
                if index == 0:
                    QMetaObject.invokeMethod(self, "scroll_to_software", Qt.QueuedConnection, Q_ARG(str, software))

                if software == "Spotify SpotX":
                    subprocess.run(["powershell", "-Command", "iex \"& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1') } -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -podcasts_off -block_update_on -start_spoti -new_theme -adsections_off -lyrics_stat spotify\"; Stop-Process -Name Spotify"])
                elif callable(url):
                    url()
                elif url.endswith(".py"):
                    subprocess.run(["python", url])
                elif url.startswith("http://") or url.startswith("https://"):
                    response = requests.get(url)
                    file_name = os.path.join(temp_dir, url.split("/")[-1])

                    with open(file_name, "wb") as file:
                        file.write(response.content)

                    subprocess.run(["cmd.exe", "/c", file_name])
                else:
                    # Yerel dosya yolu
                    local_path = resource_path(url)
                    subprocess.run(["cmd.exe", "/c", local_path])

                end_time = time.time()
                installation_time = end_time - start_time
                self.installation_times[software] = installation_time

                QMetaObject.invokeMethod(self.progress_bar, "setValue", Qt.QueuedConnection, Q_ARG(int, (index + 1) * progress_step))

                # Kurulumdan sonra ikonları yenile
                QMetaObject.invokeMethod(self, "update_status_icon", Qt.QueuedConnection, Q_ARG(str, software))

                # Vurgulamayı kaldır
                QMetaObject.invokeMethod(self, "unhighlight_software", Qt.QueuedConnection, Q_ARG(str, software))

        QMetaObject.invokeMethod(self, "show_success_message", Qt.QueuedConnection)

    @Slot(str)
    def highlight_software(self, software):
        checkbox = self.software_checkboxes.get(software)
        if checkbox:
            checkbox.setStyleSheet("text-decoration: underline; font-family: 'Calibri';")

    @Slot(str)
    def unhighlight_software(self, software):
        checkbox = self.software_checkboxes.get(software)
        if checkbox:
            checkbox.setStyleSheet("text-decoration: none; font-family: 'Calibri';")

    @Slot(str)
    def scroll_to_software(self, software):
        checkbox = self.software_checkboxes.get(software)
        if checkbox:
            self.scroll_area.ensureWidgetVisible(checkbox)

    def format_time(self, seconds):
        hours, remainder = divmod(seconds, 3600)
        minutes, seconds = divmod(remainder, 60)
        time_str = ""
        if hours > 0:
            time_str += f"{int(hours)} saat, "
        if minutes > 0:
            time_str += f"{int(minutes)} dakika, "
        time_str += f"{int(seconds)} saniye"
        return time_str

    @Slot(str)
    def update_status_icon(self, software):
        status_icon, _ = check_software_installed(software, self.software_paths.get(software, []))
        self.status_labels[software].setPixmap(status_icon.scaled(16, 16, Qt.IgnoreAspectRatio, Qt.SmoothTransformation))

    @Slot()
    def show_success_message(self):
        self.progress_bar.setValue(0)
        self.install_button.setEnabled(True)
        self.enable_all_checkboxes()
        total_installation_time = sum(self.installation_times.values())
        installation_times_str = "\n".join([f"{software}: {self.format_time(time)}" for software, time in self.installation_times.items()])
        
        failed_software = [software for software, label in self.status_labels.items() if label.pixmap().cacheKey() == QPixmap(resource_path("icons/black_check.png")).cacheKey()]
        if failed_software:
            failed_software_str = "\n".join(failed_software)
            QMessageBox.information(self, "Kurulum Tamamlandı", f"Seçilen yazılımlar başarıyla indirildi ve kuruldu.\nKurulum süreleri:\n{installation_times_str}\nToplam kurulum süresi: {self.format_time(total_installation_time)}\n\nKurulamayan yazılımlar:\n{failed_software_str}")
        else:
            QMessageBox.information(self, "Başarılı", f"Seçilen yazılımlar başarıyla indirildi ve kuruldu.\nKurulum süreleri:\n{installation_times_str}\nToplam kurulum süresi: {self.format_time(total_installation_time)}")
        
        self.reset_selections()

    def reset_selections(self):
        for checkbox in self.software_checkboxes.values():
            checkbox.setChecked(False)
        self.update_selected_count()
        self.enable_all_checkboxes()

    def toggle_select_all_deselect_all(self, select_all):
        for checkbox in self.software_checkboxes.values():
            checkbox.setChecked(select_all)
        self.update_selected_count()

    def toggle_recommended(self):
        recommended_software = [
            "WinRAR", "K-Lite Codec Pack Mega", "BleachBit", 
            "HWiNFO", "Snappy Driver Installer Origin", "Rufus", "UniGetUI", 
            "Discord", "AnyDesk", "Brave Browser", "Google Chrome"
        ]
        for software in self.software_checkboxes:
            self.software_checkboxes[software].setChecked(software in recommended_software)
        self.update_selected_count()

    def keyPressEvent(self, event):
        if (event.key() == Qt.Key_F5):
            self.refresh_status_icons()

    def refresh_status_icons(self):
        for software in self.status_labels.keys():
            self.update_status_icon(software)

    def show_info_icon(self, software):
        info_icon_label = self.software_info_labels.get(software)
        if info_icon_label:
            info_icon_label.setToolTip(software_info[software][1])
            info_icon_label.setVisible(True)

    def hide_info_icon(self, software):
        info_icon_label = self.software_info_labels.get(software)
        if info_icon_label:
            info_icon_label.setVisible(False)

    def open_software_website(self, software):
        webbrowser.open(software_info[software][0])

    def show_tooltip(self, event, software):
        QToolTip.showText(event.globalPosition().toPoint(), software_info[software][1])

if __name__ == '__main__':
    app = QApplication(sys.argv)
    # Windows stilini ayarla
    app.setStyle("windowsvista")
    
    ex = SoftwareInstallerApp()
    ex.show()
    sys.exit(app.exec())