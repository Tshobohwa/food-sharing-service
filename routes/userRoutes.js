const express = require("express");
const userController = require("../controllers/userController");

const router = express.Router();

router.route("/").get(userController.getUsers).post(userController.postUser);

router.route("/login").post(userController.login);
router.route("/[:id]").patch(userController.updateUser);

module.exports = router;
