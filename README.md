# Customer Churn Prediction (Serverless Deployment)

This project demonstrates an end-to-end, serverless machine learning deployment, showcasing how a trained churn prediction model can be exposed as a scalable, cost-efficient API using AWS Lambda and API Gateway.

It highlights how machine learning models can be operationalized without managing servers, enabling real-time predictions while minimizing infrastructure overhead.

---

## 🧩 Problem Statement

Customer churn,  the rate at which customers stop doing business with a company is a major challenge across industries.

While acquiring new customers is costly, many organizations lack the ability to identify churn risk early enough to take proactive action.

The objective of this project is to predict customer churn probability and deploy the model as a serverless API, allowing businesses to integrate churn intelligence directly into applications, dashboards, and automated workflows.

---

## 🗂️ Data Source

The dataset used is a telecommunications customer dataset containing historical customer information, including:

* Demographics: Gender, Senior Citizen, Partner, Dependents

* Subscription Details: Contract type, Internet service, Payment method

* Usage & Billing: Monthly charges, tenure, total charges

* Target Variable: Churn (Yes / No)

* The dataset was cleaned and preprocessed offline in a Jupyter Notebook before model training.

---

## 🔬 Process Overview

The project follows a serverless-first ML deployment workflow, from training to production inference.

#### High-level flow:

     Data
     
     → Model Training
     
     → Model Serialization

     → Serverless Inference Logic
     
     → Docker-based Lambda
     
     → API Gateway
     
     → Real-time Predictions

---

## ⚙️ Solution Walkthrough

### 1️⃣ Data Preprocessing & Feature Engineering

* Missing values were handled appropriately.

* Categorical variables were encoded.

* Numerical features were scaled for model stability.

* Selected features included:

  * tenure
  
  * MonthlyCharges
  
  * ContractType
  
  * InternetService
  
  * PaymentMethod

All preprocessing steps were frozen and aligned with inference-time expectations.


### 2️⃣ Model Building

A Logistic Regression classifier was trained to predict churn:

* 0 → Customer will stay

* 1 → Customer will churn

The model was chosen for:

* Interpretability

* Fast inference

* Suitability for serverless execution

* Robust performance on structured tabular data


### 3️⃣ Model Evaluation

The trained model achieved:

* Accuracy: 0.82

* AUC (ROC): 0.91

* Recall: 0.87

* Precision: 0.79

These results demonstrate strong ability to identify customers at risk of churning, making the model suitable for proactive retention strategies.

---

## 🚀 Serverless Deployment Workflow

Unlike traditional server-based deployment, this project uses a **fully serverless inference architecture**, enabling automatic scaling, reduced operational overhead, and pay-per-request execution.

### Step-by-step Deployment Flow

#### 🔹 Model Serialization
- The trained model was serialized using **joblib** into a `.bin` file.
- The model artifact is treated as an **immutable inference asset**, ensuring reproducibility and consistency across deployments.

#### 🔹 Inference Logic
- A lightweight Python inference module loads the model **once per container lifecycle**.
- The inference function:
  - Accepts JSON input
  - Validates feature schema
  - Returns churn probability and classification

#### 🔹 AWS Lambda Handler
- The inference logic is wrapped inside a `lambda_handler(event, context)` function.
- The handler:
  - Parses API Gateway events
  - Invokes the prediction pipeline
  - Returns a structured JSON response

#### 🔹 Docker-based Lambda Packaging
Because `scikit-learn` is a compiled dependency, the Lambda function is deployed using a **container image**:

- AWS Lambda base image (Amazon Linux)
- Dependencies installed via **uv**
- Model artifact bundled into the image
- Deterministic and reproducible builds

#### 🔹 API Gateway Integration
- An HTTP API is created using **Amazon API Gateway**.
- A `/predict` endpoint triggers the Lambda function.
- Clients send customer attributes as JSON and receive churn predictions in real time.

#### 🔹 Observability
- Logs are captured using **Amazon CloudWatch**.
- Metrics such as latency and invocation count are monitored.
- This enables debugging, performance tuning, and cost optimization.

---

## 🧰 Technologies Used

| Category | Tools / Libraries |
|--------|------------------|
| Language | Python 3.10+ |
| Data Analysis | Pandas, NumPy |
| Modeling | Scikit-learn |
| Environment Management | uv |
| Serverless Compute | AWS Lambda |
| API Layer | Amazon API Gateway |
| Containerization | Docker |
| Image Registry | Amazon ECR |
| Monitoring | Amazon CloudWatch |
| Version Control | Git & GitHub |

---

## 🌍 Real-World Applications

### 📞 Telecommunications
- Identify subscribers likely to churn before contract renewal.
- Trigger targeted retention campaigns automatically.
- Prioritize customer support for high-risk users.

### 🏦 Banking & Fintech
- Detect declining engagement before account closure.
- Power proactive loyalty incentives and fee adjustments.
- Enhance customer lifetime value (CLV) forecasting.

### 🎮 SaaS & Gaming Platforms
- Predict subscription cancellations or inactivity.
- Trigger re-engagement offers dynamically.
- Improve churn-aware revenue forecasting.

### 🛍️ E-commerce & Retail
- Identify repeat customers at risk of churn.
- Automate personalized discounts and recommendations.
- Optimize retention-focused marketing spend.

### 💸 Crypto & Web3 Platforms
- Detect wallet inactivity or user attrition.
- Trigger staking incentives or loyalty rewards.
- Improve ecosystem retention metrics.

---

## 📈 Business Impact

By deploying this churn prediction model as a **serverless API**, organizations can:

- Increase customer retention by **10–20%**
- Reduce infrastructure costs by paying only per request
- Scale automatically with demand
- Integrate churn intelligence into real-time systems

This approach transforms machine learning from an analytical artifact into a **scalable, production-ready decision service**.
