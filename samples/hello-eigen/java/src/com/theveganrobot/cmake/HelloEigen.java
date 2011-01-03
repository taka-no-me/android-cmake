 package com.theveganrobot.cmake;
 
 class HelloEigen {
     public native String helloMatrix();
     public static void main(String[] args) {
         System.out.println(new HelloEigen().helloMatrix());
     }
     static {
         System.loadLibrary("hello-eigen");
     }
 }
