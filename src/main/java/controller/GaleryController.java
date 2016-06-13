package controller;

import mySQLController.Query;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import resources.GaleryItem;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.List;

/**
 * Created by mihail on 08.06.16.
 */
public class GaleryController {

    private final String photoPath = LocalDateTime.now().getYear() + "" + LocalDateTime.now().getMonth() + "/";
    private final String photoPathBase = "/home/mihail/IdeaProjects/Handmaker2/src/main/webapp/galery_photos/"+photoPath;
    private String name = "", description = "", cathegory = "", photoInBase = "";
    boolean saving = false;


    public String savePhoto(HttpServletRequest request, int userId) throws Exception {
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
                photoInBase = photoPath + photo.getName();
                if (photo.getSize() > 500000) {
                    result = "Ваше фото больше чем 500 кB";
                } else if (path.exists()) {
                    result = "Фото с таким именем уже есть";
                } else if (photoInBase.length() > 50)
                result = "Название фото очень большое, сделайте до 40 символов.";
                else {
                    photo.write(path);
                    saving = true;
                    result = "Фото загружено";
                }
            } else {
                if (photo.getFieldName().equals("itemName"))
                    name = new String(photo.get());
                else if (photo.getFieldName().equals("itemDescription"))
                    description = new String(photo.get());
                else if (photo.getFieldName().equals("itemCategory"))
                    cathegory = new String(photo.get());
            }
        }
        if (saving) {
            Query query = new Query();
           result = query.createGaleryItem(userId,photoInBase,description,cathegory,name);
        }
        return result;
    }

    public List<GaleryItem> getGalaryItem(int id) throws Exception{
        Query query = new Query();
        return query.getAllUserWork(id);
    }

}
