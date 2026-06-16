// ============================================================
// engine/story_builder.dart
// ------------------------------------------------------------
// Membangun BINARY TREE alur cerita berdasarkan naskah
// \"Server Error di Negeri Sendiri\".
//
// Setiap StoryNode punya max 2 anak: left (Pilihan A), right (Pilihan B).
// Daun-daun pohon (leaf) adalah ending A, B, atau C.
// ============================================================

import '../models/story_node.dart';
import '../models/event.dart';
import '../models/player.dart';

class StoryBuilder {
  static StoryNode buildTree() {
    Player player = Player.hero();
    // ===== ENDINGS (LEAF NODES) =====
    final endingA = StoryNode(
      id: 'end_A',
      bab: 'Ending A',
      narasi:
          '${player.nama} membalas email tersebut dengan satu kata: \"Ya\". Beberapa bulan kemudian, '
          'ia berdiri di dalam MRT Singapura yang bersih dan tepat waktu. Pendapatannya stabil, '
          'tabungannya menebal, dan ia bisa membeli perangkat keras apa pun yang ia butuhkan.'
          'Namun saat jam istirahat, ia duduk sendirian di food court, menyeduh kopi kemasan '
          'yang rasanya tak senikmat Kopi Jotos di kampung halamannya. Aman secara finansial, '
          'tapi hatinya menyisakan ruang kosong bernama rindu.'
          'Ia kabur dari masalah sistemik negaranya, demi menyelamatkan masa depannya sendiri.',
      isEnding: true,
      endingKode: 'A',
      endingJudul: 'Realistis Pragmatis — Kabur Aja Dulu',
    );

    final endingB = StoryNode(
      id: 'end_B',
      bab: 'Ending B',
      narasi:
          '${player.nama} menolak tawaran tersebut. Ia memilih tetap tinggal. Satu tahun berlalu — '
          'BBM tetap mahal, kurs masih fluktuatif. Tapi ${player.nama} tidak diam.'
          'Bersama teman-temannya di kedai kopi, ia menginisiasi sebuah komunitas developer lokal '
          'dan membangun sistem open-source berbasis AI untuk membantu petani dan pedagang kecil '
          'memotong rantai tengkulak.'
          'Laptopnya masih perangkat lama. Tabungannya tipis. Tapi ada senyum puas di wajahnya. '
          'Ia memilih tidak menyerah pada sistem yang rusak — ia menciptakan sistemnya sendiri dari bawah.',
      isEnding: true,
      endingKode: 'B',
      endingJudul: 'Bertahan di Tengah Badai — Jalur Idealis',
    );

    final endingC = StoryNode(
      id: 'end_C',
      bab: 'Ending C',
      narasi:
          '${player.nama} menerima tawaran itu — tapi ia bernegosiasi untuk bekerja remote dari Indonesia. '
          'Ia kembali duduk di kedai kopi langganannya, memesan Kopi Jotos, bercanda dengan teman-temannya.'
          'Ia tinggal di tanah airnya, menikmati biaya hidup yang masih terjangkau, namun digaji '
          'dengan Dolar Singapura. Saat Rupiah melemah, daya belinya justru melonjak drastis.'
          '${player.nama} menemukan cheat code dari kelemahan negaranya. Ia berhasil \"kabur\" dari himpitan '
          'ekonomi tanpa perlu meninggalkan tanah airnya. Ia menjadi penonton yang nyaman di tengah '
          'riuhnya panggung ekonomi negaranya.',
      isEnding: true,
      endingKode: 'C',
      endingJudul: 'Kompromi Modern — Remote Worker',
    );

    // ===== LEVEL 3 (penghubung ke ending) =====
    // 3A: Membangun komunitas
    final n3A = StoryNode(
      id: 'n3A',
      bab: 'Bagian 4',
      narasi:
          'Beberapa bulan berlalu sejak ${player.nama} mengumpulkan teman-temannya di kedai kopi. Mereka mulai '
          'merancang prototipe — sebuah platform yang menghubungkan petani langsung ke konsumen kota.'
          'Di tengah antusiasme itu, email dari Singapura masih nyantol di kotak masuknya. Tenggat '
          'jawaban tinggal 3 hari. ${player.nama} harus memutuskan: lanjut idealisme penuh, atau ambil jalan tengah?',
      pilihanA: 'Tolak tawaran, fokus komunitas',
      pilihanB: 'Negosiasi jadi remote worker',
      events: [
        DialogEvent(
          judul: 'Diskusi Komunitas',
          pembicara: 'Teman Developer',
          kalimat: const [
            'Bro, kalau lo pergi, siapa yang lanjutin project ini?',
            'Tapi kita juga gak bisa nahan lo. Hidup lo, pilihan lo.',
          ],
        ),
      ],
      itemDidapat: 'Kunci Komunitas',
    );
    n3A.left = endingB;
    n3A.right = endingC;

    // 3B: Hidup pasrah
    final n3B = StoryNode(
      id: 'n3B',
      bab: 'Bagian 4',
      narasi:
          '${player.nama} memilih diam. Hari-harinya berlalu seperti air keruh — bangun, freelance, makan warteg, tidur. '
          'Sampai suatu malam, ia membuka laptopnya dan menemukan email Singapura itu masih menunggu. '
          'Mungkin ini tanda untuk berhenti pasrah?',
      pilihanA: 'Coba bertahan & bangun komunitas',
      pilihanB: 'Cari peluang remote dari Indonesia',
      events: [
        CombatEvent(judul: 'Krisis Eksistensi', damage: 15, karmaShift: -5),
      ],
    );
    n3B.left = endingB;
    n3B.right = endingC;

    // 3C: Working holiday
    final n3C = StoryNode(
      id: 'n3C',
      bab: 'Bagian 4',
      narasi:
          '${player.nama} rajin scrolling job board. Tawaran working holiday visa Australia muncul — gaji '
          'minim, tapi pengalaman luar negeri. Di saat yang sama, email Singapura masih duduk manis '
          'di kotak masuknya.',
      pilihanA: 'Berangkat ke luar negeri',
      pilihanB: 'Batalkan, fokus benahi hidup di sini',
      itemDidapat: 'Paspor',
    );
    n3C.left = endingA;
    n3C.right = endingB;

    // 3D: Email Singapura
    final n3D = StoryNode(
      id: 'n3D',
      bab: 'Bagian 4',
      narasi:
          'Email dari Singapura itu terbuka di layar. Junior Backend Engineer. Gaji SGD. Relokasi '
          'ditanggung penuh. ${player.nama} menatap layar laptopnya — laptop yang sama, tapi dunia di luarnya '
          'tiba-tiba terasa terlalu sempit. Hatinya bertarung sendiri.',
      pilihanA: 'Terima & pindah ke Singapura',
      pilihanB: 'Negosiasi remote dari Indonesia',
      events: [
        CombatEvent(judul: 'Pertarungan Batin', damage: 20, karmaShift: -10),
        DialogEvent(
          judul: 'Suara Hati',
          pembicara: 'Bisikan Diri',
          kalimat: const [
            'Lo udah cape banget di sini, kan?',
            'Tapi siapa yang akan ngebangun negeri ini kalau anak mudanya kabur semua?',
          ],
        ),
      ],
      itemDidapat: 'Email Tawaran SGD',
    );
    n3D.left = endingA;
    n3D.right = endingC;

    // ===== LEVEL 2 =====
    // 2A: Warteg keesokan harinya (jalur sosial)
    final n2A = StoryNode(
      id: 'n2A',
      bab: 'Bagian 2',
      narasi:
          'Keesokan harinya, ${player.nama} makan siang di warteg dekat kantornya. TV tabung berdebu menayangkan '
          'berita megakorupsi triliunan rupiah. Ibu warteg mendecak.'
          '${player.nama} mengunyah tempe orek perlahan. Sebagai \"kelas pekerja nanggung\", ia merasa terjepit — '
          'pajaknya ditarik penuh, fasilitas publik seadanya, uang negaranya dirampok.',
      pilihanA: 'Berempati & ajak ngobrol Ibu warteg',
      pilihanB: 'Diam, fokus makan, scroll HP',
      events: [
        DialogEvent(
          judul: 'Curhat Warteg',
          pembicara: 'Ibu Warteg',
          kalimat: const [
            'Triliunan itu nolnya berapa sih, Mas?',
            'Kita di sini nyari seratus ribu sehari aja susahnya minta ampun.',
          ],
        ),
      ],
    );
    n2A.left = n3A;
    n2A.right = n3B;

    // 2B: Tren KaburAjaDulu (jalur medsos)
    final n2B = StoryNode(
      id: 'n2B',
      bab: 'Bagian 3',
      narasi:
          'Malam harinya, ${player.nama} membuka media sosial. Lini masanya dipenuhi keluhan anak muda sebayanya. '
          'Tagar #KaburAjaDulu jadi tren — beasiswa Eropa, working holiday Australia, kerah biru Jepang.'
          'Alasannya seragam: mencari kepastian hidup.',
      pilihanA: 'Daftar working holiday visa',
      pilihanB: 'Cek email — ada notifikasi baru',
      events: [
        DialogEvent(
          judul: 'Lini Masa',
          pembicara: 'Teman SMA',
          kalimat: const [
            'Gue udah di Tokyo, bro. Sini juga capek, tapi setidaknya gajinya masuk akal.',
            '#KaburAjaDulu bukan menyerah, tapi rasional.',
          ],
        ),
      ],
    );
    n2B.left = n3C;
    n2B.right = n3D;

    // ===== ROOT (LEVEL 1) =====
    final root = StoryNode(
      id: 'n1',
      bab: 'Bagian 1',
      narasi:
          '${player.nama} duduk di sudut kedai kopi lokal langganannya, memesan segelas Kopi Jotos untuk menemani malamnya. '
          'Di layar laptopnya, barisan kode React dan Flutter menumpuk menunggu deploy.'
          'Pikirannya melayang ke tab peramban yang menampilkan harga laptop chip AI development. '
          'Tiga bulan lalu masih masuk akal — malam ini Rupiah menembus angka psikologis baru terhadap Dolar, '
          'dan harga laptop itu meroket jauh di luar tabungannya.'
          'Tiba-tiba grup WhatsApp komunitas developer ramai: \"Mulai Tengah Malam, Harga BBM Resmi Naik.\"',
      pilihanA: 'Tutup tab harga, lanjut coding',
      pilihanB: 'Buka media sosial, cek tren #KaburAjaDulu',
      events: [
        DialogEvent(
          judul: 'Gumaman ${player.nama}',
          pembicara: player.nama,
          kalimat: [
            '\"Mimpi aja dulu,\" gumam ${player.nama} sambil menutup tab tersebut.',
            'Kenaikan BBM berarti biaya server cloud, ojek daring, sampai nasi padang ikut naik besok pagi...',
          ],
        ),
      ],
      itemDidapat: 'Kopi Jotos',
    );
    root.left = n2A;
    root.right = n2B;

    return root;
  }
}
