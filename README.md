# SwanlakeABP - Tech Review Platform

SwanlakeABP is a web and mobile-based application designed to help users explore and review the latest technologies. With so many products on the market, this platform aims to guide users in making informed decisions through community-driven insights.

## 📱 Platforms
- **Web Frontend:** React.js
- **Mobile App:** Flutter
- **Backend:** Laravel 12 (REST API)
- **Database:** MySQL
- **Development Tools:** Postman, VS Code/IntelliJ IDEA, Android Studio, XAMPP, Apache Web Server

## 🔧 Key Features
- **User Authentication:** Registration & Login
- **View Reviews:** Browse detailed product reviews
- **Search Reviews:** Search products by name
- **Filter Reviews:**
  - By Category
  - By Release Date
  - By Rating (5 - 4.5)
- **Review Comparison:** Compare product specs
- **Comment System:** Engage in discussions on each review
- **Admin Panel:**
  - Manage Reviews (CRUD)
  - Manage Users (add/edit/delete)
  - Assign admin roles

## 📁 Project Structure
- swanlake/ # Laravel Backend
- FE-Web/ # React.js Frontend
- SwanlakeMobile/ # Flutter Mobile App

## 🚀 Getting Started

- To run the backend:
```bash
cd swanlake
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
```

- To run the frontend (web):
```
cd FE-Web
npm install
npm run dev
```

- To run the frontend (mobile):
```
cd SwanlakeMobile
flutter pub get
flutter run
```

## 🔗 Repository
You can access the full project here:  
[GitHub - SwanlakeABP](https://github.com/NuhShh/SwanlakeABP)
