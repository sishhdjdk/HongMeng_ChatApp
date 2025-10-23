// 引入
import { post } from './request';
import { REGISTER , LOGIN } from '../api/UserApi'
import { AppKeyHeader,MasterKeyHeader} from '../common/RequestHeader'
export  function register(params:string):Promise<string>{
  return post(REGISTER,params,MasterKeyHeader);
}
export  function login(params:string):Promise<string>{
  return post(LOGIN,params,MasterKeyHeader);

}