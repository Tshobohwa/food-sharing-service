const catchAsync = require("../utils/catchAsync");
const Food = require("./../models/foodModel");

exports.getFoods = catchAsync(async (req, res) => {
  const foods = await Food.find();
  res.status(200).json({
    status: "success",
    data: {
      foods,
    },
  });
});

exports.postFood = catchAsync(async (req, res) => {
  const food = await Food.create(req.body.food);
  res.status(201).json({
    status: "success",
    data: { food },
  });
});

exports.login = catchAsync(async (req, res) => {
  const { email, password } = req.body.user;
  const user = await User.find({ email, password });
  if (!user) {
    res.status(404).json({
      status: "Not found",
      data: {
        message: "Invalid username or password",
      },
    });
  } else {
    res.status(200).json({
      status: "success",
      data: {
        user,
      },
    });
  }
});

exports.updateFood = catchAsync(async (req, res) => {
  const { id } = req.params;
  const { food } = req.body;
  const newFood = await User.findOneAndUpdate({ _id: id }, food, {
    new: true,
  });
  res.status(200).json({
    status: "success",
    data: {
      food: newFood,
    },
  });
});
