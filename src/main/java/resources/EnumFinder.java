package resources;

import java.util.Enumeration;

/**
 * Created by mihail on 23.05.16.
 */
public class EnumFinder {

    public static boolean find(Enumeration enumeration, String string) {

        while (enumeration.hasMoreElements()) {
            if (enumeration.nextElement().equals(string))
                return true;
        }
        return false;
    }

}
