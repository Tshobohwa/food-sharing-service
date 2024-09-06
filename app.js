const express = require("express");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
// const itemRoutes = require("./routes/itemRoutes");
// const clientRoutes = require("./routes/clientRoutes");
// const expenseRoutes = require("./routes/expenseRoutes");
// const stockItemRoutes = require("./routes/stockItemsRoutes");

const app = express();

app.use(express.json());

app.use((req, _, next) => {
  req.createdAt = new Date().toISOString();
  console.log(`Querying ${req.originalUrl} at ${req.createdAt}`);
  next();
});

app.use("/api/v1/items", itemRoutes);
app.use("/api/v1/clients", clientRoutes);

app.all("*", (req, _, next) => {
  const err = new AppError(`route ${req.originalUrl} not found`, 404);
  next(err);
});

app.use(globalErrorHandler);

module.exports = app;
