# devtools::install_github("fdavidcl/ruta")
library(ruta)
library(rutavis)
data(iris)
task <- ruta.makeUnsupervisedTask("iris", data = iris, cl = 5)
print(task)

set.seed(42)
mxnet::mx.set.seed(42)

ae <- ruta.makeLearner("autoencoder",
                       hidden = c(4, 2, 4),
                       activation = "leaky")
# args <- ruta.pretrain(ae, task)
rmodel1 <- train(
  ae,
  task,
  epochs = 80,
  optimizer = "adagrad",
  learning.rate = 0.02,
  initializer.scale = 2
)
plot(rmodel1, task)
