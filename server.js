const dotenv = require("dotenv");
const mongoose = require("mongoose");
const app = require("./app");

dotenv.config({ path: "./config.env" });

let DB = process.env.DATABASE_URL_DEV.replace(
  "<PASSWORD>",
  process.env.DATABASE_PASSWORD_DEV
);

mongoose
  .connect(DB, {
    // useNewUrlParser: true,
    // useCreateIndex: true,
    // useFindAndModify: false,
    // useUnifiedTopology: true,
  })
  .then(console.log("Database connected"))
  .catch((err) => console.error(err));

let port = 3000;

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
