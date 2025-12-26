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


