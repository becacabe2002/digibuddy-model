1. Description of the problem
* Domain: Digital Health
* Problem Statement: With the rapid digitalization of daily life, individuals spend more and more of their daily time in using digital devices (smartphones, TVs, laptop …) regardless of their purpose (entertainment, working, studying …). This situation often results in excessive or unbalanced screen time, which in turn can negatively affect people’s mental health, reduce their sleep quality and elevate their stress levels. In this project, our group will address this problem by offering users a clear visibility of how their digital habits directly impact their mental state, and encourage them to make adjustments through recommendations by our application.
* Main Users/Stakeholders:
   * The main users of this application are students and workers who spend an enormous amount of time on screens and want to improve their mental wellness as well as track their digital habits.
   * Stakeholders: University counselors or HR of companies who want to identify burnout trends in their students/employees.
* Potential Use Case:
   * A user opens our application on a weekly basis. She updates her last week's data: "Work Screen Hours: 50," "Leisure Screen Hours: 15," "Sleep Hours: 5," and "Sleep Quality: 2." The system then processes this input, predicts a Stress Level of 8.5/10, and explains to users how their low sleep quality and high work screen hours are the primary drivers of this stress. It then suggests a tailored reduction in leisure screen time to prioritize sleep recovery for the next week.
2. Justification for the problem selection
        Mental wellness is a critical issue in the modern era, where people accept to trade their mental health for a bigger portion of their day keeping their faces in front of screens. Current solutions may lack the ability to model the complex relations between many other lifestyle factors (exercise minutes, social hours) and stress levels. In our proposed solution, we will take into account various elements such as age, gender, occupation … to provide personalized stress prediction.


3. Expected system behaviour
* System Workflow:
   * Users first create an account to record their historical data.
   * They answer a survey, which will provide initial information about their demographics, digital habits and lifestyle metrics (sleep hours, sleep quality, exercise minutes per week …)
   * Then system uses a trained model to process these inputs and predicts the continuous target variable: stress level (0 - 10)
   * Finally, the app will display users' current predicted stress level, their historical stress level records and recommendation for users to improve their mental wellness.
* Success criteria: the system has intuitive visuals of correlation between user’s digital habits and their stress_level, as well as easy to follow suggestions.
4. AI/ML technique(s) and training dataset
* Technique: Our team will use Ridge Regression for the core model, which will be trained and will be able to predict the target variable “stress_level_0_10”
   * Since the dataset contains highly correlated features (Multicollinearity), it is difficult to isolate independent variables’ effects on outputs if we use standard Linear Regression. Ridge Regression introduces a penalty (L2 norm) to the cost function, allowing the model to handle  correlated inputs robustly and prevent overfitting.
* Used dataset: Digital Lifestyle Benchmark Dataset .
   * This dataset captures 3,500 synthetic participant records on how their digital lifestyle relates to mental wellness.
5. Ethical considerations
* Privacy and Sensitive Data: The system collects personal health data under user consent. All data must be stored securely and anonymously (mask with user_id)
* Bias and Fairness: The model relies on occupation and work_mode. There is a risk that the model might bias stress predictions against certain professions if the training data is unbalanced (e.g., assuming all "Software Engineers" have high stress). We must evaluate the model to ensure it remains fair across different demographics.


* Transparency: The system should clearly indicate that the "Stress Prediction" is a statistical estimate based on similar user profiles and not a medical diagnosis. The use of Ridge Regression allows us to inspect feature weights, so we can transparently tell the user why their stress was predicted to be high (e.g., "Your high stress score is strongly linked to your low sleep quality rating").


* Risk of Harm: If a user is in a mental health crisis, a low predicted stress score (due to model error) could validate their neglect of the issue. The UI must always include a disclaimer and links to professional mental health support if the predicted stress level exceeds a critical threshold.
Overal Design

1. System Design Blueprint
Architecture Pattern: "Thick Client" (Local-First) with a Stateless ML Microservice.
* The Android app is the "Brain" for user logic and history. The Python Server is a simple "Calculator" for complex math.
A. The Components
1. Frontend (Android App - Kotlin):
   * Role: User Interface, Data Storage, Logic Engine.
   * Key Tech:
      * Room Database: Stores user's history locally (Privacy compliant).
      * Recommendation Engine: A local class that reads a rules.json file to generate advice without the internet.
      * Retrofit: HTTP client to talk to the server.
2. Backend (Python API - FastAPI/Flask):
   * Role: Pure prediction. Receives inputs -> Returns Stress Score -> Forgets data.
   * Key Tech: Scikit-Learn (for the model), FastAPI (for the web server).
3. Data Artifacts (The "Bridge"):
   * model.pkl: The trained Ridge Regression model (deployed to Server).
   * rules.json: The SHAP-derived logic file (bundled into Android App).
B. The Workflow
1. Input: User enters data (Sleep: 6h, Screen: 8h) on Android.
2. Predict: Android sends data to Server -> Server returns Score: 8.2.
3. Advice: Android opens rules.json, sees "Sleep" is the #1 driver, and calculates: "Increase sleep by 2h to lower stress to 7.1."
4. Save: Android saves the Input + Score + Date to local Room DB.




2. Task List (Execution Plan)
Phase 1: Data Science & Logic (Python)
* [ ] Data Cleaning: Preprocess the "Digital Lifestyle" dataset (handle missing values, normalize numerical columns).
* [ ] Model Training: Train Ridge Regression model. Evaluate Accuracy/MSE.
* [ ] Export Model: Serialize the trained model to model.pkl.
* [ ] SHAP Analysis: Run SHAP explainer on the training set. Identify the Top 5 features.
* [ ] Create Rules: Manually create the rules.json file containing the weights and "ideal values" for those Top 5 features.
Phase 2: Backend Development (Python)
* [ ] Setup API: Create a basic FastAPI or Flask project.
* [ ] Load Model: Write code to load model.pkl into memory when the server starts.
* [ ] Create Endpoint: Build POST /predict that accepts JSON features and returns a JSON float (Stress Score).
* [ ] Test API: Use Postman or cURL to send dummy data and verify the server returns a prediction.
Phase 3: Android Development (Kotlin)
* [x] Project Setup: Create the basic Android project with the recommended package structure.
* [ ] UI Layout: Create the Input Form (Sliders/Spinners) and the Result View.
* [ ] Networking: Set up Retrofit to send POST requests to your Python server.
* [ ] Database: Define the UserHistory Entity and DAO using Android Room.
* [ ] Recommendation Logic: Write a utility class to parse rules.json from the assets folder and calculate the "best advice" based on user input.
* [ ] Dashboard: Implement a charting library (e.g., MPAndroidChart) to visualize the data stored in Room.
Phase 4: Integration & Ethics
* [ ] End-to-End Test: Run the app, get a prediction, check if the advice makes sense, and ensure data appears on the dashboard.
* [ ] Add Disclaimers: Add a visible text label: "This is a statistical estimate, not a medical diagnosis."
* [ ] Crisis Catch: Add a simple if check: If score > 9.0, show a "Seek Professional Help" button instead of standard advice.
Phase 5: CI/CD for Model Updates (MLOps) - Optional
Goal: Automate the process so that whenever you push code changes or add new training data to your repository, the system automatically retrains the model, tests it, and deploys the new version to the server.

---

Dataset metadata
* Demographic: age, gender, region, education_level, daily_role
* Digital Behavior: device_hours_per_day, phone_unlocks, notifications_per_day, social_media_mins, study_mins, physical_activity_days, sleep_hours, sleep_quality (1-5)

* Output feature: stress_level