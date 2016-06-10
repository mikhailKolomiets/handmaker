package controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Iterator;
import java.util.List;

/**
 * Created by mihail on 08.06.16.
 */
public class GaleryController {

    private final String photoPathBase = "/home/mihail/IdeaProjects/Handmaker2/src/main/webapp/galery_photos";

    public String savePhoto(HttpServletRequest request) throws Exception{
            System.out.println(photoPathBase);
            DiskFileItemFactory factory = new DiskFileItemFactory(2000, new File(photoPathBase));
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);
            Iterator<FileItem> itemIterator = items.iterator();
            while (itemIterator.hasNext()) {
                FileItem photo = itemIterator.next();
                if(!photo.isFormField()) {
                    photo.write(new File(factory.getRepository() + "/" + photo.getName()));
                    System.out.printf("=)");
                }





        }

        return null;
    }

}
