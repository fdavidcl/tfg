library(mxnet)
red <- mx.symbol.Variable("data")
red <- mx.symbol.FullyConnected(data = red, num_hidden = 2)
red <- mx.symbol.Activation(data = red, act_type = "relu")
red <- mx.symbol.FullyConnected(data = red, num_hidden = 10)
red <- mx.symbol.Activation(data = red, act_type = "relu")
red <- mx.symbol.FullyConnected(data = red, num_hidden = 1)
red <- mx.symbol.LinearRegressionOutput(data = red)

# Establece la semilla aleatoria para asegurar reproducibilidad
set.seed(42)
mx.set.seed(42)

input <- data.frame(
  Cat1 = round(runif(100, min = 1, max = 10)),
  Cat2 = round(runif(100, min = 1, max = 10)))
x = t(data.matrix(input))
label <- sqrt(input$Cat1*input$Cat1 + input$Cat2*input$Cat2)
train_x <- x[,1:74]
train_y <- label[1:74]
test_x <- x[,75:100]
test_y <- label[75:100]

model <- mx.model.FeedForward.create(
  symbol = red,
  X = train_x,
  y = train_y,
  num.round = 240,
  array.layout = "colmajor",
  optimizer = "sgd",
  learning.rate = 0.015,
  momentum = 0.2,
  eval.metric = mx.metric.rmse
)
predict(model, test_x)

