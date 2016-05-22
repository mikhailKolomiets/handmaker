package validation;

/**
 * Created by mihail on 22.05.16.
 */
public class RegistrationValidate {
    public String message = "";

    public boolean registrationValidate(String name, String password, String confirmPassword, String town, String email) {

        if (name.length() > 30){
            message = "Длинна логина не может быть больше 30 символов.";
            return false;
        }

        if (password.length() < 6) {
            message = "Длинна пароля должна быть минимум 6 символов.";
            return false;
        }

        if (password.length() > 30) {
            message = "Длинна пароля не может быть меньше 30 символов.";
            return false;
        }

        if (!password.equals(confirmPassword)) {
            message = "Повтор пароля некорректный.";
            return false;
        }

        if (town.length() > 30) {
            message = "Длинна названия города не может превышать 30 символов.";
            return false;
        }

        if (email.length() > 30) {
            message = "Длинна email не может быть больше 30.";
            return false;
        }

        return true;
    }
}
