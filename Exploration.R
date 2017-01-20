library(png)


filename <- "uk.png"
MyImage <- readPNG(paste("TestImages/", filename, sep = ""))

png(
  paste("TestImages/", filename, "Original.png", sep = ""),
  width = 500,
  height = 500
)
plot(1:2, type = "n")
rasterImage(MyImage, 1, 1, 2, 2)
dev.off()

MyDim <- dim(MyImage)

MyImage.border <- MyImage
MyImage.border[2:(MyDim[1] - 1), 2:(MyDim[2] - 1), 1:3] <- 0

MyImage.recon <- MyImage.border
for (i in 2:(MyDim[1] - 1)) {
  for (j in 2:(MyDim[2] - 1)) {
    MyImage.recon[i, j, ] <-
      0.5 * (((MyDim[2] - j) * MyImage.border[i, 1, ] + j * MyImage.border[i, MyDim[2], ]) /
               MyDim[2]
             +
               ((MyDim[1] - i) * MyImage.border[1, j, ] + i * MyImage.border[MyDim[1], j, ]) /
               MyDim[1]
      )
    
  }
}
png(
  paste("TestImages/", filename, "Recon.png", sep = ""),
  width = 500,
  height = 500
)
plot(1:2, type = "n")
rasterImage(MyImage.recon, 1, 1, 2, 2)
dev.off()
