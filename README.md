Bu Python dosyası, `byGOG - Çevrimiçi Yükleyici` adında bir yazılım yükleme aracını tanımlar. Bu araç, kullanıcıların çeşitli yazılımları kolayca indirip kurmalarını sağlamak amacıyla geliştirilmiştir. Program, PySide6 kütüphanesi kullanılarak bir grafiksel kullanıcı arayüzü (GUI) sunar ve kullanıcıların yazılımları seçip tek tıkla kurmalarını sağlar. Ayrıca, yazılımların kurulum durumunu kontrol edebilir ve kullanıcıya geri bildirimde bulunur.

### Programın Temel Özellikleri:

1. **Yazılım Kategorileri ve Listesi:**
   - Program, yazılımları farklı kategorilere ayırarak sunar. Örneğin, "Dosya Paylaşımı", "Dosya Yönetimi", "Geliştirme", "Güvenlik ve Gizlilik", "Medya Oynatıcılar", "Ofis ve Üretkenlik", "OS ve Araçlar", "Oyun Yazılımları", "Sosyal ve İletişim", "Uzaktan Çalışma", "Web Tarayıcıları" gibi kategoriler bulunur.
   - Her kategoride, popüler yazılımlar listelenir. Örneğin, "7-Zip", "Notepad++", "Visual Studio Code", "Steam", "Discord", "Google Chrome" gibi yazılımlar mevcuttur.

2. **Yazılım Bilgileri ve İkonlar:**
   - Her yazılımın bir ikonu ve açıklaması bulunur. Kullanıcılar, yazılımlar hakkında daha fazla bilgi edinmek için bilgi ikonuna tıklayabilir veya yazılımın resmi web sitesine gitmek için web ikonuna tıklayabilir.
   - Yazılımların kurulum durumu, yeşil veya siyah bir onay işareti ile gösterilir. Yeşil onay işareti, yazılımın zaten yüklü olduğunu, siyah onay işareti ise yüklü olmadığını belirtir.

3. **Kurulum İşlemi:**
   - Kullanıcılar, birden fazla yazılım seçebilir ve "Yükle" butonuna tıklayarak kurulum işlemini başlatabilir.
   - Kurulum işlemi sırasında bir ilerleme çubuğu (progress bar) gösterilir ve her yazılımın kurulum süresi kaydedilir.
   - Kurulum tamamlandığında, kullanıcıya başarılı bir şekilde kurulan yazılımlar ve kurulum süreleri hakkında bilgi verilir. Ayrıca, kurulamayan yazılımlar da belirtilir.

4. **Ek Araçlar ve Menüler:**
   - Programda, yazılım yükleme işlemlerinin yanı sıra çeşitli sistem araçlarına ve betiklere erişim sağlayan bir menü bulunur. Örneğin:
     - **Microsoft Activation Scripts (MAS):** Windows lisans aktivasyonu için kullanılır.
     - **IDM Activation Script:** Internet Download Manager aktivasyonu için kullanılır.
     - **Defender Remover:** Windows Defender'ı kaldırmak için kullanılır.
     - **Fido:** Windows ISO dosyalarını indirmek için kullanılır.
     - **Winfetch:** Sistem bilgilerini görüntülemek için kullanılır.
   - Ayrıca, **Ninite.net**, **PackagePicker.co**, **Winget.run** gibi popüler yazılım yükleme araçlarına hızlı erişim sağlanır.

5. **Sistem Araçları:**
   - Program, kullanıcıların hızlı bir şekilde sistem araçlarına erişmesini sağlar. Örneğin, "Aygıt Yöneticisi", "Program Ekle ve Kaldır", "Kayıt Defteri", "Görev Yöneticisi", "PowerShell" gibi araçlara tek tıkla erişim sağlanır.

6. **Kullanıcı Arayüzü:**
   - Programın arayüzü, kullanıcı dostu ve modern bir tasarıma sahiptir. Yazılımlar, kategorilere ayrılmış bir şekilde listelenir ve kullanıcılar kolayca seçim yapabilir.
   - Kullanıcılar, "Hepsini Seç" veya "Hepsini Kaldır" butonlarıyla tüm yazılımları seçebilir veya seçimlerini sıfırlayabilir.
   - Ayrıca, "Tavsiye Edilen" butonu ile popüler yazılımlar otomatik olarak seçilebilir.

7. **Çoklu Dil Desteği:**
   - Programın arayüzü Türkçe olarak tasarlanmıştır, ancak kod yapısı itibarıyla farklı dillere uyarlanabilir.

8. **Çoklu İş Parçacığı (Multithreading):**
   - Kurulum işlemleri, ana arayüzü kilitlemeden arka planda çalıştırılır. Bu sayede kullanıcı, kurulum sırasında programı kullanmaya devam edebilir.

9. **Hata Yönetimi:**
   - Kurulum sırasında herhangi bir hata oluştuğunda, kullanıcıya bilgi verilir ve hangi yazılımların kurulamadığı belirtilir.

### Programın Çalışma Mantığı:

1. **Başlangıç:**
   - Program başladığında, kullanıcıya yazılımların listelendiği bir arayüz sunulur. Her yazılımın yanında bir onay kutusu (checkbox) bulunur ve kullanıcılar bu kutuları işaretleyerek yazılımları seçer.

2. **Yazılım Seçimi:**
   - Kullanıcılar, birden fazla yazılım seçebilir ve "Yükle" butonuna tıklayarak kurulum işlemini başlatır.

3. **Kurulum İşlemi:**
   - Seçilen yazılımlar, sırayla indirilir ve kurulur. Kurulum işlemi sırasında bir ilerleme çubuğu gösterilir.
   - Her yazılımın kurulum süresi kaydedilir ve kurulum tamamlandığında kullanıcıya bilgi verilir.

4. **Kurulum Sonrası:**
   - Kurulum tamamlandığında, kullanıcıya hangi yazılımların başarıyla kurulduğu ve hangilerinin kurulamadığı bildirilir. Ayrıca, her yazılımın kurulum süresi de kullanıcıya sunulur.

### Teknik Detaylar:

- **PySide6:** Programın GUI'si, PySide6 kütüphanesi kullanılarak oluşturulmuştur. Bu kütüphane, Python ile modern ve etkileşimli kullanıcı arayüzleri oluşturmak için kullanılır.
- **Threading:** Kurulum işlemleri, `threading` modülü kullanılarak arka planda çalıştırılır. Bu sayede, kullanıcı arayüzü kurulum sırasında donmaz.
- **Subprocess:** Yazılımların kurulumu, `subprocess` modülü kullanılarak sistem komutları çalıştırılarak gerçekleştirilir.
- **Requests:** İnternet üzerinden yazılım indirme işlemleri, `requests` kütüphanesi kullanılarak yapılır.
- **Winreg:** Windows kayıt defteri işlemleri için `winreg` modülü kullanılır. Özellikle Java gibi yazılımların kurulum durumu, kayıt defteri üzerinden kontrol edilir.

### Özet:
`byGOG - Çevrimiçi Yükleyici`, kullanıcıların çeşitli yazılımları kolayca indirip kurmalarını sağlayan bir araçtır. Modern bir kullanıcı arayüzüne sahiptir ve kullanıcı dostu özellikler sunar. Program, yazılımları kategorilere ayırarak sunar, kurulum durumunu kontrol eder ve kullanıcıya geri bildirimde bulunur. Ayrıca, çeşitli sistem araçlarına ve betiklere hızlı erişim sağlar.
