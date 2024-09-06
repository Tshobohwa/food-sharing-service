const catchAsync = require("../utils/catchAsync");
const User = require("./../models/userModel");

exports.getUsers = catchAsync(async (req, res) => {
  const users = await User.find();
  res.status(200).json({
    status: "success",
    data: {
      users,
    },
  });
});

exports.postUser = catchAsync(async (req, res) => {
  const user = await User.create(req.body.user);
  res.status(201).json({
    status: "success",
    data: { user },
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

exports.updateUser = catchAsync(async (req, res) => {
  const { id } = req.params;
  const { user } = req.body;
  const newUser = await User.findOneAndUpdate({ _id: id }, user, {
    new: true,
  });
  res.status(200).json({
    status: "success",
    data: {
      user: newUser,
    },
  });
});
