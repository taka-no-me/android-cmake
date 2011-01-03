/*
 * Copyright (C) 2009 The Android Open Source Project
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
#include <jni.h>
#include "HelloEigen.h"

#include <iostream>
#include <sstream>
#include <Eigen/Dense>
#include <string>

using namespace Eigen;

std::string helloMatrix(){
  //std::stringstream ss;
 // ss << "yellow " << 2.0 << std::endl;
  MatrixXd m(2,2);
  m(0,0) = 3;
  m(1,0) = 2.5;
  m(0,1) = -1;
  m(1,1) = m(1,0) + m(0,1);
  //ss << "Here is the matrix m:\n" << m << std::endl;
  VectorXd v(2);
  v(0) = 4;
  v(1) = v(0) - 1;
  //ss << "Here is the vector v:\n" << v << std::endl;
  return __PRETTY_FUNCTION__;
}
JNIEXPORT jstring JNICALL Java_com_theveganrobot_cmake_HelloEigen_helloMatrix
  (JNIEnv * env, jobject)
{
    return env->NewStringUTF( helloMatrix().c_str());
}

