package com.giraffpanic.android.bindings;

import android.content.Intent;
import android.content.Context;
import android.content.ActivityNotFoundException;
import android.text.Html;
import android.net.Uri;
import org.qtproject.qt5.android.bindings.QtActivity;
import android.util.Log;

public class ShareIntent
{
    // the frunction needs to return something using void as return type did not work at all.
    //Start sharing intent on Android devices
    static public void shareDialogIntent(String title, String subject, String content, QtActivity activity)
    {
        Log.v("Wingo.io", "Activating Java part..." );
        Intent share = new Intent(Intent.ACTION_SEND);
        share.setType("text/plain");
        //share.setType("image/png"); //To share an image

        share.putExtra(Intent.EXTRA_SUBJECT, subject);
        //intent.putExtra(Intent.EXTRA_STREAM, imageUri); //We can share an image (Screenshot) this way <<
        share.putExtra(Intent.EXTRA_TEXT, Html.fromHtml(content).toString());
        share.putExtra(Intent.EXTRA_HTML_TEXT, Html.fromHtml(content));
        activity.startActivity(Intent.createChooser(share, title));
//        Log.v("Wingo.io", "DONE!" );
    }
    static public void shareImageIntent(String title, String subject, String imageURL, QtActivity activity)
    {
        Log.v("Wingo.io", "Activating Java image sgaring..." );
        Intent share = new Intent(Intent.ACTION_SEND);
        Uri imageUri = Uri.parse(imageURL); //This has to be a valid path to image stored in appcache
        share.setType("image/png"); //To share an image

        share.putExtra(Intent.EXTRA_SUBJECT, subject);
        share.putExtra(Intent.EXTRA_STREAM, imageUri); //We can share an image (Screenshot) this way <<
        activity.startActivity(Intent.createChooser(share, title));
//        Log.v("Wingo.io", "DONE!" );
    }
    static public String openGPlus(String profile, QtActivity activity) {
        Log.v("Wingo.io", "Activating Google Plus Liking" );
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setClassName("com.google.android.apps.plus",
              "com.google.android.apps.plus.phone.UrlGatewayActivity");
            intent.putExtra("customAppUri", profile);
            activity.startActivity(intent);
        } catch(ActivityNotFoundException e) {
            activity.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://plus.google.com/"+profile+"/posts")));
        }
        return String.format("Called with %s", profile);
    }
    static public String openTwitter(String twtrName, QtActivity activity) {
        Log.v("Wingo.io", "Activating Twitter Liking" );
            try {
               activity.startActivity(new Intent(Intent.ACTION_VIEW,Uri.parse("twitter://user?screen_name=" + twtrName)));
            } catch (ActivityNotFoundException e) {
               activity.startActivity(new Intent(Intent.ACTION_VIEW,Uri.parse("https://twitter.com/#!/" + twtrName)));
            }
            return String.format("Called with %s", twtrName);
    }
    static public String openFaceBook(String facebookId, QtActivity activity) {
        Log.v("Wingo.io", "Activating FB Liking" );
        try{
            String facebookScheme = "fb://profile/" + facebookId;
            Intent facebookIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(facebookScheme));
            activity.startActivity(facebookIntent);
        } catch (ActivityNotFoundException e) {
            Intent facebookIntent = new Intent(Intent.ACTION_VIEW,Uri.parse("https://www.facebook.com/profile.php?id="+facebookId));
            activity.startActivity(facebookIntent);
        }
        return String.format("Called with %s", facebookId);
    }
}
