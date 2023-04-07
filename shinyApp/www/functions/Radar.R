library(fmsb)

# 修改后的函数
create_radarchart <- function(data, max_value, min_value, selected_rows = NULL, selected_columns = NULL, log_transform = FALSE, show_values = FALSE) {
  
  # Check if selected_rows and selected_columns are not empty
  if (length(selected_rows) == 0 || length(selected_columns) == 0) {
    return(NULL)
  }
  
  # 检查数据是否至少有3列
  if (ncol(data) < 3) {
    stop("The input data must have at least 3 columns.")
  }
  
  # 如果未指定所选行，则默认选择所有行
  if (is.null(selected_rows)) {
    selected_rows <- rownames(data)
  }
  
  # 如果未指定所选列，则默认选择所有列
  if (is.null(selected_columns)) {
    selected_columns <- colnames(data)
  }
  
  # 仅选择指定的行和列
  data <- data[selected_rows, selected_columns, drop = FALSE]
  
  # 如果需要对数变换，则对数据应用对数变换
  if (log_transform) {
    data <- log(data)
    max_value <- log(max_value)
    min_value <- log(min_value)
  }
  
  # 在数据框中添加最大值和最小值行
  data <- rbind(rep(max_value, ncol(data)), rep(min_value, ncol(data)), data)
  
  # 为新添加的最大值和最小值行分配行名
  rownames(data)[1:2] <- c("MaxValueRow", "MinValueRow")
  
  # 设置颜色和线型参数
  pcol <- "red"
  pfcol <- "lightpink"
  cglcol <- "gray"
  cglty <- 1
  axislabcol <- "red"
  
  # 创建雷达图，并设置线条颜色、填充颜色、网格线颜色、网格线类型和轴标签颜色
  radarchart(data, pcol = pcol, pfcol = pfcol, cglcol = cglcol, cglty = cglty, axislabcol = axislabcol, plwd = 2,cex.axis = 3)

  
  # 如果 show_values 为 TRUE，则在雷达图上显示数值
  if (show_values) {
    for (i in 3:nrow(data)) {
      for (j in 1:ncol(data)) {
        angle <- (j - 1) * 2 * pi / ncol(data)
        xpos <- (1 + data[i, j] / max_value) * cos(angle) * 0.5
        ypos <- (1 + data[i, j] / max_value) * sin(angle) * 0.5
        text(xpos, ypos, labels = round(data[i, j], 1), cex = 0.8, col = "black")
      }
    }
  }
}


# example

create_radarchart(subsetMarital, max_value = 72000, min_value = 500, selected_rows = c("Current Regular"), selected_columns = c("Married", "Widowed", "Never married","Divorced or separated","Living with a partner"))
