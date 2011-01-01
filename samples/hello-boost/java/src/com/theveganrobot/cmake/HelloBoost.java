 package com.theveganrobot.cmake;
 
 class HelloBoost {
     public native String boostMkDir();
     public static void main(String[] args) {
         System.out.println(new HelloBoost().boostMkDir());
     }
     static {
         System.loadLibrary("hello-boost");
     }
 }
