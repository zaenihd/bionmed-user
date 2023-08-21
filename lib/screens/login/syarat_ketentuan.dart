import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SyaratDanKetentuan extends StatelessWidget {
  SyaratDanKetentuan({super.key});

  final loginC = Get.put(ControllerLogin());
  final box = GetStorage();

  final ScrollController _controller = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syarat dan Ketentuan Pengguna BionMed')),
      body: SingleChildScrollView(
          controller: _controller,
        child: Padding(
            padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
               const Center(
                child: Text(
                  'SYARAT DAN KETENTUAN\nPENGGUNAAN BionMed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '(Terakhir diperbarui tanggal: 8 Maret 2023)',
                style: TextStyle(fontSize: 14, height :1.8),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'MOHON UNTUK MEMBACA SELURUH SYARAT DAN KETENTUAN PENGGUNAAN SERTA KEBIJAKAN PRIVASI BIONMED DENGAN CERMAT DAN SAKSAMA SEBELUM MENGGUNAKAN SETIAP FITUR DAN/ATAU LAYANAN YANG TERSEDIA DALAM PLATFORM BIONMED.',
                style: TextStyle(fontSize: 14,height: 1.8,),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Syarat dan Ketentuan Penggunaan BionMed (“Ketentuan Penggunaan”) ini merupakan suatu perjanjian sah terkait tata cara dan persyaratan penggunaan fitur dan/atau layanan (“Layanan”) Platform BionMed (“Platform”) antara Pengguna (“Anda”) dengan pengelola Platform, yaitu PT Cahaya Putrasakti Mandiri (“Kami”). Dengan mengunduh dan/atau memasang dan/atau menggunakan Platform dan/atau menikmati Layanan Kami, Anda setuju bahwa Anda telah membaca, memahami, mengetahui, menerima, dan menyetujui seluruh informasi, syarat-syarat, dan ketentuan-ketentuan penggunaan Platform yang terdapat dalam Ketentuan Penggunaan ini.\n \n Kami dapat mengubah ketentuan dalam Ketentuan Penggunaan ini kapan saja. Perubahan tersebut akan berlaku setelah ditampilkan di Platform. Adalah tanggung jawab Anda untuk meninjau Ketentuan Penggunaan secara teratur. Keberlanjutan Anda atas penggunaan Platform setelah adanya setiap perubahan tersebut, baik telah Anda tinjau atau tidak, akan merupakan perjanjian Anda untuk terikat oleh setiap perubahan tersebut.\n \nApabila Anda tidak setuju terhadap salah satu, sebagian, atau seluruh isi yang tertuang dalam Ketentuan Penggunaan ini, silakan untuk menghapus Platform dalam perangkat elektronik Anda dan/atau tidak mengakses Platform dan/atau tidak menggunakan Layanan Kami. Mohon untuk dapat diperhatikan pula bahwa Ketentuan Penggunaan ini dapat diperbarui dari waktu ke waktu.',
                style: TextStyle(fontSize: 14,height: 1.8,),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '1. KETENTUAN UMUM',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "a. Platform adalah aplikasi (versi Android atau IOS), aplikasi web (aplikasi yang dapat diakses menggunakan web), dan/atau website yang dikelola oleh Kami sebagaimana diperbarui dari waktu ke waktu.\nb. Koneksi internet diperlukan untuk dapat menggunakan Layanan dan biaya terkait penggunaan koneksi internet tersebut ditanggung sepenuhnya oleh Anda.\nc. Platform berfungsi sebagai sarana untuk menghubungkan Anda dengan pihak ketiga yang menyediakan layana atau menjual barang kepada Anda seperti (tetapi tidak terbatas pada) dokter, bidan, perawat, apotek, laboratorium klinik, rumah sakit.\nd. Jenis-jenis layanan yang dapat diakses dan digunakan melalui Platform adalah: \n \n(i) Konsultasi medis dengan dokter via Chat, voice call, dan video call \n(ii) Pembelian obat di Apotek kami secara On Line; \n(iii) Buat Janji dengan dokter di RS (on line registration) \n(iv) Perawatan pasien di rumah sendiri (Housepital)\nInternal\n(v) Pelayanan Perawat di Rumah (Nursing Home)\n(vi) Perawatan bayi di rumah oleh Perawat (Baby care)\n(vii) Perawatan Ibunda di rumah (Mather Care)\n(viii) Pelayanan penjemputan ambulance (Ambulance)\n(ix) Pelayanan Laboratorium Medis secara on line baik di rumah pasien maupun di rumah sakit (Laboratorium Medis)\n(iv) Layanan lain yang dapat Kami tambahkan dari waktu ke waktu; \n \n('Layanan').\n \n e. Aplikasi web merupakan fitur yang berfungsi sebagai sarana Anda untuk mengakses beberapa Layanan Kami tanpa perlu mengunduh Aplikasi ('Aplikasi Web'). \nf. Platform merupakan sarana untuk memudahkan pencarian atas Layanan dimana Kami bekerjasama dengan penyelenggara pelayanan kesehatan, dan penyelenggaran pelayanan kefarmasian. \ng. Kami dapat menggunakan jasa pihak ketiga terkait penyediaan layanan pembayaran. Apabila terjadi kegagalan pada sistem pembayaran, Kami akan berupaya semaksimal mungkin dalam membantu menyelesaikan masalah yang mungkin timbul. Penyedia jasa perbankan/pembayaran yang dipilih oleh Anda dapat mengenakan biaya tambahan kepada Anda atas layanan yang diberikan. \nh. Fitur 'Aplikasi layanan Kesehatan secara on line ‘BionMed’ ' dikelola oleh PT Cahaya Putrasakti Mandiri ('PT. CPM'). \ni. Platform memungkinkan Anda untuk mengirimkan permintaan atas suatu Layanan kepada Penyedia Layanan. Penyedia Layanan memiliki kebijakan sendiri dan kewenangan penuh untuk menerima atau menolak setiap permintaan Anda atas Layanan. Jika Penyedia Layanan menerima permintaan Anda, Platform akan memberitahu Anda dan memberikan informasi mengenai Penyedia Layanan, termasuk nomor order dan kemampuan untuk menghubungi Penyedia Layanan melalui telepon (call center). \nj. Setiap fitur atau fasilitas dalam Platform dapat diperbarui atau diubah sesuai dengan kebutuhan dan perkembangan Platform. \nk. Pengumpulan, penyimpanan, pengolahan, penggunaan dan pembagian setiap informasi pribadi Anda, seperti nama, alamat surat elektronik, dan nomor telepon genggam Anda yang Anda berikan ketika Anda membuka akun di Platform, maupun setiap informasi terkait riwayat kesehatan Anda tunduk pada Kebijakan Privasi, yang merupakan bagian yang tidak terpisahkan dari Ketentuan Penggunaan ini. Anda memahami dan setuju bahwa penggunaan Anda atas Platform juga harus mematuhi Kebijakan Privasi Kami, sebagaimana dapat diperbaharui dari waktu ke waktu. \nl. Kami dapat menghentikan atau membatasi proses registrasi atau penggunaan Platform oleh Anda jika ditemukan pelanggaran dari Ketentuan Penggunaan ini atau peraturan perundang-undangan yang berlaku. \nm. Kami adalah perusahaan teknologi, bukan penyedia layanan kesehatan, dan kami tidak menyediakan layanan kesehatan. Kami tidak mempekerjakan Penyedia Layanan, dan Kami tidak bertanggung jawab atas tindakan, kecerobohan, kelalaian, dan/atau kelengahan Penyedia Layanan. Platform merupakan layanan informasi dan komunikasi online yang disediakan oleh BionMed",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '2. KETENTUAN PENGGUNAAN PLATFORM',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "a. Anda menyatakan dan menjamin bahwa Anda adalah individu yang memiliki hak untuk mengadakan perjanjian yang mengikat berdasarkan hukum Negara Republik Indonesia dan bahwa Anda telah berusia minimal 21 (dua puluh satu) tahun atau sudah menikah dan tidak berada di bawah perwalian atau pengampuan. Jika Anda berusia di bawah 21 (dua puluh satu) tahun dan belum menikah, Anda menyatakan dan menjamin bahwa Anda telah memperoleh izin dari orang tua atau wali hukum Anda, kecuali Anda menyatakan sebaliknya. Dengan memberikan persetujuan, orang tua atau wali hukum Anda setuju untuk bertanggung jawab atas:\n(i) semua tindakan Anda terkait akses ke dan penggunaan Platform dan/atau Layanan;\n(ii) biaya apa pun terkait penggunaan Anda atas Layanan apa pun; dan\n(iii) kepatuhan Anda terhadap Ketentuan Penggunaan ini. Kami berhak untuk menutup atau membatalkan pendaftaran atas akun Anda apabila hal tersebut tidak benar. Anda selanjutnya menyatakan dan menjamin bahwa Anda memiliki hak, wewenang dan kapasitas untuk menggunakan Layanan dan akan senantiasa mematuhi Ketentuan Penggunaan ini. Jika Anda mendaftarkan atas nama suatu badan usaha, Anda juga menyatakan bahwa Anda berwenang untuk bertindak untuk dan atas nama badan hukum tersebut dan untuk mengadakan dan mengikatkan badan hukum/entitas tersebut pada Ketentuan Penggunaan. \n \nb. Anda dapat menggunakan Platform dengan terlebih dahulu melakukan pendaftaran yang disertai pemberian informasi data pribadi Anda yang dapat dipertanggung jawabkan secara hukum sebagaimana diminta dalam Platform (“Data Pribadi”). Informasi terkait Data Pribadi yang diberikan hanya akan digunakan oleh kami dan/atau Penyedia Layanan untuk pemberian layanan-layanan dalam Platform dan untuk tujuan lain yang telah Anda setujui sesuai dengan ketentuan perundang-undangan yang berlaku. Kebijakan Privasi (sebagaimana diperbarui dari waktu ke waktu) menjadi bagian yang tidak terpisahkan dari Ketentuan Penggunaan ini. \n \nc. Setelah mendaftarkan diri pada Platform, Anda akan mendapatkan suatu akun pribadi yang dapat diakses dengan One Time Password (OTP) yang akan dikirimkan ke nomor telepon seluler Anda. Kami harap Anda tidak menyerahkan, mengalihkan maupun memberikan wewenang kepada orang lain untuk menggunakan identitas atau menggunakan akun Anda. Anda wajib menjaga kerahasiaan kata sandi akun Anda dan setiap identifikasi yang kami berikan kepada Anda atas akun atau Data Pribadi Anda.  \n \nd. Anda memiliki tanggung jawab atas setiap penggunaan akun Anda dalam Platform. Apabila Anda tidak memiliki kontrol atas akun Anda oleh sebab apapun, maka Anda diharuskan untuk melaporkannya kepada Kami. Apabila terjadi penyalahgunaan akun Anda oleh pihak ketiga manapun sebelum pelaporan terjadi, maka penggunaan akun pada periode tersebut akan menjadi tanggung jawab Anda sepenuhnya. \n \ne. Anda tidak diperkenankan untuk membahayakan, menyalahgunakan, mengubah atau memodifikasi Platform dengan cara apapun. Kami dapat menutup, membatalkan akun Anda dan/atau melarang Anda untuk menggunakan Platform lebih lanjut jika Anda tidak mematuhi Ketentuan Penggunaan ini. \n \nf. Dengan menggunakan Platform, maka Anda memahami, setuju, dan tunduk sesuai yang dipersyaratkan pada Kebijakan Privasi Kami sebagaimana dapat diperbaharui dari waktu ke waktu. \n \ng. Anda akan menggunakan Platform hanya untuk tujuan mendapatkan Layanan, dan tidak akan menyalahgunakan atau menggunakan Platform untuk aktivitas yang bertentangan dengan hukum, termasuk namun tidak terbatas kepada tindak pidana pencucian uang, pencurian, penggelapan, terorisme maupun penipuan. Anda juga sepakat bahwa Anda tidak akan melakukan pemesanan palsu melalui Platform dan tidak akan melakukan perbuatan melawan hukum melalui Platform. \n \nh. Anda mengetahui dan setuju bahwa setiap informasi dalam bentuk apapun, termasuk namun tidak terbatas pada video, audio, gambar atau tulisan yang ada dalam Platform memiliki hak atas kekayaan intelektual (termasuk namun tidak terbatas kepada hak atas merek dan hak cipta) masing-masing. Anda tidak diperbolehkan untuk menggunakan, mengubah, memfasilitasi, menyebarluaskan dan/atau memutilasi hak atas kekayaan intelektual tersebut tanpa izin dari pemilik hak atas kekayaan intelektual tersebut sebagaimana diatur dalam peraturan perundang-undangan yang berlaku.Internal \n \ni. Pada saat mengakses dan menggunakan Platform termasuk setiap fitur dan layanannya, Anda tidak diperkenankan untuk:\n(i) mengalihkan akun Anda di Platform kepada pihak lain tanpa persetujuan terlebih dahulu dari Kami.\n(ii) menyebarkan virus, spam atau teknologi sejenis lainnya yang dapat merusak dan/atau merugikan Platform danpengguna Platform lainnya.\n(iii) memasukkan atau memindahkan fitur pada Platform tanpa persetujuan dari Kami.\n(iv) menempatkan informasi atau aplikasi lain yang melanggar hak kekayaan intelektual pihak lain di dalam Platform.\n(v) mengambil atau mengumpulkan data pribadi dari pengguna Platform lain, termasuk tetapi tidak terbatas padaalamat surel, tanpa persetujuan dari pengguna tersebut.\n(vi) menggunakan Platform untuk hal-hal yang dilarang berdasarkan hukum dan undang-undang yang berlaku.\n(vii) menggunakan Platform untuk mendistribusikan iklan atau materi lainnya.\n \nj. Anda mengetahui dan menyetujui bahwa tarif Layanan yang tercantum pada Platform dapat mengalami perubahansesuai dengan tarif Layanan yang ditetapkan oleh Penyedia Layanan.\n \nk. Seluruh artikel kesehatan yang Kami tampilkan di Platform Kami digunakan untuk mengedukasi pengguna danbukan merupakan pengganti dari saran, diagnosis atau perawatan medis dari layanan dokter rekanan Kami.\n \nl. Seluruh informasi obat yang Kami tampilkan di Platform Kami adalah bersifat informasi umum sesuai yang tercantum pada kemasan obat.\n \nm. Platform memiliki tautan dengan situs-situs yang dioperasikan oleh pihak ketiga. Tautan tersebut tersedia untuk kenyamanan anda dan hanya akan digunakan untuk menyediakan akses ke situs pihak ketiga dan bukan untuk tujuan lainnya. Kualitas, isi maupun informasi dari Produk atau layanan tersebut akan disediakan oleh situs yang dioperasikan oleh pihak ketiga.\n \nn. Akun BionMed Anda\n\n(i) Akun BionMed Anda hanya dapat digunakan oleh Anda dan tidak bisa dialihkan kepada orang lain dengan alasan apapun. Kami berhak menolak untuk memfasilitasi pesanan jika Kami mengetahui atau mempunyai alasan yang cukup untuk menduga bahwa Anda telah mengalihkan atau membiarkan Akun Anda digunakan oleh orang lain.\n(ii) Keamanan dan kerahasiaan Akun BionMed Anda, termasuk nama terdaftar, nomor telepon genggam terdaftar,serta kode verifikasi yang dihasilkan dan dikirim oleh sistem Kami sepenuhnya merupakan tanggung jawab pribadi Anda. Semua kerugian dan risiko yang ada akibat kelalaian Anda menjaga keamanan dan kerahasiaan sebagaimana disebutkan ditanggung oleh Anda sendiri. Dalam hal demikian, Kami akan menganggap setiap penggunaan atau pesanan yang dilakukan melalui Akun Anda sebagai permintaan yang sah dari Anda.\n(iii) Kami tidak bertanggung jawab atas segala risiko yang dapat timbul atas hal-hal terkait keamanan nomor telepon genggam terdaftar, termasuk namun tidak terbatas apabila nomor telepon genggam tersebut didaur ulang (recycle)oleh operator seluler.\n(iv) Segera beritahukan Kami jika Anda mengetahui atau menduga bahwa Akun Anda telah digunakan tanpa sepengetahuan dan persetujuan Anda. Kami akan melakukan tindakan yang Kami anggap perlu dan dapat Kami lakukan terhadap penggunaan tanpa persetujuan tersebut.",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '3. LAYANAN',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "A. Fitur Telemedicine\nB. Fitur Home visit doctor\nC. Fitur Laboratorium Klinik\nD. Fitur Nursing Home\nE. Fitur Mother Care\nInternal\nF. Fitur Baby Care\nG. Fitur Apotek\nH. Fitur Ambulance\nI. Fitur Registration\nJ. Fitur Housepital",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'A.Fitur Telemedicine',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Konsultasi Medis dengan dokter spesialis melalui Chat, Voice call dan Video call\n \n(i) Fitur ini memfasilitasi dokter spesialis rekanan Kami sebagai Penyedia Layanan konsultasi medis dengan Anda melalui video call, voice call maupun chat yang dapat diakses melalui Platform BionMed.\n \n(ii) Anda dapat menghubungi dokter spesialis rekanan Kami ketika dokter spesialis rekanan Kami berstatus online.\n \n(iii) Anda dapat membatalkan booking Chat dengan dokter spesialis rekanan Kami maksimal satu hari (24 jam)sebelum jadwal untuk berkonsultasi dimulai. Proses pengembalian dana akibat pembatalan booking Chat akan dilakukan sesuai dengan prosedur yang berlaku dengan terlebih dahulu menginformasikan melalui melalui call center.\n \n(iv) Dokter spesialis rekanan Kami dapat membatalkan booking Chat maksimal 60 (enam puluh) menit sebelum jadwal untuk berkonsultasi dimulai. Proses pengembalian dana dalam hal terjadi pembatalan booking Chat akan dilakukan sesuai dengan prosedur yang berlaku, dengan terlebih dahulu menginformasikan melalui melalui call center.\n \n(v) Jika Anda tidak hadir pada jadwal booking yang telah Anda pilih maka Anda menyetujui bahwa dana yang telah Anda bayarkan tidak dapat dikembalikan.\n \n(vi) Jika dokter spesialis rekanan Kami tidak hadir pada jadwal booking yang telah Anda buat dalam waktu maksimal 5 (lima) menit setelah jadwal yang seharusnya maka Kami akan mengembalikan dana Anda sesuai dengan prosedur yang berlaku, dengan terlebih dahulu menginformasikan melalui melalui call center.\n \n(vii) Anda mengetahui dan menyetujui bahwa fitur ini tidak menggantikan pemeriksaan dan pengobatan dengan dokter spesialis pada umumnya atau tatap muka secara langsung.\n \n(viii) Kami akan berupaya semaksimal mungkin agar dokter rekanan yang terdaftar pada Platform dapat memberikan tanggapan atas pertanyaan Anda sesegera mungkin. Namun demikian, Kami tidak menyarankan Anda menggunakan Platform untuk kondisi medis darurat.\n \n(ix) Layanan Kami tidak bersifat memaksa atau pun mengikat. Keputusan untuk menggunakan Layanan di Platform sepenuhnya berada di tangan Anda. Platform hanya merupakan fasilitator interaksi antara dokter rekanan yang terdaftar pada Kami sebagai Penyedia Layanan.\n \n(xi) Anda memahami bahwa Anda perlu memberikan informasi dan menjelaskan gejala atau keluhan fisik yang Anda alami secara lengkap, jelas dan akurat ketika melakukan percakapan dengan dokter rekanan Kami melalui fitur Chat,voice call dan video call dengan dokter.A1. Rekomendasi Istirahat\n \n(i) Dengan menggunakan fitur Chat dengan dokter spesialis dapat memberikan suatu Rekomendasi Istirahat kepadaAnda berdasarkan diskresi tunggal dokter spesialis.\n \n(ii) Rekomendasi Istirahat tidak dapat digunakan untuk keperluan investigasi polisi atau proses persidangan.\n \n(iii) Anda sepenuhnya memahami bahwa Rekomendasi Istirahat hanya berupa rekomendasi dari dokter spesialiskepada Anda untuk beristirahat di rumah dan rekomendasi tersebut tidak dapat disamakan dengan surat sakit.",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'B. Fitur Home Visit doctor (kunjungan dokter ke rumah pasien)',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Fitur layanan kunjungan dokter ke rumah pasien, layanan iini kana membuat pasien yang sangat membutuhkan pertolongan segera akan tetapi pasien tidak memungkinkan di bawa ke rumah sakit, atau pasien menginginkan kenyamanan tanpa harus pergi ke rumah sakit",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'C. Fitur Laboratorium Klinik',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Pelayanan Laboratorium tanpa harus meninggalkan rumah. Tenaga pengambilan sampel yang handal dan realisasi hasil segera\n \n Fitur ini memfasilitasi pemeriksaan laboratorium bagi Anda yang berhalangan untuk datang langsung ke laboratorium.Anda dapat memilih jenis pemeriksaan laboratorium berdasarkan paket yang tersedia dalam fitur Tes Lab sesuairujukan dari dokter.\n \n Ketersediaan jenis paket dan jadwal pemeriksaan laboratorium yang Anda pilih akan disesuaikan dengan jadwal darimasing-masing laboratorium rekanan Kami.",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'D. Fitur Nursing Home',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Fitur pelayanan perawatan pasien di rumah pasien oleh perawat yang sudah berpengalaman dan sudah mempunyai sertifikat sebagai perawat",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'E. Fitur Mother Care',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Pelayanan perawatan ibu hamil dan pasca persalinan atau pasca operasi oleh perawat berpengalaman",
                style: TextStyle(fontSize: 14, height :1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'F. Fitur Baby Care',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Fitur pelayanan perawatan dan pemberian vaksin untuk Bayi anda di rumah sendiri oleh dokter anak yang berpengalaman dan bersertifikat",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'G. Fitur Apotek',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Pelayanan pembelian obat sesuai kebutuhan dengan atau tanpa resep. Pilihan obat yang lengkap dengan harga yang terjangjau",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'H. Fitur Ambulance',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Pelayanan pemesanan Ambulance secara Online",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'I. Fitur Registration',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Pelayanan registration (pendaftaran pelayanan medis secara on line) sehingga sangat menghemat waktu pasien dan tidak membuat pasien menunggu",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'J. Fitur Housepital',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Pelayanan perawatan pasien di rumah pasien sendiri oleh team medis",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '4. TRANSAKSI ANDA',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "(a) Untuk dapat bertransaksi di Platform, Anda dapat menggunakan berbagai metode pembayaran yang tersedia pada Platform.Internal\n \n(b) Apabila Anda mencurigai adanya aktivitas yang tidak wajar dan/atau terjadi perselisihan/sengketa sehubungan dengan akun Anda, Anda dapat segera menghubungi call center Kami agar Kami dapat segera mengambil tindakan yang diperlukan.\n \n(c) Anda dapat mengajukan pengembalian dana (refund) kepada Kami, klaim tersebut dapat Anda sampaikan maksimal 7 (tujuh) hari kalender sejak Anda menyampaikan bukti pendukung yang cukup. Dalam hal demikian Kami akan memproses pengembalian uang berdasarkan hasil tinjauan Kami atas klaim tersebut.\n \n(e) Pengembalian dana (refund) Anda dapat Kami kembalikan ke sumber pembayaran yang sama.\n \n(f) Kami dapat melakukan penangguhan segala transaksi yang berasal dari akun Anda serta dapat melakukan tindakan penangguhan transaksi apabila kami mengidentifikasi adanya masalah pada akun Anda atau suatu transaksi tertentu.\n \n(g) Anda memahami dan menyetujui bahwa batas waktu pengajuan keluhan mengenai transaksi adalah maksimal 7(tujuh) hari kalender setelah transaksi selesai.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '5. KETENTUAN TRANSAKSI',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "A1. Fitur Chat dengan Dokter spesialis\n \n(i) Anda akan dikenakan tarif dengan jumlah tertentu untuk dapat menggunakan layanan Chat dengan dokter rekanan Kami.\n \nApabila Anda memerlukan video call maupun voice call dengan dokter spesialis rekanan Kami, Anda perlu menginformasikan terlebih dahulu kepada dokter spesialis rekanan tersebut dan akan tergantung pada ketersediaan masing-masing dokter spesilis pada saat dihubungi.\n \nSaat menghubungi dokter spesialis melalui chat, Anda dapat mengirimkan gambar kepada dokter doktes spesialis yang berkaitan dengan kondisi medis Anda dengan format png, jpg, dan bitmap.\n \nSetelah sesi Chat dengan dokter spesialis selesai, dokter dapat memberikan Doctor Notes (Catatan Dokter) dan Medicine Recommendation (Rekomendasi Obat). Catatan Dokter adalah catatan hasil sesi Chat dengan Dokter dan saran-saran terkait dengan kondisi medis Anda. Rekomendasi Obat adalah rekomendasi yang berisi saran obat atau penanganan kesehatan bagi Anda. Rekomendasi Obat hanya bersifat rekomendasi atau saran.\n \nTransaksi tidak dapat dibatalkan setelah sesi Chat dengan Dokter berakhir atau selesai dilakukan.\n \nKami dapat memblokir atau membatalkan akun Anda apabila terdapat penyalahgunaan fitur Chat dengan Dokter spesialis pada akun Anda.\n \nDokter dapat memberikan Doctor Referral (Rujukan Dokter) sebagai referensi Anda.\n \nBiaya yang dikenakan tersebut sudah termasuk Pajak Pertambahan Nilai (PPN).\n \nKetepatan serta keakuratan Dokter spesialis dalam memberikan Medicine Recommendation (Rekomendasi Obat) akanbergantung pada informasi yang diberikan oleh Anda. Setiap isi dan/atau pernyataan-pernyataan dalam percakapan yang dilakukan oleh Anda dengan Dokter spesialis menggunakan fitur video call, voice call, chat, Doctor Notes(Catatan Dokter), Medicine Recommendation (Rekomendasi Obat), pada Platform, hal tersebut ialah percakapan daninteraksi pribadi antara Anda dengan Dokter spesialis rekanan sebagai pemberi jasa layanan kesehatan.Internal\n \nB. Fitur Apotek\n \n(i) Obat yang dapat dibeli oleh Anda adalah obat bebas (dot hijau), obat bebas terbatas (dot biru), obat keras (dotmerah) dengan resep dokter, vitamin dan alat kesehatan bukan obat, makanan dan minuman sehat bukan obat.\n \n(ii) Anda dikenakan harga barang, biaya pengantaran dan biaya layanan lainnya sebagaimana yang tertera pada Platform pada saat notifikasi 'Konfirmasi Order'.\n \n(iii) Ketersediaan obat bervariasi tergantung persediaan obat yang dimiliki Apotek rekanan Kami. Dalam hal ketersediaan obat yang Anda pesan terbagi dalam beberapa Apotek rekanan Kami, Anda dapat memilih untuk dilakukan beberapa kali pengantaran dimana tarif antar akan ditanggung oleh Anda.\n \n(iv) Apabila pesanan telah diambil oleh apotek rekanan Kami dan/atau sedang dalam proses pengantaran oleh kurir pengantar rekanan Kami, maka Anda tidak dapat membatalkan pesanan yang telah dilakukan.\n \n(v) Nilai transaksi yang dapat Anda lakukan pada fitur Apotek untuk satu kali transaksi adalah minimal Rp.10.000,-(Sepuluh Ribu Rupiah) dan maksimal Rp.5.000.000,- (Lima Juta Rupiah).\n \n(vi) Harga yang dikenakan tersebut sudah termasuk Pajak Pertambahan Nilai (PPN).\n \n(vii) Khusus untuk obat dengan resep dokter, Anda harus melampirkan dokumen berupa scan/foto resep dokter terlebih dahulu dan mengunggahnya melalui fitur Upload a Prescription (Unggah Resep) di dalam Platform untuk verifikasi pembuatan order ke Apotek rekanan Kami.\n \n(vii) Resep yang dibuat oleh dokter hanya dapat digunakan 1 (satu) kali saja dan tidak berlaku repetitif. Apabila pemesanan Produk yang membutuhkan resep dokter namun resep tersebut tidak di upload ke Platform, maka pesanan tersebut akan dianggap batal.\n \n(viii) Anda wajib menyerahkan resep asli yang digunakan sebagai dasar pembelian obat kepada Kami untuk Kami serahkan kepada Apotek rekanan yang melayani pembelian Anda.\n \n(ix) Kami bekerjasama dengan jasa pengantaran dan apotek rekanan Kami dalam menjalankan fitur Apotek. Kami akan membantu menghubungkan Anda dengan rekanan Kami tersebut apabila terdapat kendala dalam pengiriman atau pembelian obat.\n \n(x) Dengan menggunakan fitur Apotek, Anda telah setuju jika pemilihan apotek berdasarkan rekomendasi dari sistem Kami.\n \nB. Fitur Registration\n \n(i) Dengan menggunakan fitur Online Registration, Anda memahami bahwa Anda memiliki hak sepenuhnya untuk memilih rumah sakit rekanan yang sesuai dengan kebutuhan dan preferensi Anda.\n \n(ii) Perubahan jadwal praktek dokter merupakan kebijakan dari dokter maupun rumah sakit rekanan Kami. ApabilaAnda menggunakan fitur Registration dan terjadi perubahan jadwal dokter rekanan, maka Anda akan menerima konfirmasi perubahan jadwal tersebut di Platform.\n \n(iii) Anda dengan ini setuju bahwa hasil pemeriksaan dari janji ketemu yang dibuat melalui fitur ini akan diunggaholeh rekanan RS kami ke dalam Platform yang dapat diakses oleh Anda.Internal\n \nC. Fitur Tes Lab\n \n(i) Pelaksanaan fitur Tes Lab bekerjasama dengan sejumlah laboratorium rekanan Kami dimana pelaksanaan Tes Lab hingga hasil pemeriksaan laboratorium dilakukan dan dikeluarkan oleh laboratorium rekanan Kami.\n \n(ii) Anda wajib mengisi data pemesanan fitur Tes Lab secara lengkap dan akurat. Dengan melakukan pemesanan fiturTes Lab berarti Anda dianggap setuju atas detail pemesanan Tes Lab yang Anda pesan melalui Platform Kami dan bersedia dihubungi petugas yang ditentukan untuk mengkonfirmasi Tes Lab yang dipesan oleh Anda.\n \n(iii) Selain untuk diri sendiri, Anda dapat memesankan Tes Lab untuk orang lain (“Pemesanan Pihak Ketiga”).Anda menjamin bahwa Anda telah mendapatkan persetujuan yang dibutuhkan untuk pelaksanaan Pemesanan Pihak Ketiga sehubungan dengan fitur Tes Lab dimana Pemesanan Pihak Ketiga tunduk pada setiap bagian dari Ketentuan Penggunaan dan Kebijakan Privasi Kami.\n \n(iv) Tes Lab dilakukan berdasarkan prosedur umum dari laboratorium rekanan Kami. Dengan Anda melakukan pendaftaran Tes Lab, Anda dianggap setuju untuk tunduk pada setiap ketentuan prosedur umum dari laboratorium rekanan Kami tersebut yang berlaku dari waktu ke waktu.\n \n(v) Harga yang tercantum di dalam Platform Kami saat pemesanan Tes Lab telah mencakup seluruh biaya Tes Labdan biaya transportasi petugas dari lokasi laboratorium ke lokasi Anda (apabila ada).\n \n(vi) Metode pembayaran untuk Tes Lab hanya dapat dilakukan melalui metode pembayaran yang tersedia di Platform pada saat pemesanan.\n \n(vii) Apabila petugas dari laboratorium rekanan Kami sudah menuju ke lokasi Anda, maka Anda tidak dapat membatalkan pemesanan yang telah dilakukan. Pembatalan hanya dapat dilakukan selambat-lambatnya 2 (dua) jam sebelum jadwal pemesanan.\n \n(viii) Anda dapat melakukan penjadwalan ulang selambat-lambatnya 24 (dua puluh empat) jam sebelum jadwal pemesanan.\n \n(ix) Anda mengetahui dan menyetujui bahwa untuk memudahkan Anda, hasil pemeriksaan Tes Lab akan diberikan dalam format digital dan diunggah ke dalam akun BionMed Anda untuk dapat diakses oleh Anda (“Hasil TesLab').\n \n(x) Hasil Tes Lab akan disampaikan oleh laboratorium rekanan Kami kepada Anda dalam jangka waktu sesuai dengan informasi yang tercantum pada keterangan Tes Lab dalam Platform Kami.\n \n(xi) Dengan menggunakan fitur Tes Lab, Anda mengetahui dan menyetujui bahwa Hasil Tes Lab akan masuk kedalam sistem Kami dengan menggunakan sistem keamanan sesuai standar baku dalam peraturan perundang -undangan yang berlaku di Republik Indonesia. Dalam hal Pemesanan Pihak Ketiga, maka Hasil Tes Lab atas nama Pemesanan Pihak Ketiga tersebut tetap akan diunggah ke dalam akun BionMed Anda. Anda mengetahui dan dengan ini memberikan persetujuan Anda bahwa Kami bisa mendapatkan akses ke materi terkait dengan Hasil Tes Lab apabila diperlukan dan Kami dapat menggunakan abstrak dan/atau metadata dalam Hasil Tes Lab untuk keperluan pengembangan Platform Kami. Selanjutnya, Anda juga menyetujui bahwa Hasil Tes Lab merupakan Data Pribadi danakan tunduk pada setiap ketentuan dalam Kebijakan Privasi BionMed yang dapat diakses dalam\nhttps://www.BionMed.com/kebijakan-privasi.\n \n(xii) Anda dapat juga meminta cetak salinan hasil kepada laboratorium rekanan Kami yang melayani Anda. Biaya yang timbul atas permintaan/pengiriman hasil tersebut akan ditanggung oleh Anda sepenuhnya.\n \n(xiii) Seluruh isi dari Hasil Tes Lab sepenuhnya merupakan tanggung jawab laboratorium rekanan Kami.\n \n(xiv) Anda dapat mengunduh Hasil Tes Lab melalui Platform Kami. Keamanan terhadap Hasil Lab yang diunduh tersebut merupakan tanggung jawab Anda.Internal\n \n(xv) Anda memahami dan bertanggung jawab atas segala tindakan, kecerobohan dan/atau kelalaian yang terjadidalam pengolahan maupun penyebaran informasi Hasil Tes Lab atas Pemesanan Pihak Ketiga.\n \n(xvi) Anda memahami bahwa dalam hal terjadi namun tidak terbatas karena keadaan kahar atau terdapat Hasil TesLab yang memerlukan konfirmasi ulang, maka terdapat risiko terjadinya keterlambatan laboratorium rekanan Kamidalam melakukan pengambilan, pengiriman dan/atau penyampaian Hasil Tes Lab. Atas keterlambatan tersebut,Kami tidak berkewajiban untuk memberikan ganti rugi kepada Anda dalam bentuk apa pun.\n \n(xvii) Semua informasi, prosedur maupun tata laksana atas Tes Lab yang tersedia dalam Platform Kami merupakan tanggung jawab masing-masing laboratorium rekanan Kami yang relevan. Kami merupakan platform digital kesehatan yang menyediakan teknologi dan memfasilitasi komunikasi. BionMed tidak bertanggung jawab atas setiap interaksi antara Anda baik dengan petugas yang berwenang maupun laboratorium rekanan Kami sebagai Penyedia Layanan, dan atas setiap prosedur dan/atau bagian tindakan terkait fitur Tes Lab apa pun di Platform Kami.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '7. HAK ATAS KEKAYAAN INTELEKTUAL',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "a. Kami adalah pemegang hak lisensi atas nama, ikon, dan logo “BionMed” serta fitur Chat dengan Dokter dan TesLab dalam Platform, yang mana merupakan hak cipta dan merek dagang yang dilindungi undang-undang Republik Indonesia. Anda dilarang untuk menggunakan, memodifikasi, dan/atau memasang nama, ikon, logo, atau merektersebut tanpa persetujuan tertulis dari Kami. \n \n b. Seluruh hak atas kekayaan intelektual yang terdapat dalam Platform berdasarkan hukum negara Republik Indonesia,termasuk dalam hal ini adalah kepemilikan hak kekayaan intelektual atas seluruh source code Platform dan hak kekayaan intelektual terkait Platform. Untuk itu, Anda dilarang untuk melakukan pelanggaran atas hak kekayaan intelektual yang terdapat pada Platform ini, termasuk melakukan modifikasi, karya turunan, mengadaptasi,menduplikasi, menyalin, menjual, membuat ulang, meretas, menjual, dan/atau mengeksploitasi Platform termasuk penggunaan Platform atas akses yang tidak sah, meluncurkan program otomatis atau script, atau segala program apapun yang mungkin menghambat operasi dan/atau kinerja Platform, atau dengan cara apapun memperbanyak atau menghindari struktur navigasi atau presentasi dari Platform atau isinya. \n \n c. Anda hanya diperbolehkan untuk menggunakan Platform semata-mata untuk kebutuhan pribadi dan tidak dapat dialihkan. \n \n d. Kami dapat mengambil tindakan hukum terhadap setiap pelanggaran yang dilakukan oleh Anda terkait dengan hak kekayaan intelektual terkait Platform.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                '8. IKLAN',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Platform dapat memuat iklan mengenai produk dan/atau layanan yang disediakan oleh pihak ketiga (“Iklan”). Seluruh informasi mengenai Iklan disediakan oleh pengiklan. Kami tidak memberikan dukungan (endorsement) atas Iklan mana pun. Komunikasi atau transaksi Anda dengan pengiklan dan setiap syarat, ketentuan, jaminan atau pernyataan yang terkait dengan transaksi tersebut semata – mata merupakan hubungan antara Anda dengan pengiklan tersebut.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),

              const Text(
                '9. PEMBERITAHUAN',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "a. Semua pemberitahuan atau permintaan informasi atau aduan kepada Kami akan diproses jika dikirimkan ke alamat Kami di: Komplek Satwika Permai ( Telkom), Blok B10.No.5, RT.09.RW.09, Kelurahan Jatiluhur, kecamatan Jatiasih, kota Bekasi, Jawa Barat 17425 ke call center Kami di: 08214 7738420.Internal\n \nb. Semua pemberitahuan atau permintaan kepada Anda akan dianggap sudah diterima oleh Anda jika dan bila:\n \n(i) Kami dapat menunjukkan bahwa pemberitahuan tersebut, baik dalam bentuk fisik maupun elektronik, telah dikirimkan kepada Anda; atau\n \n(ii) Kami telah memasang pemberitahuan tersebut di Platform yang dapat diakses oleh umum.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),

              const Text(
                '10. FUNGSI PLATFORM',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Kami senantiasa melakukan upaya untuk menjaga Platform ini berfungsi dan berjalan lancar. Perlu diketahui bahwa Platform dan/atau fitur Layanan Kami dapat sewaktu-waktu tidak tersedia yang disebabkan oleh berbagai alasan,termasuk namun tidak terbatas pada keperluan pemeliharaan atau masalah teknis, dan situasi ini berada di luar kuasa kami.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),

              const Text(
                '11. PEMBEKUAN AKUN',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Anda tidak akan menggunakan Platform pada perangkat atau sistem operasi yang telah dimodifikasi diluar perangkat atau konfigurasi sistem operasi dan konfigurasi Kami. Hal ini mencakup perangkat yang telah melalui proses “rooted”atau “jail-broken”. Perangkat rooted atau jail-broken adalah perangkat yang telah dibebaskan dari pembatasan yang dikenakan oleh penyedia layanan perangkat dan yang dimanufaktur tanpa persetujuan penyedia layanan perangkat.Penggunaan Platform pada perangkat rooted atau jail-broken dapat mengkompromisasi keamanan dan berujung pada transaksi penipuan.\n \nKami tidak bertanggung jawab atas pengunduhan dan penggunaan Platform pada perangkat rooted atau jail-broken dan resiko penggunaan anda terhadap perangkat rooted atau jail-broken sepenuhnya adalah resiko Anda. Anda mengerti dan setuju bahwa Kami tidak bertanggung jawab atas segala kehilangan atau setiap konsekuensi lain yang diderita atau disebabkan oleh anda sebagai akibat dari penggunaan Platform pada perangkat rooted atau jail-brokendan Kami mempunyai diskresi untuk menghentikan penggunaan Anda terhadap Platform pada perangkat rooted ataujail-broken dan memblokir perangkat rooted atau jail-broken untuk menggunakan Platform.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),

              const Text(
                '12. Layanan Pengaduan Konsumen Direktorat Jenderal Perlindungan Konsumen dan Tata Tertib Niaga Kementerian Perdagangan RI',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                children: const [
                   Text(
                    "Nomor Whatsapp Ditjen PTKN:",
                    style: TextStyle(fontSize: 14, height: 1.8),
                  ),
                  Text(
                    " +62 853 1111 1010",
                    style: TextStyle(fontSize: 14,height: 1.8, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),

              const Text(
                '13. PENGHAPUSAN AKUN',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "a. Anda dapat melakukan penghapusan akun Anda dengan mengakses fitur Delete My Account.\n \nb. Anda dapat menghapus profil yang dibuat di bawah akun Anda dengan mengakses langsung pada setiap profil yangingin Anda hapus.\n \nc. Dalam hal penghapusan profil sebagaimana dimaksud pada poin 13\n(b) di atas, tergantung pada alasan penghapusanyang Anda pilih, informasi dan data yang terdapat pada profil yang dihapus akan:\n \n(i) Dihapus secara permanen; atau\n \n(ii) Disatukan dengan data yang disimpan pada profil lainnya yang berada di bawah akun Anda.\n \nd. Dengan tunduk pada poin 13(c.i.) di atas, Anda memahami bahwa setelah akun Anda atau profil manapun yang dibuat di bawah akun Anda dihapus, maka akun Anda atau profil manapun yang dibuat di bawah akun Anda(termasuk seluruh riwayat transaksi dan seluruh layanan di dalamnya) akan terhapus selamanya dan tidak dapat dipulihkan kembali oleh Anda karena alasan apapun.\n \ne. Akun Anda dapat dibekukan untuk sementara waktu atau dapat dibekukan secara permanen karena hal-hal, termasuk namun tidak terbatas pada, sebagai berikut:\n \n(i) Laporan Anda bahwa akun Anda digunakan atau diduga digunakan atau disalahgunakan oleh orang lain;\n \n(ii) Laporan Anda bahwa telepon genggam atau tablet pribadi Anda hilang, dicuri atau diretas;\n \n(iii) Kami mengetahui atau mempunyai alasan yang cukup untuk menduga bahwa akun Anda telah dialihkan atau digunakan oleh orang lain\n \n(iv) Kami mengetahui atau dengan alasan yang cukup menduga bahwa telah terjadi hal-hal yang menurut pandanganKami telah atau dapat merugikan Kami, Anda, Penyedia Layanan atau pihak lainnya;\n \n(v) Kami mengetahui atau dengan alasan yang cukup menduga bahwa anda telah mendaftar atau masuk dalam banyak akun dalam satu perangkat untuk tujuan melanggaran Ketentuan Penggunaan, Kebijakan Privasi atau hukum yang berlaku di Indonesia;\n \n(vi) Sistem Kami mendeteksi adanya tindakan yang tidak wajar dari penggunaan akun Anda atau adanya kewajiban berdasarkan Ketentuan Penggunaan, dan/atau Kebijakan Privasi yang tidak dipenuhi oleh Anda;\n \n(vii) Anda telah meninggal dunia, ditempatkan di bawah perwalian atau pengampuan atau mengalami ketidakmampuan lainnya yang menjadikan Anda tidak cakap hukum berdasarkan peraturan perundang-undangan yang berlaku;\n \n(viii) Penggunaan Platform atau Layanan oleh Anda atau pihak lain (yang menggunakan akun Anda) dengan carayang bertentangan dengan Ketentuan Penggunaan ini, Kebijakan Privasi atau peraturan perundang-undangan yang berlaku; dan/atau\n \n(ix) Perintah untuk pembekuan akun, baik sementara atau permanen, yang diterbitkan oleh institusi pemerintah atau moneter terkait atau berdasarkan perintah pengadilan yang diterbitkan sesuai dengan peraturan perundang-undanganyang berlaku.Jika akun Anda dibekukan dan Anda memiliki bukti yang jelas bahwa akun Anda seharusnya tidak dibekukan, Anda dapat membuat Laporan kepada Kami untuk menyampaikan bukti-bukti tersebut. Setelah melakukan pemeriksaan lebih lanjut terhadap Laporan Anda, Kami akan, atas kebijakan Kami sepenuhnya, menentukan untuk mengakhiri atau melanjutkan pembekuan terhadap Akun Anda. Pembekuan tidak akan diteruskan secara tidak wajar apabila Kami memutuskan bahwa hal-hal yang mengakibatkan terjadinya pembekuan telah diselesaikan.",
                style: TextStyle(fontSize: 14, height: 1.8),
              ),
              const SizedBox(
                height: 10.0,
              ),

              const Text(
                '14. PENUTUP',
                style: TextStyle(
                  fontSize: 14,height: 1.8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "a. Ketentuan Penggunaan ini diatur dan ditafsirkan serta dilaksanakan berdasarkan hukum yang berlaku di Negara Republik Indonesia dan Anda dengan tegas menyetujui bahwa bahwa ketentuan Pasal 1266 Kitab Undang-Undang Hukum Perdata dan ketentuan lainnya yang mewajibkan adanya pengesahan atau persetujuan pengadilan untuk dapat mengakhiri Ketentuan Penggunaan tidak berlaku terhadap Ketentuan Penggunaan ini.\n \nb. Segala sengketa yang berkaitan dengan Ketentuan Penggunaan ini, diselesaikan secara musyawarah untuk mufakat atau melalui Badan Arbitrase Nasional Indonesia (BANI), sesuai dengan prosedur yang berlaku di BANI. Apabila kedua belah pihak tidak sepakat untuk menyelesaikannya sengketa di BANI, maka sengketa akan diselesaikan melalui Pengadilan Negeri.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Obx(
              //       () => Checkbox(
              //         value: loginC.rememberme.value,
              //         onChanged: (value) {
              //           loginC.rememberme.toggle();
              //         },
              //       ),
              //     ),
              //     Text('Setuju & Lanjutkan')
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 20.0),
                child: ButtonGradient(
                          label: 'Setuju',
                          onPressed: () {
                            Get.back();
                            // Get.toNamed(Routes.BOTTOM_NAVIGATION);
                          }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // const Text(
              //   'SYARAT DAN KETENTUAN PENGGUNAAN BionMed',
              //   textAlign: TextAlign.center,
              // ),
              // const SizedBox(
              // height: 10.0,
              // ),
              // const Text(
              //   '(Terakhir diperbarui tanggal: 8 Maret 2023)',
              //   style: TextStyle(fontSize: 12),
              //   textAlign: TextAlign.center,
              // ),
              // const SizedBox(
              // height: 10.0,
              // ),
              // const Text(
              //   'MOHON UNTUK MEMBACA SELURUH SYARAT DAN KETENTUAN PENGGUNAAN SERTA KEBIJAKAN PRIVASI BIONMED DENGAN CERMAT DAN SAKSAMA SEBELUM MENGGUNAKAN SETIAP FITUR DAN/ATAU LAYANAN YANG TERSEDIA DALAM PLATFORM BIONMED.',
              //   style: TextStyle(fontSize: 10),
              // ),
              // const SizedBox(
              // height: 10.0,
              // ),
              // const Text(
              //   'Syarat dan Ketentuan Penggunaan BionMed (“Ketentuan Penggunaan”) ini merupakan suatu perjanjian sah terkait tata cara dan persyaratan penggunaan fitur dan/atau layanan (“Layanan”) Platform BionMed (“Platform”) antara Pengguna (“Anda”) dengan pengelola Platform, yaitu PT Cahaya Putrasakti Mandiri (“Kami”). Dengan mengunduh dan/atau memasang dan/atau menggunakan Platform dan/atau menikmati Layanan Kami, Anda setuju bahwa Anda telah membaca, memahami, mengetahui, menerima, dan menyetujui seluruh informasi, syarat-syarat, dan ketentuan-ketentuan penggunaan Platform yang terdapat dalam Ketentuan Penggunaan ini. Kami dapat mengubah ketentuan dalam Ketentuan Penggunaan ini kapan saja. Perubahan tersebut akan berlaku setelah ditampilkan di Platform. Adalah tanggung jawab Anda untuk meninjau Ketentuan Penggunaan secara teratur. Keberlanjutan Anda atas penggunaan Platform setelah adanya setiap perubahan tersebut, baik telah Anda tinjau atau tidak, akan merupakan perjanjian Anda untuk terikat oleh setiap perubahan tersebut.Apabila Anda tidak setuju terhadap salah satu, sebagian, atau seluruh isi yang tertuang dalam Ketentuan Penggunaan ini, silakan untuk menghapus Platform dalam perangkat elektronik Anda dan/atau tidak mengakses Platform dan/atau tidak menggunakan Layanan Kami. Mohon untuk dapat diperhatikan pula bahwa Ketentuan Penggunaan ini dapat diperbarui dari waktu ke waktu.',
              //   style: TextStyle(fontSize: 10),
              // ),
              // const SizedBox(
              // height: 10.0,
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _scrollDown,
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}

// ignore: must_be_immutable
class SyaratKetentuan extends StatelessWidget {
  SyaratKetentuan({
    Key? key,
    required this.imageUrl,
    required this.height,
  }) : super(key: key);

  String imageUrl;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/disclamer$imageUrl.png'))),
    );
  }
}
