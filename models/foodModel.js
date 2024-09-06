const mongoose = require("mongoose");

const foodSchema = mongoose.Schema({
  name: {
    type: String,
    trim: true,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
  },
  claims: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
  ],
  favorites: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
  ],
  sharedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  takenBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
});

const Food = mongoose.model("Food", foodSchema);

module.exports = Food;
