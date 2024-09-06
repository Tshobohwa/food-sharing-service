const express = require("express");
const foodController = require("../controllers/FoodController");

const router = express.Router();

router.route("/").get(foodController.getFoods).post(foodController.postFood);

router.route("/[:id]").patch(foodController.updateFood);

module.exports = router;
