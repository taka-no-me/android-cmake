/*
 * Copyright (C) 2010 Ethan Rublee
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
#include <string>
#include <iostream>
#include <sstream>
#include <jni.h>
#include <math.h>
#include <stdexcept>

#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_theveganrobot_cmake_HelloWorld
 * Method:    stringFromJNI
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_com_theveganrobot_cmake_HelloWorld_stringFromJNI
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif


std::string helloStringStream(){
  //test string stream
  std::stringstream ss;
  ss << "JNI -- pi = " << M_PI  << "\n";
  try
  {
    throw std::runtime_error("Do exceptions work?");
  }
  catch(std::runtime_error e)
  {
    ss << "Exception caught: " << e.what() << "\nI guess they do ;)" << std::endl;
  }  
  return ss.str();
}
JNIEXPORT jstring JNICALL Java_com_theveganrobot_cmake_HelloWorld_stringFromJNI
  (JNIEnv *env, jobject obj)
{
    return env->NewStringUTF(helloStringStream().c_str());
}
