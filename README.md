
# Ithraa

**Ithraa** is a mobile application built with **Flutter** and powered by a **Laravel API** backend with a MySQL database hosted locally using XAMPP. The platform serves as a university companion tool that helps students stay informed and connect with essential resources, while also supporting local businesses.

---

## 🚀 Features

### 🎓 For Students:
- **Authentication** (Login/Logout)
- **University Policies** – View important academic regulations
- **Emergency & Important Contacts** – Quick access to university-related contacts
- **Available Accommodation** – Browse listed places for rent
- **Available Jobs & Offers** – Find student jobs and special local offers
- **Transportation Listings** – Discover available transport options

### 🏪 For Local Business Accounts:
- **Register as a Business**
- **Add Listings** for:
  - Accommodation
  - Transport
  - Jobs & Offers

### 🛠️ For Admins:
- **Dashboard Access**
- **Review & Accept/Reject** Business Registrations
- **View Reports** on:
  - Registered Users
  - Accommodations
  - Job & Offer Listings
  - Transport Listings

---

## 📦 Setup Instructions

### 1. Backend (Laravel API)
- Clone the repo and go to the Laravel project directory
- Run `composer install`
- Copy `.env.example` to `.env` and configure DB settings for XAMPP (MySQL)
- Run `php artisan key:generate`
- Run migrations: `php artisan migrate`
- Start server: `php artisan serve`

### 2. Frontend (Flutter App)
- Run `flutter pub get`
- Configure API endpoints in your Dart services (usually in `.env` or config files)
- Connect your device/emulator and run:
  ```bash
  flutter run
  ```

---

## 📂 Project Structure

- `/ithraa_flutter` – Flutter mobile application
- `/ithraa_laravel` – Laravel backend API
