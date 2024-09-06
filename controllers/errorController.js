const globalErrorHandler = (err, _, res, __) => {
  console.log(err);
  res.status(err.statusCode || 500).json(err);
};

module.exports = globalErrorHandler;
