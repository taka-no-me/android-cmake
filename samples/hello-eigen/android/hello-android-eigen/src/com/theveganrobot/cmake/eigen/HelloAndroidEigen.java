package com.theveganrobot.cmake.eigen;

import com.theveganrobot.cmake.HelloEigen;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;


public class HelloAndroidEigen extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        TextView text = (TextView)findViewById(R.id.text);
        
        //load up text from jni.
        text.setText(new HelloEigen().helloMatrix());
    }
}