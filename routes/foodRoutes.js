const express = require("express");
const foodController = require("../controllers/FoodController");

const router = express.Router();

router.route("/").get(foodController).post(foodController.postUser);

router.route("/[:id]").patch(userController.updateUser);

module.exports = router;
