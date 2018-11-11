#include <iostream>
#include <fstream>
#include "json.hpp"
//#include <vector>
//using std::vector;
using namespace std;

int main(int argc, char** argv) {


std::ifstream file;
file.open(argv[1]);
nlohmann::json jsonObject;
if(file.is_open()){
file >> jsonObject;
}

nlohmann::json result;
int global_counter = 0;
for (auto itr = jsonObject.begin();itr!= jsonObject.end(); ++itr){

if(itr.key()=="metadata"){
nlohmann::json meta;
nlohmann::json tmp;
tmp["arraySize"]=itr.value()["arraySize"];
tmp["file"]=argv[1];
tmp["numSamples"]=itr.value()["numSamples"];
tmp["samplesWithInversions"]=itr.value()["numSamples"]; 

result["metadata"]=tmp;
continue;
}

int mis_counter = 0;
nlohmann::json mis;
nlohmann::json cos;
for(int i = 0; i<itr.value().size()-1;i++){
if(itr.value()[i]>itr.value()[i+1]){
nlohmann::json element;
element.push_back(itr.value()[i]);
element.push_back(itr.value()[i+1]);
++mis_counter; 
mis[to_string(i)]=element;
}
}

if(mis_counter != 0){
cos["ConsecutiveInversions"] = mis;
cos["sample"] = itr.value();
result[itr.key()]=cos;

}

global_counter += mis_counter;



}
cout<<result<<endl;
}
