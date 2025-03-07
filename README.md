# AI-Recipe-Suggester-App
 AI Recipe Suggester App
🍽️ AI Recipe Suggester App
A Flutter application that suggests recipes based on available ingredients using Spoonacular API. The app provides cooking instructions, ingredient details, and an option to buy missing items.

🚀 Features
✅ Search recipes by ingredients
✅ View detailed cooking instructions
✅ Filter recipes based on dietary preferences
✅ Beautiful and responsive UI
✅ AI-powered recipe suggestions

🛠️ Tech Stack
Flutter - UI development
Dart - Programming language
Spoonacular API - Recipe data source
Firebase (if used) - User authentication & storage
🔧 Setup Instructions
1️⃣ Clone the Repository
bash
Copy
Edit
git clone https://github.com/Nidhi-bhamare/AI-Recipe-Suggester-App.git
cd AI-Recipe-Suggester-App
2️⃣ Install Dependencies
bash
Copy
Edit
flutter pub get
3️⃣ Replace API Key
Open lib/services/api_service.dart (or wherever API calls are handled).
Replace the placeholder with your Spoonacular API key:
dart
Copy
Edit
const String apiKey = "Replace with your Spoonacular API key";
➡ Get your API key from Spoonacular.

4️⃣ Run the App
bash
Copy
Edit
flutter run
