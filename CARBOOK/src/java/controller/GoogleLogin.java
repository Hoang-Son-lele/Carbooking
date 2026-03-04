/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import java.io.IOException;
import org.apache.http.client.ClientProtocolException;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import constant.Iconstant;
import utils.GoogleAccount;
/**
 *
 * @author hson5
 */
public class GoogleLogin {
       public static String getToken(String code) throws ClientProtocolException,IOException {

        String response = Request.Post(Iconstant.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", Iconstant.GOOGLE_CLIENT_ID)
                                .add("client_secret", Iconstant.GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", Iconstant.GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", Iconstant.GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute()
                .returnContent()
                .asString();

        JsonObject json = new Gson().fromJson(response, JsonObject.class);

        String accessToken =  json.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }
       
       public static GoogleAccount getUserInfo(final String accessToken) throws  ClientProtocolException,IOException{
           String link = Iconstant.GOOGLE_LINK_GET_USER_INFO + accessToken;
           String respone = Request.Get(link).execute().returnContent().asString();
           GoogleAccount googlePojo = new Gson().fromJson(respone,GoogleAccount.class);
           return googlePojo;
       }
       
}
