package com.theveganrobot.cmake;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;



public class HelloAndroidCMake extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        TextView text = (TextView)findViewById(R.id.text);
        //load up text from jni.
        text.setText(new HelloWorld().stringFromJNI());
    }
}