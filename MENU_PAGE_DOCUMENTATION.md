# Halaman Menu - MyGary Light Novel

## 📋 Deskripsi
Halaman menu dengan desain elegant yang menampilkan aplikasi "MyGary - LightNovel" dengan beberapa fitur dekoratif yang indah.

## 🎨 Design Specifications

### Warna yang Digunakan
- **Background Color**: `#FFFDFB` (Cream putih)
- **Text Primary**: `#6F5D49` (Brown gelap)
- **Text Secondary**: `#BDAC99` (Brown muda/taupe)
- **Accent Color**: `#F4B860` (Gold untuk paper clip)

### Tipografi
- **Font Family**: Averia Serif Libre (Google Fonts)
- Digunakan di seluruh widget di MenuScreen dengan font size yang bervariasi

### Elemen-elemen UI

#### 1. **Background Grid Pattern**
- Grid garis tipis dengan dots di perpotongan
- Warna: `#BDAC99` dengan opacity 12% untuk garis dan 25% untuk dots

#### 2. **Decorative Background Shapes**
- Dua shape rounded yang ditempatkan di corner (top-left dan bottom-right)
- Memberikan efek dekoratif elegant

#### 3. **Ornaments/Flourishes**
- Ornament di atas title (swirls pattern)
- Ornament decorative di dalam menu card

#### 4. **Paper Clip Icon**
- Positioned di top-right menu card dengan rotasi
- Warna gold (#F4B860)
- Memberikan tema "kertas/notebook"

#### 5. **Typography**
- **Title**: "MyGary" - Display Medium, 54px
- **Subtitle**: "LightNovel" - Title Large, 22px
- **Menu Items**: Variasi ukuran untuk text di card

#### 6. **Buttons**
- **Primary Button (Mulai)**: 
  - Background: `#6F5D49` (Brown)
  - Text Color: White
  - Rounded corners: 16px
  - Height: 54px
  
- **Secondary Button (Keluar)**:
  - Background: Transparent/White
  - Border: `#6F5D49` 2px
  - Text Color: `#6F5D49`
  - Rounded corners: 16px
  - Height: 54px

## 🎭 Animasi
- **Fade Transition**: Semua konten fade in saat screen loaded (1200ms)
- **Scale Transition**: 
  - Ornament top: Scale dengan elasticOut curve (1500ms)
  - Menu card: Scale dengan easeOut curve (1500ms)

## 📂 Struktur File

```
lib/
├── main.dart                    # Main entry point & QuestNodeApp
├── screens/
│   └── menu_screen.dart         # MenuScreen & Custom Painters
│       ├── MenuScreen (StatefulWidget)
│       ├── GridPatternPainter
│       ├── DecorativeShapePainter
│       ├── OrnamentPainter
│       ├── OrnamentInsidePainter
│       └── PaperClipPainter
```

## 🔄 Navigation

### Routes yang Tersedia:
- `/menu` → MenuScreen (Default Home)
- `/game` → GameScreen (Game Flow)

### Navigasi dari Menu:
- **Button "Mulai"**: `Navigator.pushReplacementNamed('/game')`
- **Button "Keluar"**: Exit app (implementasi pending)

## 🛠️ Dependencies

Tambahan dependencies di `pubspec.yaml`:
```yaml
dependencies:
  google_fonts: ^7.0.0
```

## 🚀 Running the App

```bash
cd my_gary
flutter pub get
flutter run
```

## 📝 Customization

### Mengubah Warna:
- Update nilai `Color(0xFFXXXXXX)` di MenuScreen dan Painters

### Mengubah Font:
- Font Averia Serif Libre sudah terintegrasi
- Ubah `fontFamily: 'Averia Serif Libre'` di TextStyle menjadi font lain

### Mengubah Teks:
- Title "MyGary" → ubah text di Text widget
- Subtitle "LightNovel" → ubah text di Text widget

### Mengubah Animasi:
- Ubah duration di AnimationController initialization
- Ubah curve di `Tween().drive(CurveTween())`

## ✅ Testing Checklist

- [x] MenuScreen menampilkan dengan proper layout
- [x] Background shapes dan grid pattern terlihat
- [x] Ornaments dan paper clip terender dengan benar
- [x] Buttons berfungsi sesuai (navigate ke game screen)
- [x] Font Averia Serif Libre terintegrasi
- [x] Warna-warna sesuai specification
- [x] Animasi fade dan scale berjalan smooth
- [x] No compilation errors
- [x] Navigation routes working

## 📱 Responsive Design

Layout menggunakan Flutter's built-in responsive features:
- `SafeArea` untuk menghindari notches/status bar
- `Column` dengan `MainAxisAlignment.center` untuk centering
- `Padding` dan `SizedBox` untuk spacing yang konsisten

## 🔮 Future Enhancements

- [ ] Implement exit functionality (close app properly)
- [ ] Add sound effects untuk button interactions
- [ ] Add particle effects untuk decorations
- [ ] Implement splash screen sebelum menu
- [ ] Add settings page dari menu
- [ ] Implement language selection

---

**Last Updated**: June 16, 2026  
**Version**: 1.0
