 dev.new <- function(width = 7, height = 7) { 
	platform <- sessionInfo()
	if (grepl("linux",platform)) {
		x11(width=width, height=height) 
	}else if (grepl("pc",platform)) { 
		windows(width=width, height=height) 
	      } else if (grepl("apple", platform)) { 
			quartz(width=width, height=height) 
		}
 }
