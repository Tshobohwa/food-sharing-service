const express = require("express");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
const userRoutes = require("./routes/userRoutes");
const foodRoutes = require("./routes/foodRoutes");

const app = express();

app.use(express.json());

app.use((req, _, next) => {
  req.createdAt = new Date().toISOString();
  console.log(`Querying ${req.originalUrl} at ${req.createdAt}`);
  next();
});

app.use("/api/v1/foods", foodRoutes);
app.use("/api/v1/users", userRoutes);

app.all("*", (req, _, next) => {
  const err = new AppError(`route ${req.originalUrl} not found`, 404);
  next(err);
});

app.use(globalErrorHandler);

module.exports = app;
