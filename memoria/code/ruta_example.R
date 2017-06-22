# devtools::install_github("fdavidcl/ruta")
library(ruta)
library(rutavis)
data(iris)
task <- ruta.makeUnsupervisedTask("iris", data = iris, cl = 5)
print(task)

ae <- ruta.makeLearner("autoencoder",
                       hidden = c(4, 6, 3, 2, 3, 6, 4),
                       activation = NULL)
print(ae)
set.seed(42)
mxnet::mx.set.seed(42)
args <- ruta.pretrain(ae, task)
rmodel1 <- train(ae, task,
               epochs = 80,
               optimizer = "adam",
               learning.rate = 0.05
               )
rmodel2 <- train(ae, task,
                 epochs = 80,
                 optimizer = "adam",
                 learning.rate = 0.02
)

deepf1 <- ruta.deepFeatures(rmodel1, task)[,1]
deepf2 <- ruta.deepFeatures(rmodel2, task)[,1]

plot.rutaModel(rmodel1, task)
plot(rmodel2, task)

require(plotly)

plot2d <- function(model1, model2, classes, name, ...) {
  classes <- as.factor(unlist(classes))
  mm <- as.data.frame(x = model1, y = model2)
  plotly::plot_ly(
    mm, x = model1, y = model2, color = classes,
    mode = "markers", type = "scatter",
    ...
  )
}

plot2d(deepf1, deepf2, task$data[[task$cl]])
