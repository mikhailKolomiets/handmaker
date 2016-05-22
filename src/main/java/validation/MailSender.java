package validation;

import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Created by Mihail Kolomiets
 * Date: 14.11.15.
 */

public class MailSender {

    //Now this is Virtecole support email from gmail and password it.
    final private String senderAddres = "virtecole.team@gmail.com";
    final private String passwordSA = "nlk15Fj3WS";
    public String messageOb = "";


    public void sendTo(String userEmail, String theme, String body) {
        Properties deliveryPropopties = new Properties();
        deliveryPropopties.put("mail.smtp.host", "smtp.gmail.com");
        deliveryPropopties.put("mail.smtp.port", "587");
        deliveryPropopties.put("mail.smtp.starttls.enable", "true");
        deliveryPropopties.put("mail.smtp.auth", "true");

        Session session = Session.getDefaultInstance(deliveryPropopties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderAddres, passwordSA);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(senderAddres));
            InternetAddress[] address = {new InternetAddress(userEmail)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(theme);
            msg.setSentDate(new Date());
            msg.setText(body);

            Transport.send(msg);
            messageOb = "Success send mail";
        } catch (MessagingException mex) {
            mex.printStackTrace(); // TODO from this exception
            messageOb = mex.toString();
        }
    }


}