const express = require("express");
const path = require("path");

const app = express();

const PORT = process.env.PORT || 3000;
const APP_VERSION = process.env.APP_VERSION || "1.0.0";
const ENVIRONMENT = process.env.ENVIRONMENT || "DEV";

app.use(express.json());

// Serve genuine web page
app.use(express.static(path.join(__dirname, "../public")));

// Home page
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "../public/index.html"));
});

// Health API
app.get("/api/health", (req, res) => {
    res.status(200).json({
        status: "healthy",
        application: "Node.js AKS Ingress Demo",
        version: APP_VERSION,
        environment: ENVIRONMENT,
        timestamp: new Date().toISOString()
    });
});

// Users API
app.get("/api/users", (req, res) => {
    res.status(200).json({
        users: [
            {
                id: 1,
                name: "Mukesh",
                role: "Azure DevOps Engineer"
            },
            {
                id: 2,
                name: "Amit",
                role: "Cloud Engineer"
            },
            {
                id: 3,
                name: "Rahul",
                role: "Developer"
            }
        ]
    });
});

// Products API
app.get("/api/products", (req, res) => {
    res.status(200).json({
        products: [
            {
                id: 101,
                name: "Azure",
                category: "Cloud"
            },
            {
                id: 102,
                name: "Kubernetes",
                category: "Container Orchestration"
            },
            {
                id: 103,
                name: "Terraform",
                category: "Infrastructure as Code"
            }
        ]
    });
});

// Application information
app.get("/api/info", (req, res) => {
    res.status(200).json({
        application: "Node.js AKS Ingress Demo",
        version: APP_VERSION,
        environment: ENVIRONMENT,
        platform: "Azure Kubernetes Service",
        ingress: "NGINX Ingress Controller"
    });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({
        error: "Route not found",
        path: req.originalUrl
    });
});

// Start server
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Node.js application running on port ${PORT}`);
    console.log(`Environment: ${ENVIRONMENT}`);
    console.log(`Version: ${APP_VERSION}`);
});