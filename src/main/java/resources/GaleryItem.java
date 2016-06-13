package resources;

/**
 * Created by mihail on 11.06.16.
 */
public class GaleryItem {
    private int id = 0;
    private int userId = 0;
    private String path = "", path2 = "", path3 = "";
    private String description, cathegory, name;

    public GaleryItem(int id, int userId, String path, String path2, String path3, String description, String cathegory, String name) {
        this.id = id;
        this.userId = userId;
        this.path = path;
        this.path2 = path2;
        this.path3 = path3;
        this.description = description;
        this.cathegory = cathegory;
        this.name = name;
    }
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getPath() {
        return path;
    }

    public String getPath2() {
        return path2;
    }

    public String getPath3() {
        return path3;
    }

    public String getDescription() {
        return description;
    }

    public String getCathegory() {
        return cathegory;
    }

    public String getName() {
        return name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public void setPath2(String path2) {
        this.path2 = path2;
    }

    public void setPath3(String path3) {
        this.path3 = path3;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCathegory(String cathegory) {
        this.cathegory = cathegory;
    }

    public void setName(String name) {
        this.name = name;
    }
}
