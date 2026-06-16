## MyGary LightNovel — QuestNode Engine

Aplikasi **Flutter + Dart murni** untuk game fiksi interaktif berbasis teks (Branching Story / Decision Making). Naskah: **\"Server Error di Negeri Sendiri\"** — kisah Raka, seorang software developer muda yang terjepit himpitan ekonomi dan harus memilih: kabur, bertahan, atau kompromi.

> Fokus utama project: **mensimulasikan Computer Science murni dengan Dart**. Semua struktur data dibangun dari nol (TANPA package eksternal), lengkap dengan OOP, polymorphism, dan algoritma rekursif.

---

## Run

```bash
# 1. Pastikan Flutter SDK terinstall (>=3.0)
flutter --version

# 2. Masuk ke folder project
cd flutter_project

# 3. Ambil dependencies
flutter pub get

# 4. Jalankan (pilih device/emulator/web)
flutter run                 # auto-pilih device
flutter run -d chrome       # web
flutter run -d windows      # desktop
flutter run -d android      # Android
flutter run -d ios          # iOS (di Mac)
```

---

## Struktur Folder (Modular)

```
lib/
├── main.dart                       # Entry point
├── theme/
│   └── app_theme.dart              # Warna, font, spacing kertas krem
│
├── models/                         # ► OOP murni
│   ├── makhluk.dart                # abstract class Makhluk
│   ├── player.dart                 # extends Makhluk, encapsulation _health/_karma
│   ├── event.dart                  # Event + DialogEvent + CombatEvent (polymorphism)
│   └── story_node.dart             # Node binary tree cerita
│
├── structures/                     # ► Struktur Data Manual (TANPA package)
│   ├── double_linked_list.dart     # History log: next + prev
│   ├── save_stack.dart             # LIFO untuk Undo
│   ├── dialog_queue.dart           # FIFO untuk dialog
│   └── inventory_bst.dart          # BST untuk inventory
│
├── engine/                         # ► Core logic
│   ├── story_builder.dart          # Bangun binary tree dari naskah .md
│   └── game_engine.dart            # Ikat semua struktur data + algoritma rekursif
│
├── screens/                        # ► UI Flutter
│   ├── home_screen.dart            # Mulai / Galeri / Keluar
│   ├── game_screen.dart            # Gameplay utama
│   └── gallery_screen.dart         # Galeri semua ending (rekursif)
│
└── widgets/                        # ► Komponen UI reusable
    ├── grid_background.dart        # Background dotted grid kertas
    ├── paper_panel.dart            # Panel kertas + paperclip emas
    ├── narrative_panel.dart        # Panel narasi
    ├── dialog_queue_panel.dart     # Panel queue dialog
    ├── choice_buttons.dart         # Tombol Decision A / B
    ├── action_bar.dart             # Undo / Redo / History / Inventory
    ├── inventory_sheet.dart        # BottomSheet inventory
    └── history_drawer.dart         # Drawer history (forward/backward)
```

---

## Requirement

### 2. OOP

| Konsep | Lokasi | Bukti |
|---|---|---|
| **Class & Object** | `models/player.dart`, `engine/game_engine.dart` | `Player`, `GameEngine`, `StoryNode` |
| **Default + Named Constructor** | `models/player.dart` | `Player(...)` + `Player.hero()` |
| **Encapsulation** (private + getter/setter validasi) | `models/player.dart` | `_health`, `_karma`, `_uang` dengan validasi clamp |
| **Inheritance** (`extends`) | `models/event.dart` | `DialogEvent extends Event`, `CombatEvent extends Event` |
| **Polymorphism** (override) | `models/event.dart`, dipanggil di `engine/game_engine.dart` (`_applyNodeEffects`) | `@override jalankanEvent(Player)` |
| **Abstract Class** (tanpa body) | `models/makhluk.dart` | `abstract class Makhluk` dengan `bernafas()` & `bergerak()` abstract |

### 3. Struktur Data

| Struktur | File | Catatan |
|---|---|---|
| **Binary Tree** | `models/story_node.dart` | `left` + `right` pointer, max 2 anak |
| **Double Linked List** | `structures/double_linked_list.dart` | `next` + `prev` pointer, scan forward & backward |
| **Stack (LIFO)** | `structures/save_stack.dart` | `push()` + `pop()` — **LIFO terjadi saat `pop()` untuk Undo** |
| **Queue (FIFO)** | `structures/dialog_queue.dart` | `_front` + `_rear` — **FIFO terjadi saat `dequeue()` menampilkan dialog** |
| **Binary Search Tree** | `structures/inventory_bst.dart` | **POINTER BST**: left < parent < right. `findNode()` O(log n) |

### 4. Algoritma Rekursif

- **`GameEngine.temukanSemuaEnding()`** di `engine/game_engine.dart` — fungsi rekursif `_telusuriLeafRekursif()` memanggil dirinya sendiri untuk menelusuri seluruh daun (leaf) binary tree cerita. **Base case**: node null atau `isEnding`/`isLeaf`. Dipakai untuk fitur **Galeri Semua Ending**.

---

## UI/UX

- Tema \"buku interaktif\" — kertas krem, paperclip emas, font serif coklat tua (gaya gambar referensi).
- **Panel teks utama** (narasi) → `NarrativePanel`
- **Panel \"Queue Dialog\"** → `DialogQueuePanel` (tombol \"Lanjut ▸\" memanggil `dequeue()`)
- **Decision A / B** → `ChoiceButtons` (memanggil `engine.pilih(kiri: true/false)`)
- **Action buttons** Undo / Redo / History / Inventory → `ActionBar`
- **Drawer History** → `HistoryDrawer` (toggle forward/backward scan DLL)
- **BottomSheet Inventory** → `InventorySheet` (in-order BST traversal)

---

## Cara Bermain

1. Tekan **Mulai** di home screen.
2. Baca narasi, dengarkan dialog karakter (tekan **Lanjut ▸** untuk FIFO dequeue baris dialog).
3. Pilih **Pilihan A** (cabang kiri) atau **Pilihan B** (cabang kanan) — alur cerita bercabang sesuai pilihan (Binary Tree).
4. Tekan **Undo** untuk membatalkan keputusan terakhir (LIFO Stack pop).
5. Tekan **History** untuk melihat jejak perjalanan (forward / backward DLL).
6. Tekan **Inventory** untuk melihat item yang dikumpulkan (BST in-order).
7. Setelah mencapai ending → buka **Galeri Ending** dari home untuk lihat semua kemungkinan ending.
"
