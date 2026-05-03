# Rick and Morty Characters App (АРТЕМ КАПНИСТ) - самостоятельная практика создания.
Мобильное приложение на Flutter для просмотра персонажей мультсериала "Рик и Морти" с возможностью добавления в избранное и оффлайн-доступом.

## Функциональность

- 📱 Просмотр списка персонажей
- ⭐ Добавление/удаление из избранного
- 🔍 Пагинация при скролле
- 💾 Оффлайн-доступ к данным
- 🎨 Поддержка темной темы
- 📱 Адаптивный дизайн
- 😺 Возможны некоторые дополнения/изменения в будущем..
## Технологии

- **Flutter** - фреймворк для разработки
- **BLoC** - управление состоянием
- **Isar** - локальная база данных
- **Dio** - HTTP-клиент
- **Equatable** - сравнение объектов

### WEB-ВЕРСИЯ запуск в браузере
- flutter run -d chrome
- flutter run -d edge


### Требования для Android
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Android Studio (для Android сборки)
- Xcode (для iOS сборки, только на macOS)

### Сборка для Android🚀
#### APK файл (для ручной установки)

```bash
# Сборка debug версии
flutter build apk --debug

# Сборка release версии
flutter build apk --release

# Сборка с уменьшенным размером
flutter build apk --release --split-per-abi

### Шаги установки

1. Клонируйте репозиторий:
```bash
git clone https://github.com/your-username/rick-and-morty-app.git
cd rick-and-morty-app

