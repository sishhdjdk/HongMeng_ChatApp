import { HerderType } from '../typing'
const APPID = "50OmB4FZCbHIjcy6QEae23s6-gzGzoHsz";
const APPKEY = "lchhQcHe38nmyT39gnpN58KB";
const MASTERKEY = "9NgA6jI1rl1hDmQNF0nfrWVc";
const CONTENTTYPE = "application/json";

export const AppKeyHeader:HerderType = {
  "X-LC-Id":APPID,
  "X-LC-Key":APPKEY,
  "Content-Type":CONTENTTYPE
}

export const MasterKeyHeader:HerderType = {
  "X-LC-Id":APPID,
  "X-LC-Key":MASTERKEY + ",master",
  "Content-Type":CONTENTTYPE
}