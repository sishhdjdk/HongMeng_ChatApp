// 引入包名

import { http } from '@kit.NetworkKit';
import { HerderType } from '../typing'
const base_url="https://50omb4fz.lc-cn-n1-shared.com";




function request(url: string, method: http.RequestMethod, params?: string, header?:HerderType | undefined):Promise<string>{
  // 每一个httpRequest对应一个HTTP请求任务，不可复用。
  let httpRequest = http.createHttp();
  let obj = header ?? {} as HerderType;

  let options:http.HttpRequestOptions = {
    method: method, // 可选，默认为http.RequestMethod.GET。
    // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定。
    header: obj,
    readTimeout: 60000, // 可选，默认为60000ms。
  }
  if(params){
    options.extraData = params;
  }
  let responseResult = httpRequest.request(// 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定。
    base_url+url,options
  );

  // let getjson: string = '';
  return responseResult.then((value: http.HttpResponse) => {
    console.log('请求状态 -- > ' + value.responseCode);
    if (value.responseCode >= 200 && value.responseCode < 300) {
      console.log("请求成功");
      let result = `${value.result}`;
      // getjson = result;
      return result;
    } else {
      console.warn(`请求失败，状态码: ${value.responseCode}`);
      // getjson = '';
      throw new Error(`HTTP error! status: ${value.responseCode}`);
    }
  }).catch((err:Error) => {
    console.error("error",JSON.stringify(err))
    httpRequest.destroy();
    // return '';
    return Promise.reject(err);
  });

}
export function get(url: string,header?:HerderType){
  return request(url, http.RequestMethod.GET,'',header)
}
export function post(url: string, params?: string,header?:HerderType){
  return request(url, http.RequestMethod.POST, params,header)
}
export function del(url: string, params?: string,header?:HerderType){
  return request(url, http.RequestMethod.DELETE, params,header)
}
export function put(url: string, params?: string){
  return request(url, http.RequestMethod.PUT, params)
}