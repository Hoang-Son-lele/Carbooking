package utils;

import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;

/**
 * EmailService - Handles email sending functionality
 * For Gmail SMTP, you need to enable "Less secure app access" or use App Password
 * @author
 */
public class EmailService {
    
    // Email configuration - Update these with your SMTP settings
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "broly1009a@gmail.com"; // Change this
    private static final String SMTP_PASSWORD = "bppy jwng cpfl trze"; // Change this
    private static final String FROM_EMAIL = "broly1009a@gmail.com"; // Change this
    private static final String FROM_NAME = "CARBOOK - Car Rental System";
    
    /**
     * Send verification email after registration
     * @param toEmail
     * @param username
     * @param verificationCode
     * @return true if email sent successfully
     */
    public static boolean sendVerificationEmail(String toEmail, String username, String verificationCode) {
        String subject = "Xác thực tài khoản CARBOOK";
        String htmlContent = buildVerificationEmailHTML(username, verificationCode);
        return sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Send welcome email after successful registration
     * @param toEmail
     * @param username
     * @return true if email sent successfully
     */
    public static boolean sendWelcomeEmail(String toEmail, String username) {
        String subject = "Chào mừng bạn đến với CARBOOK!";
        String htmlContent = buildWelcomeEmailHTML(username);
        return sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Send password reset email
     * @param toEmail
     * @param username
     * @param resetToken
     * @return true if email sent successfully
     */
    public static boolean sendPasswordResetEmail(String toEmail, String username, String resetToken) {
        String subject = "Yêu cầu đặt lại mật khẩu CARBOOK";
        String htmlContent = buildPasswordResetEmailHTML(username, resetToken);
        return sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Send password changed confirmation email
     * @param toEmail
     * @param username
     * @return true if email sent successfully
     */
    public static boolean sendPasswordChangedEmail(String toEmail, String username) {
        String subject = "Mật khẩu của bạn đã được thay đổi";
        String htmlContent = buildPasswordChangedEmailHTML(username);
        return sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Generate random verification code
     * @return 6-digit verification code
     */
    public static String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }
    
    /**
     * Generate random reset token
     * @return alphanumeric reset token
     */
    public static String generateResetToken() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder token = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 32; i++) {
            token.append(chars.charAt(random.nextInt(chars.length())));
        }
        return token.toString();
    }
    
    /**
     * Core method to send email
     * @param toEmail
     * @param subject
     * @param htmlContent
     * @return true if email sent successfully
     */
    private static boolean sendEmail(String toEmail, String subject, String htmlContent) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("Email sent successfully to: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.out.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Build HTML content for verification email
     */
    private static String buildVerificationEmailHTML(String username, String verificationCode) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd;'>" +
                "<h2 style='color: #4CAF50; text-align: center;'>Xác thực tài khoản CARBOOK</h2>" +
                "<p>Xin chào <strong>" + username + "</strong>,</p>" +
                "<p>Cảm ơn bạn đã đăng ký tài khoản tại CARBOOK - Hệ thống cho thuê xe.</p>" +
                "<p>Mã xác thực của bạn là:</p>" +
                "<div style='background-color: #f4f4f4; padding: 15px; text-align: center; font-size: 24px; font-weight: bold; letter-spacing: 5px; margin: 20px 0;'>" +
                verificationCode +
                "</div>" +
                "<p>Vui lòng nhập mã này để xác thực tài khoản của bạn.</p>" +
                "<p>Mã xác thực có hiệu lực trong <strong>15 phút</strong>.</p>" +
                "<p>Nếu bạn không thực hiện đăng ký này, vui lòng bỏ qua email này.</p>" +
                "<hr style='margin: 30px 0; border: none; border-top: 1px solid #ddd;'>" +
                "<p style='color: #888; font-size: 12px; text-align: center;'>© 2026 CARBOOK. All rights reserved.</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
    
    /**
     * Build HTML content for welcome email
     */
    private static String buildWelcomeEmailHTML(String username) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd;'>" +
                "<h2 style='color: #4CAF50; text-align: center;'>Chào mừng đến với CARBOOK! 🚗</h2>" +
                "<p>Xin chào <strong>" + username + "</strong>,</p>" +
                "<p>Chúc mừng bạn đã đăng ký thành công tài khoản tại CARBOOK!</p>" +
                "<p>Bạn có thể bắt đầu:</p>" +
                "<ul>" +
                "<li>Tìm kiếm và thuê xe yêu thích</li>" +
                "<li>Đăng ký xe của bạn để cho thuê</li>" +
                "<li>Quản lý đặt chỗ và thanh toán</li>" +
                "<li>Đánh giá và nhận xét dịch vụ</li>" +
                "</ul>" +
                "<div style='text-align: center; margin: 30px 0;'>" +
                "<a href='http://localhost:9999/CARBOOK' style='background-color: #4CAF50; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block;'>Bắt đầu ngay</a>" +
                "</div>" +
                "<p>Nếu bạn có bất kỳ câu hỏi nào, đừng ngại liên hệ với chúng tôi.</p>" +
                "<hr style='margin: 30px 0; border: none; border-top: 1px solid #ddd;'>" +
                "<p style='color: #888; font-size: 12px; text-align: center;'>© 2026 CARBOOK. All rights reserved.</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
    
    /**
     * Build HTML content for password reset email
     */
    private static String buildPasswordResetEmailHTML(String username, String resetToken) {
        String resetLink = "http://localhost:9999/CARBOOK/reset-password?token=" + resetToken;
        
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd;'>" +
                "<h2 style='color: #FF5722; text-align: center;'>Đặt lại mật khẩu CARBOOK</h2>" +
                "<p>Xin chào <strong>" + username + "</strong>,</p>" +
                "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn.</p>" +
                "<p>Nhấp vào nút bên dưới để đặt lại mật khẩu:</p>" +
                "<div style='text-align: center; margin: 30px 0;'>" +
                "<a href='" + resetLink + "' style='background-color: #FF5722; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block;'>Đặt lại mật khẩu</a>" +
                "</div>" +
                "<p>Hoặc sao chép link sau vào trình duyệt:</p>" +
                "<p style='background-color: #f4f4f4; padding: 10px; word-break: break-all;'>" + resetLink + "</p>" +
                "<p>Link này có hiệu lực trong <strong>1 giờ</strong>.</p>" +
                "<p><strong>Lưu ý:</strong> Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này và mật khẩu của bạn sẽ không thay đổi.</p>" +
                "<hr style='margin: 30px 0; border: none; border-top: 1px solid #ddd;'>" +
                "<p style='color: #888; font-size: 12px; text-align: center;'>© 2026 CARBOOK. All rights reserved.</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
    
    /**
     * Build HTML content for password changed confirmation email
     */
    private static String buildPasswordChangedEmailHTML(String username) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head><meta charset='UTF-8'></head>" +
                "<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>" +
                "<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd;'>" +
                "<h2 style='color: #4CAF50; text-align: center;'>Mật khẩu đã được thay đổi</h2>" +
                "<p>Xin chào <strong>" + username + "</strong>,</p>" +
                "<p>Mật khẩu tài khoản CARBOOK của bạn đã được thay đổi thành công.</p>" +
                "<p>Thời gian thay đổi: <strong>" + new java.util.Date() + "</strong></p>" +
                "<p><strong>Lưu ý bảo mật:</strong></p>" +
                "<ul>" +
                "<li>Nếu bạn thực hiện thay đổi này, bạn có thể bỏ qua email này.</li>" +
                "<li>Nếu bạn KHÔNG thực hiện thay đổi này, vui lòng liên hệ ngay với chúng tôi để bảo vệ tài khoản.</li>" +
                "</ul>" +
                "<div style='text-align: center; margin: 30px 0;'>" +
                "<a href='mailto:support@carbook.com' style='background-color: #FF5722; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block;'>Liên hệ hỗ trợ</a>" +
                "</div>" +
                "<hr style='margin: 30px 0; border: none; border-top: 1px solid #ddd;'>" +
                "<p style='color: #888; font-size: 12px; text-align: center;'>© 2026 CARBOOK. All rights reserved.</p>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}
