package com.justin.person.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

/**
 * Created by Justin on 2017/10/21.
 */
public class FileUploadUtil {
    public static String upload(byte[] file,String fileName) throws IOException {
        String filePath="person/target/avatar/";
        File targetFile=new File(filePath);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }
        String wholeName=UUID.randomUUID().toString().replaceAll("-","")+fileName.substring(fileName.lastIndexOf("."));
        FileOutputStream outputStream=new FileOutputStream(filePath+wholeName);
        outputStream.write(file);
        outputStream.flush();
        outputStream.close();
        return wholeName;
    }
}
