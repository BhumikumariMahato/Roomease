package com.roomease.util;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class ImageUtil {

	public String getImageNameFromPart(Part part) {
		// Retrieve the content-disposition header from the part
		String contentDisp = part.getHeader("content-disposition");

		// Split the header by semicolons to isolate key-value pairs
		String[] items = contentDisp.split(";");

		// Initialize imageName variable to store the extracted file name
		String imageName = null;

		// Iterate through the items to find the filename
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				// Extract the file name from the header value
				imageName = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}

		// Check if the filename was not found or is empty
		if (imageName == null || imageName.isEmpty()) {
			// Assign a default file name if none was provided
			imageName = "download.png";
		}

		// Return the extracted or default file name
		return imageName;
	}

	public boolean uploadImage(Part part, String rootPath, String saveFolder, HttpServletRequest request) {
		// Save path in actual physical directory (you can customize this path)
		String uploadDir = "C:/Users/kunwa/eclipse-workspace/roomease/src/main/webapp/images/" + saveFolder;
		File fileSaveDir = new File(uploadDir);

		if (!fileSaveDir.exists() && !fileSaveDir.mkdirs()) {
			return false; // Failed to create directory
		}

		try {
			String imageName = getImageNameFromPart(part);
			part.write(uploadDir + File.separator + imageName); // Save to local file system
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	public String getSavePath(String saveFolder) {
		return "C:/Users/kunwa/eclipse-workspace/roomease/src/main/webapp/images/rooms" + saveFolder + "/";
	}
}
