# 🌟 Aura Marketplace

A complete full-stack e-commerce marketplace platform built with modern technologies.

## 🚀 Tech Stack

### Backend
- **.NET 8** - Latest .NET framework
- **Clean Architecture** - CQRS pattern with MediatR
- **Entity Framework Core** - ORM for database operations
- **SQL Server** - Relational database
- **JWT Authentication** - Secure token-based auth
- **SignalR** - Real-time communication

### Frontend
- **Angular 20** - Latest Angular with standalone components
- **Tailwind CSS v3** - Utility-first styling
- **Firebase** - Authentication & Storage
- **RxJS** - Reactive programming

## ✨ Features

### Authentication
- ✅ Email/Password registration
- ✅ Phone number with OTP verification
- ✅ Google OAuth
- ✅ Facebook OAuth
- ✅ JWT token-based security

### E-commerce
- ✅ Product listings with categories
- ✅ Shopping cart (guest & user)
- ✅ Order management
- ✅ Payment integration (Stripe, PayHere)
- ✅ Coupon system
- ✅ Product reviews & ratings

### Admin Dashboard
- ✅ Dashboard with real-time stats
- ✅ User management (online/offline status)
- ✅ Product management
- ✅ Order tracking & fulfillment
- ✅ Rider management
- ✅ Commission tracking
- ✅ Dispute resolution

### Advanced Features
- ✅ Real-time chat (SignalR)
- ✅ WhatsApp-style video stories (30-sec)
- ✅ Need posts (buyer requirements)
- ✅ Auction system
- ✅ Reward tiers (Silver/Gold/Diamond)
- ✅ Multi-language support (EN, TA, SI)

## 📁 Project Structure

```
aura-marketplace/
├── backend/              # .NET 8 API
│   └── src/
│       ├── AuraMarketplace.API/
│       ├── AuraMarketplace.Application/
│       ├── AuraMarketplace.Domain/
│       └── AuraMarketplace.Infrastructure/
├── frontend/             # Angular 20 App
│   └── src/
│       └── app/
│           ├── components/
│           ├── services/
│           └── guards/
├── firebase-functions/   # Cloud Functions
├── database/            # SQL scripts
├── scripts/             # Automation scripts
└── docs/                # Documentation
```

## 🛠️ Quick Start

### Prerequisites
- Node.js 18+
- .NET 8.0 SDK
- SQL Server Express
- Angular CLI

### Backend Setup

```bash
cd backend
dotnet restore
dotnet ef database update --project src/AuraMarketplace.Infrastructure --startup-project src/AuraMarketplace.API
dotnet run --project src/AuraMarketplace.API
```

Backend runs at: `http://localhost:5000`

### Frontend Setup

```bash
cd frontend
npm install
ng serve
```

Frontend runs at: `http://localhost:4200`

### Database Setup

```bash
# Run schema creation
sqlcmd -S (localdb)\MSSQLLocalDB -d AuraMarketplace -i database/DATABASE_SCHEMA.sql

# Verify database
.\scripts\verify-database.ps1
```

## 🔑 Default Credentials

### Admin Account
```
Email: dayanasanthiran123@gmail.com
Password: Daya@0905
```

### Test User
```
Email: test@example.com
Password: Test@123
```

## 📊 Database

- **60+ Tables** - Complete e-commerce schema
- **Indexed columns** - Optimized performance
- **Foreign keys** - Data integrity
- **Soft deletes** - Data preservation

## 🔐 Security

- ✅ PBKDF2/BCrypt password hashing
- ✅ JWT token authentication
- ✅ Refresh token mechanism
- ✅ Role-based authorization
- ✅ CORS configuration
- ✅ Input validation
- ✅ SQL injection prevention

## 📱 API Endpoints

- **100+ endpoints** across 62 controllers
- RESTful design
- Swagger documentation
- Versioned APIs

## 🎨 UI/UX

- Purple/Pink gradient theme
- Fully responsive design
- Smooth animations
- Professional admin dashboard
- Mobile-first approach

## 🧪 Testing

```bash
# Run all tests
.\scripts\FINAL_TEST.ps1

# Test specific features
.\scripts\test-registration.ps1
.\scripts\test-admin-login.ps1
```

## 📚 Documentation

- [System Architecture](docs/SYSTEM_ARCHITECTURE.md)
- [Quick Start Guide](docs/setup/QUICK_START.md)
- [Deployment Checklist](docs/setup/DEPLOYMENT_CHECKLIST.md)
- [Archived Docs](docs/archive/) - Historical documentation

## 🚀 Deployment

See [Deployment Checklist](docs/setup/DEPLOYMENT_CHECKLIST.md) for production deployment guide.

## 📈 Performance

- Lazy loading routes
- Optimized bundles
- Image optimization
- Caching strategies
- Database indexing

## 🤝 Contributing

This is a complete production-ready project. For modifications:

1. Follow Clean Architecture principles
2. Maintain code quality
3. Write tests for new features
4. Update documentation

## 📄 License

Proprietary - All rights reserved

## 👨‍💻 Development Status

**Status:** ✅ Production Ready

- Backend: Complete & Tested
- Frontend: Complete & Tested
- Database: Verified & Operational
- Admin Panel: Fully Functional
- Authentication: Secure & Working

---

**Built with ❤️ for Aura Marketplace**

Last Updated: December 2024
