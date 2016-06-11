package controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by mihail on 08.06.16.
 */
public class GaleryController {

    private final String photoPath = LocalDateTime.now().getYear() + "" + LocalDateTime.now().getMonth() + "/";
    private final String photoPathBase = "/home/mihail/IdeaProjects/Handmaker2/src/main/webapp/galery_photos/"+photoPath;

    public String savePhoto(HttpServletRequest request) throws Exception {
        String result = "";
        DiskFileItemFactory factory = new DiskFileItemFactory(2000, new File(photoPathBase));
        ServletFileUpload upload = new ServletFileUpload(factory);

        List<FileItem> items = upload.parseRequest(request);
        Iterator<FileItem> itemIterator = items.iterator();
        while (itemIterator.hasNext()) {
            FileItem photo = itemIterator.next();
            if (!photo.isFormField()) {
                if(!new File(photoPathBase).exists())
                    new File(photoPathBase).mkdir();
                File path = new File(photoPathBase + photo.getName());

                if (photo.getSize() > 500000) {
                    result = "Ваше фото больше чем 500 кB";
                } else if (path.exists()) {
                    result = "Фото с таким именем уже есть";
                } else {
                    photo.write(path);
                    result = "Фото загружено";
                }
            }
        }
        return result;
    }

}
